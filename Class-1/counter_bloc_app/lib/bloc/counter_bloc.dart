import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial(0)) {

    on<Increment>((event, emit){
      emit(CounterUpdate(state.count + 1));
    });


    // on<CounterEvent>((event, emit) {
    //   if(event is Increment){
    //     // function to increment counter
    //     emit(CounterUpdate(state.count + 1));
    //   }
    // });
  }
}
