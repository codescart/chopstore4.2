import 'package:flutter/foundation.dart';
import 'package:chopstore/data/datasource/remote/dio/dio_client.dart';
import 'package:chopstore/data/datasource/remote/exception/api_error_handler.dart';
import 'package:chopstore/data/model/response/base/api_response.dart';
import 'package:chopstore/utill/app_constants.dart';

class NotificationRepo {
  final DioClient dioClient;

  NotificationRepo({@required this.dioClient});

  Future<ApiResponse> getNotificationList() async {
    try {
      final response = await dioClient.get('${AppConstants.NOTIFICATION_URI}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
