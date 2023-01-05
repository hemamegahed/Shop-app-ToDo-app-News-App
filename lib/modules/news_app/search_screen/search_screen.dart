import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_app/cubit/cubit.dart';
import 'package:todo_app/layout/news_app/cubit/states.dart';
import 'package:todo_app/shared/componants/componants.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFormField(
                    controller: searchController,
                    perfIcon: Icon(Icons.search),
                    textType: TextInputType.text,
                    onChange: (value){
                      NewsCubit.get(context).getSearch(value);
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return  'search must not be empty';
                      }{return null;}

                    },
                    labelText: 'Search'),
              ),
              Expanded(child: articleBuilder(list, context))

            ],
          ),
        );
      
      },
      
    );
  }
}
