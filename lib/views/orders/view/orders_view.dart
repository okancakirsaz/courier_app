import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:haydi_ekspres_dev_tools/widgets/widgets_index.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/widgets/order_widget.dart';
import '../viewmodel/orders_viewmodel.dart';

part 'components/active_orders.dart';
part 'components/courier_data.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OrdersViewModel>(
        viewModel: OrdersViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
              body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(flex: 1, child: CourierData(viewModel: model)),
                Expanded(flex: 5, child: ActiveOrders(viewModel: model)),
              ],
            ),
          ));
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }
}
