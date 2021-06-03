import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/news_block.dart';
import 'package:intl/intl.dart';

import 'news_info.dart';
void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsPage(),
    );
  }
}
 class NewsPage extends StatefulWidget {
   @override
   _NewsPageState createState() => _NewsPageState();
 }

 class _NewsPageState extends State<NewsPage> {
   final newsBlock=NewsBlock();
   @override
   void initState() {
     newsBlock.eventSink.add(NewsAction.Fetch);
    // _newsModel = API_Manager().getNews();
     super.initState();
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('News App'),
       ),
       body: Container(
         child: StreamBuilder<List<Article>>(
           stream: newsBlock.newsStream,
           builder: (context, snapshot) {
             if(snapshot.hasError){
               return Center(
                 child: Text(snapshot.error ?? 'Error'),
               );
             }
             if (snapshot.hasData) {
               return ListView.builder(
                   itemCount: snapshot.data.length,
                   itemBuilder: (context, index) {
                     var article = snapshot.data[index];
                     var formattedTime = DateFormat('dd MMM - HH:mm')
                         .format(article.publishedAt);
                     return Container(
                       height: 100,
                       margin: const EdgeInsets.all(8),
                       child: Row(
                         children: <Widget>[
                           Card(
                             clipBehavior: Clip.antiAlias,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(24),
                             ),
                             child: AspectRatio(
                                 aspectRatio: 1,
                                 child: Image.network(
                                   article.urlToImage,
                                   fit: BoxFit.cover,
                                 )),
                           ),
                           SizedBox(width: 16),
                           Flexible(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: <Widget>[
                                 Text(formattedTime),
                                 Text(
                                   article.title,
                                   overflow: TextOverflow.ellipsis,
                                   style: TextStyle(
                                       fontSize: 20,
                                       fontWeight: FontWeight.bold),
                                 ),
                                 Text(
                                   article.description,
                                   maxLines: 2,
                                   overflow: TextOverflow.ellipsis,
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     );
                   });
             } else
               return Center(child: CircularProgressIndicator());
           },
         ),
       ),
     );
   }
 }
