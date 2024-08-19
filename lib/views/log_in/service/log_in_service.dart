import 'package:haydi_ekspres_dev_tools/constants/endpoints.dart';
import 'package:haydi_ekspres_dev_tools/haydi_ekspres_dev_tools.dart';
import 'package:haydi_ekspres_dev_tools/models/code_log_in_model.dart';

import '../../../core/managers/network_manager.dart';

final class LogInService extends NetworkManager {
  Future<dynamic> logIn(CodeLogInModel data) async {
    try {
      final response = await network.post(Endpoints.instance.logInCourier,
          data: data.toJson());
      Map<String, dynamic> res = response.data;
      if (res.containsKey("message")) {
        return HttpExceptionModel.fromJson(res);
      }
      return CodeLogInModel.fromJson(res);
    } catch (e) {
      return null;
    }
  }
}
