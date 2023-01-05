import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/layout/todo_app/cubit/states.dart';
import 'package:todo_app/shared/network/lockal/cache_helper.dart';
import '../../../modules/to_do_app/archive_tasks/archive_tasks.dart';
import '../../../modules/to_do_app/done_tasks/done_tasks.dart';
import '../../../modules/to_do_app/new_tasks/newtask.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  late Database database;
  int currentIndex = 0;
  List<Widget> screen = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen()
  ];
  List<String> title = [
    'New Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void createDatabase() {
    openDatabase('Todo.db', version: 1, onCreate: (database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('error when created table ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('database open');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase(
      {required String title,
      required String date,
      required String time}) async {
    await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks (title, date, time, status) VALUES ("$title", "$date", "$time","new")')
          .then((value) {
        print('$value successful insert');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('error when insert new raw ${error.toString()}');
      });
    });
  }

   void getDataFromDatabase(database)  {

     newTasks = [];
     doneTasks = [];
     archiveTasks = [];
    emit(AppGetDatabaseLoadingState());
      database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
      });
    });
  }

  void updateData({
    required String status,
    required int id,
  }) {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseLoadingState());
    });
  }
  void deleteData({
    required int id,
  }) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseLoadingState());
    });
  }

  var fabIcon = Icon(Icons.edit);
  bool isBottomSheetShown = false;

  void changeBottomSheetState({required bool isShow, required Icon icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  bool isDark = true;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppModeState());
    } else {
      isDark = !isDark;

      CacheHelper.putData(key: 'isDark', value: isDark)
          .then((value) => emit(ChangeAppModeState()));
    }
  }
}
