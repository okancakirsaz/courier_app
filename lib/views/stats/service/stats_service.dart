import 'dart:convert';
import 'package:haydi_ekspres_dev_tools/constants/endpoints.dart';
import 'package:haydi_ekspres_dev_tools/models/order_model.dart';
import 'package:dio/dio.dart';

import '../../../core/managers/network_manager.dart';

final class StatsService extends NetworkManager {
  Future<List<OrderModel>?> getOrderLogs(
      List<String> dateRange, String accessToken) async {
    try {
      final response = await network.get(
        Endpoints.instance.getOrderLogsHub,
        queryParameters: {
          "dateRange": jsonEncode(dateRange),
        },
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );
      List asList = (response.data as List);
      if (asList.isEmpty) {
        return [];
      } else {
        return asList.map((e) => OrderModel.fromJson(e)).toList();
      }
    } catch (e) {
      return null;
    }
  }
}
