import 'package:dio/dio.dart';

class DicebearApiService {
  final Dio dio = Dio();

  Future<String> getAvatarUrl(String name) async {
    try {
      Response response =
          await dio.get('https://avatars.dicebear.com/api/male/$name.png');

      if (response.statusCode == 200) {
        return response.requestOptions.uri.toString();
      } else {
        throw Exception('Failed to load avatar');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to load avatar');
    }
  }
}
