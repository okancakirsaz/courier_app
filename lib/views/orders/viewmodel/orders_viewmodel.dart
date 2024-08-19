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

  bool isOrdersGot = false;

  final TextEditingController cancelReason = TextEditingController();

  final OrdersService service = OrdersService();

  Future<bool> getActiveOrders() async {
    //Every screen size changes this function triggering.
    //So this check saves api from over requests
    if (!isOrdersGot) {
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
      isOrdersGot = true;
      return true;
    } else {
      return true;
    }
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
      OrderModel data, String courierId) async {
    data.orderState = WaitingAcceptFromCourier.instance.text;
    data.courierId = courierId;
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
