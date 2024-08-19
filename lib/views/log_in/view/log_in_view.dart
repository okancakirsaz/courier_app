import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:haydi_ekspres_dev_tools/widgets/widgets_index.dart';
import '../../../core/base/view/base_view.dart';
import '../viewmodel/log_in_viewmodel.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LogInViewModel>(
        viewModel: LogInViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(width: 250, height: 250, child: Logo()),
                  Padding(
                    padding: PaddingConsts.instance.all20,
                    child: Text(
                      "Hub yöneticiniz tarafından atanan giriş kodunu giriniz.",
                      style: TextConsts.instance.regularBlack18,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: PaddingConsts.instance.horizontal30,
                    child: CustomTextField(
                      hintStyle: TextConsts.instance.regularBlack18,
                      style: TextConsts.instance.regularBlack18,
                      controller: model.accessCode,
                      hint: "Giriş Kodu",
                    ),
                  ),
                  Container(
                    margin: PaddingConsts.instance.top10,
                    width: 200,
                    child: CustomStateFullButton(
                      onPressed: () async => model.tryToLogIn(),
                      text: "Onayla",
                    ),
                  ),
                ],
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
