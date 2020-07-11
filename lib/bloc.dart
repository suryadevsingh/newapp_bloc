import 'dart:async';
import 'package:newapp/apiresponse.dart';
import 'package:newapp/jsonclass.dart';
import 'package:newapp/respository.dart';

class Articlesbloc {

  MovieRepository repository  = MovieRepository();

  StreamController<ApiResponse<BusinessModel>>  _articlesStreamController = StreamController<ApiResponse<BusinessModel>>();

  Stream<ApiResponse<BusinessModel>> get streamData => _articlesStreamController.stream;

//  StreamSink<List<NewsResponse>> get ArticleseData => _ArticlesStreamController.sink;




  fetchArticlesbloc()async{
    _articlesStreamController.sink.add(ApiResponse.loading("fetching latest news"));
    try{
      var news =await repository.fetchArticles();
      _articlesStreamController.sink.add(ApiResponse.completed(news));
    }catch (e){
      _articlesStreamController.sink.add(ApiResponse.error((e.toString())));
    }
  }


}
