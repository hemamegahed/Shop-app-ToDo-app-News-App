import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:todo_app/shared/componants/componants.dart';

import '../favorites/favorites.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopSearchCubit(),
        child: BlocConsumer<ShopSearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultTextFormField(
                          controller: searchController,
                          perfIcon: const Icon(Icons.search),
                          textType: TextInputType.text,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'enter text to search';
                            }
                            {
                              return null;
                            }
                          },
                          onSubmit: (String text) {
                            ShopSearchCubit.get(context).search(text);
                          },
                          labelText: 'Search'),
                      const SizedBox(
                        height: 20,
                      ),
                      if (state is ShopLoadingSearchStates)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      if (state is ShopSuccessSearchStates)
                        Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return buildFavoriteItem(
                                    isOldPrice: false,
                                    ShopSearchCubit.get(context)
                                        .searchModel!
                                        .data!
                                        .data![index],
                                    context);
                              },
                              separatorBuilder: (context, index) {
                                return myDivder();
                              },
                              itemCount: ShopSearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .data!
                                  .length),
                        )
                    ],
                  ),
                ));
          },
        ));
  }
}
