abstract class BackendConfig {
  static const String baseUrl = 'http://pullpoint.ru:2022';

  static const Map<String, String> baseHeaders = {
    "Accept": "application/json",
    "content-type": "application/json",
  };

  static Map<String, String> baseHeadersWithToken({
    required String? jwt,
  }) {
    return <String, String>{
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": "Bearer $jwt",
    };
  }
}
