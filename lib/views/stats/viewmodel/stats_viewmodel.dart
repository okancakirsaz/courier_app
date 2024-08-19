import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/models/models_index.dart';
import 'package:haydi_ekspres_dev_tools/models/order_model.dart';
import 'package:haydi_ekspres_dev_tools/models/order_states.dart';
import 'package:mobx/mobx.dart';

import '../../../core/base/viewmodel/base_viewmodel.dart';
import '../../../core/init/cache/local_keys_enums.dart';
import '../service/stats_service.dart';

part 'stats_viewmodel.g.dart';

class StatsViewModel = _StatsViewModelBase with _$StatsViewModel;

abstract class _StatsViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

  final StatsService service = StatsService();

  @observable
  ObservableList<String> selectedTimeRange = ObservableList.of([]);

  @observable
  ObservableList<OrderModel> orderLogs = ObservableList.of([]);

  @observable
  int orderLogCount = 0;

  @observable
  int totalRevenue = 0;

  final TextEditingController pricePerPackage = TextEditingController();
  final TextEditingController operationArea = TextEditingController();
  final TextEditingController pricePerOverKmOfArea = TextEditingController();

  Future<void> setNewSettings() async {
    await localeManager.setStringData(
        LocaleKeysEnums.pricePerPackage.name, pricePerPackage.text);
    await localeManager.setStringData(
        LocaleKeysEnums.operationArea.name, operationArea.text);
    await localeManager.setStringData(
        LocaleKeysEnums.pricePerOverKmOfArea.name, pricePerOverKmOfArea.text);
    showSuccessDialog();
  }

  @action
  Future<bool> getOrderLogs() async {
    final List<OrderModel>? response = await service.getOrderLogs(
        selectedTimeRange.isEmpty
            ? [
                DateTime.now().toIso8601String(),
                DateTime.now().toIso8601String()
              ]
            : selectedTimeRange,
        accessToken!);
    if (response == null) {
      showErrorDialog();
      return false;
    }
    orderLogs = ObservableList.of(response.isEmpty ? [] : response);
    _fetchStates();
    return true;
  }

  _fetchStates() {
    orderLogCount = orderLogs.length;
    totalRevenue = _calculateTotalCount;
  }

  int get _calculateTotalCount {
    List<int> values = [];
    int area = int.parse(operationArea.text);
    int pricePerKm = int.parse(pricePerOverKmOfArea.text);
    int pricePerPack = int.parse(pricePerPackage.text);
    if (orderLogs.isNotEmpty) {
      for (OrderModel order in orderLogs) {
        if (order.orderState.asOrderState == Cancelled.instance &&
            !order.isCancelledFromCourier!) {
          //Nothing
        } else {
          if (order.distance != null && order.distance! > area) {
            int difference = (order.distance! - area).toInt();
            int differencePrice = pricePerKm * difference;
            values.add(pricePerPack + differencePrice);
          } else {
            values.add(pricePerPack);
          }
        }
      }
    }
    //If values empty reduce function throws error
    return values.isNotEmpty ? values.reduce((a, b) => a + b) : 0;
  }

  @action
  Future<void> pickDate() async {
    selectedTimeRange.clear();

    final DateTimeRange? range = await showDateRangePicker(
      context: viewModelContext,
      firstDate: DateTime(2024, 7, 1, 0, 0, 0, 0),
      currentDate: DateTime.now(),
      helpText: "Tarih aralığı seçiniz",
      saveText: "Kaydet",
      cancelText: "İptal",
      confirmText: "Onayla",
      fieldEndHintText: "Bitiş tarihi",
      fieldStartHintText: "Başlangıç tarihi",
      fieldEndLabelText: "Bitiş tarihi",
      fieldStartLabelText: "Başlangıç tarihi",
      lastDate: DateTime.now(),
    );

    if (range != null) {
      selectedTimeRange.add(range.start.toIso8601String());
      final DateTime endDate = range.end.copyWith(hour: 23, minute: 59);
      selectedTimeRange.add(endDate.toIso8601String());
      await getOrderLogs();
    }
  }
}
