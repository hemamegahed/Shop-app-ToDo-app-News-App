import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/componants/componants.dart';
import 'package:intl/intl.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ToDoAppHomeLayout extends StatelessWidget {
  ToDoAppHomeLayout({super.key});

  Future<String> getName() async => 'Hema Megahed';

  late var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // var cubit = AppCubit.get(context);
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppState state) {
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(AppCubit.get(context)
                    .title[AppCubit.get(context).currentIndex]),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (AppCubit.get(context).isBottomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      AppCubit.get(context).insertToDatabase(
                          title: titleController.text,
                          date: dateController.text,
                          time: timeController.text);
                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                            elevation: 20,
                            (context) => Container(
                                  color: Colors.grey[100],
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          defaultTextFormField(
                                              controller: titleController,
                                              perfIcon: const Icon(Icons.title),

                                              textType: TextInputType.text,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'title must not be empty';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              labelText: 'task title'),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          defaultTextFormField(
                                              controller: timeController,
                                              perfIcon: const Icon(
                                                  Icons.watch_later_outlined),
                                              textType: TextInputType.datetime,
                                              onTap: () {
                                                showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now())
                                                    .then((value) {
                                                  timeController.text = value!
                                                      .format(context)
                                                      .toString();
                                                });
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'time must not be empty';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              labelText: 'time date'),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          defaultTextFormField(
                                              controller: dateController,
                                              perfIcon: const Icon(
                                                  Icons.calendar_month),
                                              textType: TextInputType.datetime,
                                              onTap: () {
                                                showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime.now(),
                                                        lastDate:
                                                            DateTime.parse(
                                                                '2022-12-25'))
                                                    .then((value) {
                                                  dateController.text =
                                                      DateFormat.yMMMd()
                                                          .format(value!);
                                                });
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'date must not be empty';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              labelText: 'task date'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                        .closed
                        .then((value) {
                      AppCubit.get(context).changeBottomSheetState(
                          isShow: false, icon: const Icon(Icons.edit));
                    });
                    AppCubit.get(context).changeBottomSheetState(
                        isShow: true, icon: const Icon(Icons.add));
                  }
                },
                child: AppCubit.get(context).fabIcon,
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: 'Archive')
                ],
                currentIndex: AppCubit.get(context).currentIndex,
                onTap: (index) {
                  AppCubit.get(context).changeIndex(index);
                },
                type: BottomNavigationBarType.fixed,
              ),
              body: State is! AppGetDatabaseLoadingState
                  ? AppCubit.get(context)
                      .screen[AppCubit.get(context).currentIndex]
                  : const Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
