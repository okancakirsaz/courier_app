// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrdersViewModel on _OrdersViewModelBase, Store {
  late final _$activeOrdersAtom =
      Atom(name: '_OrdersViewModelBase.activeOrders', context: context);

  @override
  ObservableList<OrderModel> get activeOrders {
    _$activeOrdersAtom.reportRead();
    return super.activeOrders;
  }

  @override
  set activeOrders(ObservableList<OrderModel> value) {
    _$activeOrdersAtom.reportWrite(value, super.activeOrders, () {
      super.activeOrders = value;
    });
  }

  late final _$fetchNewOrderStateToApiAsyncAction = AsyncAction(
      '_OrdersViewModelBase.fetchNewOrderStateToApi',
      context: context);

  @override
  Future<void> fetchNewOrderStateToApi(OrderModel data, String courierId) {
    return _$fetchNewOrderStateToApiAsyncAction
        .run(() => super.fetchNewOrderStateToApi(data, courierId));
  }

  late final _$_OrdersViewModelBaseActionController =
      ActionController(name: '_OrdersViewModelBase', context: context);

  @override
  dynamic _listenOrderStateUpdate(OrderModel data) {
    final _$actionInfo = _$_OrdersViewModelBaseActionController.startAction(
        name: '_OrdersViewModelBase._listenOrderStateUpdate');
    try {
      return super._listenOrderStateUpdate(data);
    } finally {
      _$_OrdersViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
activeOrders: ${activeOrders}
    ''';
  }
}
