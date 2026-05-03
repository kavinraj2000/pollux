import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pollux/src/core/constants/constants.dart';
import 'package:pollux/src/core/storage/security_storage.dart';
import 'package:pollux/src/domain/api_repository.dart';

class OtpRepo {
  final SecurityStorage storage = SecurityStorage();
  final Logger log = Logger();
  final Dio dio = Dio();

  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final url = ApiRepository.baseapi + Constants.API.VERIFY_OTP;

      final data = {
        "requestname": "verify_otp",
        "data": {"phone": phone, "otp": otp},
      };

      final response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final result = response.data;

      if (result['token'] != null) {
        await storage.saveAccessToken(result['token']);
      }

      return result;
    } on DioException catch (e) {
      log.e("Dio Error: ${e.response?.data}");
      throw Exception(e.response?.data ?? "OTP verification failed");
    } catch (e) {
      log.e("Unexpected Error: $e");
      throw Exception("Something went wrong");
    }
  }
}
