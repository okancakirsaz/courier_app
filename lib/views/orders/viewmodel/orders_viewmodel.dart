import 'package:courier_app/core/init/cache/local_keys_enums.dart';
import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/models/models_index.dart';
import 'package:mobx/mobx.dart';
import '../../../core/base/viewmodel/base_viewmodel.dart';
import '../../../core/managers/web_socket_manager.dart';
import '../service/orders_service.dart';

part 'orders_viewmodel.g.dart';

class OrdersViewModel = _OrdersViewModelBase with _$OrdersViewModel;

abstract class _OrdersViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() async {}

  @observable
  ObservableList<OrderModel> activeOrders = ObservableList.of([]);

  final TextEditingController cancelReason = TextEditingController();
  CourierModel? courierData;
  @observable
  bool isWorking = false;
  final OrdersService service = OrdersService();

  Future<bool> getCourierData() async {
    final CourierModel? response = await service.getCourier(
        localeManager.getStringData(LocaleKeysEnums.id.name), accessToken!);
    if (response == null) {
      showErrorDialog();
      return false;
    }
    courierData = response;
    isWorking = courierData!.isWorking;
    return true;
  }

  @action
  Future<void> updateCourierWorkState() async {
    CourierModel updatedCourierData = courierData!;
    updatedCourierData.isWorking = !updatedCourierData.isWorking;
    final bool? response =
        await service.updateCourierWorkState(updatedCourierData, accessToken!);
    if (response == null) {
      showErrorDialog();
      return;
    }
    isWorking = response;
  }

  Future<bool> getActiveOrders() async {
    final List<OrderModel>? response = await service.getActiveOrders(
        localeManager.getStringData(LocaleKeysEnums.id.name), accessToken!);
    if (response == null) {
      showErrorDialog();
      return false;
    }
    activeOrders = ObservableList.of(response);
    for (OrderModel order in activeOrders) {
      _listenOrderStateUpdate(order);
    }
    return true;
  }

  @action
  _listenOrderStateUpdate(OrderModel data) {
    WebSocketManager.instance.webSocketReceiver(data.orderId, (newOrder) {
      final OrderModel asModel = OrderModel.fromJson(newOrder);
      int index = activeOrders.indexWhere((e) => e.orderId == asModel.orderId);
      if (_checkOrderIsDeliveredOrCancelled(asModel.orderState.asOrderState)) {
        WebSocketManager.instance.closeEvent(asModel.orderId);
      }

      activeOrders.removeAt(index);
      activeOrders.insert(index, asModel);
    });
  }

  @action
  Future<void> fetchNewOrderStateToApi(
      String newStateText, OrderModel data) async {
    data.orderState = newStateText;
    final dynamic response = await service.updateOrderState(data, accessToken!);
    if (response == null) {
      showErrorDialog();
      return;
    }
    if (response is HttpExceptionModel) {
      showErrorDialog(response.message);
      return;
    }
    //Close dialog
    navigatorPop();
  }

  Future<void> fetchNextOrderState(OrderModel data) async {
    final OrderState state = data.orderState.asOrderState;
    OrderState? nextState;
    if (state == WaitingAcceptFromCourier.instance) {
      nextState = CourierIsOnWay.instance;
    } else if (state == CourierIsOnWay.instance) {
      nextState = PackageIsOnWay.instance;
    } else if (state == PackageIsOnWay.instance) {
      //Deliver order function
      return;
    }
    await fetchNewOrderStateToApi(nextState!.text, data);
  }

  bool _checkOrderIsDeliveredOrCancelled(OrderState orderState) {
    if (orderState == PackageDelivered.instance ||
        orderState == Cancelled.instance) {
      return true;
    } else {
      return false;
    }
  }

  showCloseOrderDialog(OrdersViewModel viewModel, OrderModel data) {}
}
