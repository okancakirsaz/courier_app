import 'package:courier_app/views/orders/view/orders_view.dart';
import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/haydi_ekspres_dev_tools.dart';
import 'package:haydi_ekspres_dev_tools/models/code_log_in_model.dart';
import 'package:mobx/mobx.dart';

import '../../../core/base/viewmodel/base_viewmodel.dart';
import '../../../core/init/cache/local_keys_enums.dart';
import '../service/log_in_service.dart';

part 'log_in_viewmodel.g.dart';

class LogInViewModel = _LogInViewModelBase with _$LogInViewModel;

abstract class _LogInViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

  final TextEditingController accessCode = TextEditingController();
  final LogInService service = LogInService();

  _navigateToOrdersPage() {
    navigationManager.navigateAndRemoveUntil(const OrdersView());
  }

  Future<void> tryToLogIn() async {
    if (accessCode.text.isEmpty) {
      showErrorDialog("Lütfen mail adresine gelen erişim kodunu giriniz.");
      return;
    }

    final response = await service.logIn(CodeLogInModel(code: accessCode.text));

    if (response == null) {
      showErrorDialog();
      return;
    }

    if (response is HttpExceptionModel) {
      showErrorDialog(response.message);
      return;
    }
    await _cacheData(response);
    _navigateToOrdersPage();
  }

  Future<void> _cacheData(response) async {
    await localeManager.setStringData(
        LocaleKeysEnums.id.name, response.userId!);
    await localeManager.setStringData(
        LocaleKeysEnums.accessToken.name, response.accessToken!);
  }
}
