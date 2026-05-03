import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pollux/src/core/constants/constants.dart';
import 'package:pollux/src/domain/api_repository.dart';

class LoginRepo {
  final log = Logger();
  final dio = Dio();

  Future<void> sendotp({required String phone}) async {
    try {
      final url = ApiRepository.baseapi + Constants.API.SEND_OTP;
      log.d('LoginRepo:sendotp::$url');
      await dio.post(
        url,
        data: {
          "requestname": "send_otp",
          "data": {"phone": phone},
        },
      );
    } on DioException catch (e) {
      log.e('LoginRepo:sendotp::DioError ${e.message}');
      throw Exception(e.response?.data?['message'] ?? 'Send OTP failed');
    } catch (e) {
      log.e('LoginRepo:sendotp::error $e');
      throw Exception('Send OTP failed');
    }
  }
}
