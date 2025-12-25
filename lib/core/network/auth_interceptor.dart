import 'package:dio/dio.dart';
import '../services/token_service.dart';

class AuthInterceptor extends Interceptor {
  final TokenService _tokenService = TokenService();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get access token from secure storage
    final token = await _tokenService.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 - Token expired
    if (err.response?.statusCode == 401) {
      // Try to refresh token
      final refreshed = await _tokenService.refreshToken();

      if (refreshed) {
        // Retry the request with new token
        final options = err.requestOptions;
        final token = await _tokenService.getAccessToken();

        options.headers['Authorization'] = 'Bearer $token';

        try {
          final dio = Dio();
          final response = await dio.fetch(options);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      } else {
        // Refresh failed - logout user
        await _tokenService.clearTokens();
        // TODO: Navigate to login screen
      }
    }

    super.onError(err, handler);
  }
}
