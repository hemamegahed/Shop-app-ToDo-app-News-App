import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter_app/cubit/states.dart';


class CubitCounter extends Cubit<CounterStates> {
  CubitCounter() : super(CounterInitialState());
  int numberCount = 0;

  static CubitCounter get(context) => BlocProvider.of(context);
  void minus() {
    numberCount--;
    emit(CounterMinusState(numberCount));
  }

  void plus() {
    numberCount++;
    emit(CounterPlusState(numberCount));
  }
}
