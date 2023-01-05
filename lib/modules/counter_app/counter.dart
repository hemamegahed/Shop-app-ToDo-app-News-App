import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CubitCounter(),
      child: BlocConsumer<CubitCounter, CounterStates>(
        listener: (BuildContext context, Object? state) {

          if(state is CounterPlusState) print('plus state${state.Counter}');
          if(state is CounterMinusState) print('minus state${state.Counter}');
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Counter')),
            body: Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    onPressed: () {
                      CubitCounter.get(context).plus();
                    },
                    child: const Text(
                      'plus',
                      style: TextStyle(fontSize: 25),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    '${CubitCounter.get(context).numberCount}',
                    style: const TextStyle(fontSize: 70),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      CubitCounter.get(context).minus();
                    },
                    child: const Text(
                      'minus',
                      style: TextStyle(fontSize: 24),
                    ))
              ]),
            ),
          );
        },
      ),
    );
  }
}
