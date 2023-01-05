import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/shop_app/favorites_data_model.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/componants/componants.dart';
import '../../../shared/componants/constance.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesStates,
          fallback: (context) {
            return const Center(child: CircularProgressIndicator());
          },
          builder: (context) {
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildFavoriteItem(
                      ShopCubit.get(context)
                          .favoritesModel!
                          .data!
                          .data![index]
                          .product,
                      context);
                },
                separatorBuilder: (context, index) {
                  return myDivder();
                },
                itemCount:
                    ShopCubit.get(context).favoritesModel!.data!.data!.length);
          },
        );
      },
    );
  }
}

Widget buildFavoriteItem(model, context, {bool isOldPrice = false}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model!.image!),
                width: 120,
                height: 120,
              ),
              if (model.discount != 0 && isOldPrice)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text(
                    model.discount.toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                )
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, height: 1.3),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0 && isOldPrice)
                      Text(
                        model.oldPrice.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favorite![model.id]!
                                  ? defaultColor
                                  : Colors.grey,
                          radius: 15,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
