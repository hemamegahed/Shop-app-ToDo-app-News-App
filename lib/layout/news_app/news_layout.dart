import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_app/cubit/cubit.dart';
import 'package:todo_app/layout/news_app/cubit/states.dart';
import 'package:todo_app/shared/componants/componants.dart';

import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../modules/news_app/search_screen/search_screen.dart';
import '../todo_app/cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, states) {},
      builder: (BuildContext context, states) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App',style: Theme.of(context).textTheme.bodyText1),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                  )),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeAppMode();
                  },
                  icon:  Icon(
                    Icons.brightness_2,
                  )),
            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItem,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
