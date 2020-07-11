import 'package:newapp/baasehelperclass.dart';
import 'package:newapp/jsonclass.dart';

class MovieRepository {
  final String _apikey = "ae6c3c0f9d8e485a98fd70edcff81134";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<BusinessModel> fetchArticles() async {
    final response = await ApiBaseHelper().get(_apikey);
    return BusinessModel.fromJson(response);
  }
}
