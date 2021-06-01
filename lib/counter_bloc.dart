import 'dart:async';

enum CounterActions { Increment, Decrement, Reset }

class CounterBloc {
  int counter = 0;

  final StreamController<int> _stateStreamController = StreamController<int>();
  StreamSink<int> get counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final StreamController<CounterActions> _eventStreamController =
      StreamController<CounterActions>();
  StreamSink<CounterActions> get eventSink => _eventStreamController.sink;
  Stream<CounterActions> get eventStream => _eventStreamController.stream;

  CounterBloc() {
    eventStream.listen(
      (event) {
        if (event == CounterActions.Increment)
          counter++;
        else if (event == CounterActions.Decrement)
          counter--;
        else if (event == CounterActions.Reset) counter = 0;

        counterSink.add(counter);
      },
    );
  }
}
