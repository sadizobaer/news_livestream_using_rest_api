import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_livestream/model/newsinfo.dart';

class ApiManager{

  Future<JsonData> getData() async{
    var client = http.Client();
    var newsModel = null;

    try {
      var response = await client.get(
          'http://newsapi.org/v2/everything?q=bitcoin&from=2020-09-07&sortBy=publishedAt&apiKey=c3a7de767b1046c5856d3ffd1424a335');
      if (response.statusCode == 200) {
        print('ok');
        var jsonData = response.body;
        var jsonMap = json.decode(jsonData);
        newsModel = JsonData.fromJson(jsonMap);
        return newsModel;
      }
    }catch(Exception) {
      return newsModel;
    }
    }
  }
