import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_info.dart';
enum NewsAction {Fetch,Delete}
class NewsBlock{
  final _stateStreamController=StreamController<List<Article>>();
  StreamSink<List<Article>> get _newsSink=>_stateStreamController.sink;
  Stream<List<Article>> get newsStream=>_stateStreamController.stream;

  final _eventStreamController=StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink=>_eventStreamController.sink;
  Stream<NewsAction> get _eventStream=>_eventStreamController.stream;
  NewsBlock(){
    _eventStream.listen((event) async {
      if(event==NewsAction.Fetch){
        try {
          var news=await getNews();
          if(news!=null){
            _newsSink.add(news.articles);
          }
          else{
            _newsSink.addError('Something Went Wrong in News Api');
          }

        } on Exception catch (e) {
          _newsSink.addError('Something went Wrong');
        }
      }
    });
  }
  Future<NewsModel> getNews() async {
  var client = http.Client();
  var newsModel;
  try {
  var response = await client.get('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=a1f5a0a3f1dc4ca8afe397073b159464');
  if (response.statusCode == 200) {
  var jsonString = response.body;
  var jsonMap = json.decode(jsonString);

  newsModel = NewsModel.fromJson(jsonMap);
  }
  } catch (Exception) {
    print(Exception);

    return newsModel;
  }

  return newsModel;
  }
}