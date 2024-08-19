import 'package:flutter/material.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/managers/web_socket_manager.dart';
import '../viewmodel/landing_viewmodel.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LandingViewModel>(
        viewModel: LandingViewModel(),
        onPageBuilder: (context, model) {
          return FutureBuilder(
              future: model.init(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  return model.defaultWidget;
                }
              });
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {
          WebSocketManager.instance.disconnectFromSocket();
        });
  }
}
