// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StatsViewModel on _StatsViewModelBase, Store {
  late final _$selectedTimeRangeAtom =
      Atom(name: '_StatsViewModelBase.selectedTimeRange', context: context);

  @override
  ObservableList<String> get selectedTimeRange {
    _$selectedTimeRangeAtom.reportRead();
    return super.selectedTimeRange;
  }

  @override
  set selectedTimeRange(ObservableList<String> value) {
    _$selectedTimeRangeAtom.reportWrite(value, super.selectedTimeRange, () {
      super.selectedTimeRange = value;
    });
  }

  late final _$orderLogsAtom =
      Atom(name: '_StatsViewModelBase.orderLogs', context: context);

  @override
  ObservableList<OrderModel> get orderLogs {
    _$orderLogsAtom.reportRead();
    return super.orderLogs;
  }

  @override
  set orderLogs(ObservableList<OrderModel> value) {
    _$orderLogsAtom.reportWrite(value, super.orderLogs, () {
      super.orderLogs = value;
    });
  }

  late final _$orderLogCountAtom =
      Atom(name: '_StatsViewModelBase.orderLogCount', context: context);

  @override
  int get orderLogCount {
    _$orderLogCountAtom.reportRead();
    return super.orderLogCount;
  }

  @override
  set orderLogCount(int value) {
    _$orderLogCountAtom.reportWrite(value, super.orderLogCount, () {
      super.orderLogCount = value;
    });
  }

  late final _$totalRevenueAtom =
      Atom(name: '_StatsViewModelBase.totalRevenue', context: context);

  @override
  int get totalRevenue {
    _$totalRevenueAtom.reportRead();
    return super.totalRevenue;
  }

  @override
  set totalRevenue(int value) {
    _$totalRevenueAtom.reportWrite(value, super.totalRevenue, () {
      super.totalRevenue = value;
    });
  }

  late final _$getOrderLogsAsyncAction =
      AsyncAction('_StatsViewModelBase.getOrderLogs', context: context);

  @override
  Future<bool> getOrderLogs() {
    return _$getOrderLogsAsyncAction.run(() => super.getOrderLogs());
  }

  late final _$pickDateAsyncAction =
      AsyncAction('_StatsViewModelBase.pickDate', context: context);

  @override
  Future<void> pickDate() {
    return _$pickDateAsyncAction.run(() => super.pickDate());
  }

  @override
  String toString() {
    return '''
selectedTimeRange: ${selectedTimeRange},
orderLogs: ${orderLogs},
orderLogCount: ${orderLogCount},
totalRevenue: ${totalRevenue}
    ''';
  }
}
