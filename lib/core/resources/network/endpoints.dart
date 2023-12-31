abstract class Endpoints {
  Endpoints._();
  static const String url = 'https://jsonplaceholder.typicode.com';
  static const String apiToken = 'something';
  static const Duration connectTimeout = Duration(seconds: 60);
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const String posts = '/posts';
}
