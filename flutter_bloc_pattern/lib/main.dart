import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/counter_block.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
     var counterBlock=CounterBlock();
     @override
  void dispose() {
   counterBlock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          StreamBuilder(
              stream: counterBlock.counterStream,
              initialData: 0,
              builder: (context,snapshot){
            if(snapshot.hasError){
              print(snapshot.error);
              //return n;
            }
            return Text('${snapshot.data}');
          })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          counterBlock.eventSink.add(CounterAction.Increment);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
