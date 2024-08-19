import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

abstract class NetworkManager {
  NetworkManager() {
    fetchBaseUrl();
  }
  final Dio network = Dio();

  final String localHost = "http://localhost:3000";

  //TODO: Use base product url
  final String baseUrlProduct = "https://haydiexpress.api.com";

  fetchBaseUrl() {
    if (kDebugMode) {
      network.options.baseUrl = localHost;
    } else {
      network.options.baseUrl = localHost;
    }
    return network.options.baseUrl;
  }

  MultipartFile uploadFile(Uint8List file, String name) {
    return MultipartFile.fromBytes(
      file,
      filename: name,
      contentType: MediaType("File", name.split(".").last),
    );
  }

  Map<String, dynamic> setHeaderAccessToken(String accessToken) {
    return {'Authorization': 'Bearer $accessToken'};
  }
}
