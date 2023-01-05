import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/todo_app/cubit/states.dart';
import 'package:todo_app/shared/componants/componants.dart';

import '../../../layout/todo_app/cubit/cubit.dart';

class NewTasksScreen extends StatelessWidget {
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
          condition: AppCubit.get(context).newTasks.isNotEmpty,
          builder: (BuildContext context) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return buildTaskItem(
                      AppCubit.get(context).newTasks[index], context);
                },
                separatorBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  );
                },
                itemCount: AppCubit.get(context).newTasks.length);
          },
        );
      },
    );
  }
}
