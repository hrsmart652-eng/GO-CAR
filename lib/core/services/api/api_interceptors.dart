import 'package:dio/dio.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = CacheHelper.sharedPreferences.get(ApiKeys.token);
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }
}
