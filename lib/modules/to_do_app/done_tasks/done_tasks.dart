import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/todo_app/cubit/cubit.dart';
import '../../../layout/todo_app/cubit/states.dart';
import '../../../shared/componants/componants.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          fallback: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.menu),
                  Text('there is no tasks yet !!')
                ],
              ),
            );
          },
          condition: AppCubit.get(context).doneTasks.isNotEmpty,
          builder: (BuildContext context) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return buildTaskItem(
                      AppCubit.get(context).doneTasks[index], context);
                },
                separatorBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  );
                },
                itemCount: AppCubit.get(context).doneTasks.length);
          },
        );
      },
    );
  }
}
