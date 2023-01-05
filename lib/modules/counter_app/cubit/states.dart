abstract class CounterStates {}


class CounterInitialState extends CounterStates {}

class CounterPlusState extends CounterStates {
  final int Counter;

  CounterPlusState(this.Counter);

}
class CounterMinusState extends CounterStates {
  final int Counter;

  CounterMinusState(this.Counter);


}