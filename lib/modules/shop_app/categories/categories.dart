import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/cubit/cubit.dart';
import 'package:todo_app/models/shop_app/categories_model.dart';
import 'package:todo_app/shared/componants/componants.dart';

import '../../../layout/shop_app/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return buildCatItem(
                  ShopCubit.get(context).categoriesModel!.data!.data![index]);
            },
            separatorBuilder: (context, index) {
              return myDivder();
            },
            itemCount:
                ShopCubit.get(context).categoriesModel!.data!.data!.length);
      },
    );
  }

  Widget buildCatItem(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image!),
            height: 90,
            width: 90,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            model.name!,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
