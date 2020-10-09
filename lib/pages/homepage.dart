import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_livestream/model/newsinfo.dart';
import 'package:news_livestream/sevices/api_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<JsonData> _newsModel;

  @override
  void initState() {
    _newsModel = ApiManager().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Online News'),),
      body: Container(
        child: FutureBuilder(
          future: _newsModel,
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.articles.length,
                  itemBuilder: (context, index){
                  var article  = snapshot.data.articles[index];
                return Container(
                  margin: EdgeInsets.all(8),
                  height: 100,
                  child: Row(
                    children: <Widget>[
                      Card(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            ('${article.urlToImage}'),
                          fit: BoxFit.cover,),
                        ),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(50),
                       ),
                      ),
                      SizedBox(width: 15,),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${article.title}',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),),
                            SizedBox(height: 10,),
                            Text('${article.description}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            maxLines: 3,
                            softWrap: true,),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
            }
            else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
