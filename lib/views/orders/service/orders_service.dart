import 'package:dio/dio.dart';
import 'package:haydi_ekspres_dev_tools/constants/endpoints.dart';
import 'package:haydi_ekspres_dev_tools/haydi_ekspres_dev_tools.dart';
import 'package:haydi_ekspres_dev_tools/models/http_exception_model.dart';
import 'package:haydi_ekspres_dev_tools/models/order_model.dart';

import '../../../core/managers/network_manager.dart';

final class OrdersService extends NetworkManager {
  Future<List<OrderModel>?> getActiveOrders(
      String courierId, String accessToken) async {
    try {
      final response = await network.get(
        Endpoints.instance.getActiveOrdersCourier,
        queryParameters: {"courierId": courierId},
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );
      return (response.data as List)
          .map((e) => OrderModel.fromJson(e))
          .toList();
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> updateOrderState(OrderModel data, String accessToken) async {
    try {
      final response = await network.post(
        Endpoints.instance.updateOrderState,
        data: data.toJson(),
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );
      if (response.data != "true") {
        return HttpExceptionModel.fromJson(response.data);
      } else {
        return bool.parse(response.data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<CourierModel?> getCourier(String courierId, String accessToken) async {
    try {
      final response = await network.get(
        Endpoints.instance.getCourier,
        queryParameters: {"courierId": courierId},
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );
      return CourierModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<bool?> updateCourierWorkState(
      CourierModel courierData, String accessToken) async {
    try {
      final response = await network.patch(
        Endpoints.instance.updateCourierWorkState,
        data: courierData.toJson(),
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );
      return bool.parse(response.data);
    } catch (e) {
      return null;
    }
  }
}
