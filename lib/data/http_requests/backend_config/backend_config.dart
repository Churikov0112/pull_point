abstract class BackendConfig {
  static const String baseUrl = 'http://pullpoint.ru:2022';

  static const Map<String, String> baseHeaders = {
    "Accept": "application/json",
    "content-type": "application/json",
  };
}
