import 'dart:async';
enum CounterAction {Increment,Decrement,Reset}
class CounterBlock{
  int counter;
  final _stateStreamController=StreamController<int>();
  StreamSink<int> get _counterSink=>_stateStreamController.sink;
  Stream<int> get counterStream=>_stateStreamController.stream;

  final _eventStreamController=StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink=>_eventStreamController.sink;
  Stream<CounterAction> get _eventStream=>_eventStreamController.stream;

  CounterBlock(){
     counter=0;
     _eventStream.listen((event) {
       if(event==CounterAction.Increment){
         counter++;
         print(counter);
       }
       else if(event==CounterAction.Decrement){
         counter--;
       }
       else if(event==CounterAction.Reset){
         counter=0;
       }
       _counterSink.add(counter);
     });

  }
}