import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:haydi_ekspres_dev_tools/widgets/stat_container.dart';
import 'package:haydi_ekspres_dev_tools/widgets/widgets_index.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/widgets/order_widget.dart';
import '../../orders/viewmodel/orders_viewmodel.dart';
import '../viewmodel/stats_viewmodel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

part 'components/order_logs.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<StatsViewModel>(
        viewModel: StatsViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            body: Padding(
              padding: PaddingConsts.instance.all20,
              child: OrderLogs(
                viewModel: model,
                isCourierOrderLogs: false,
              ),
            ),
          );
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }
}
