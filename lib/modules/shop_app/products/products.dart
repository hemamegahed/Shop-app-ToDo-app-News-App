import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/cubit/cubit.dart';
import 'package:todo_app/layout/shop_app/cubit/states.dart';
import 'package:todo_app/models/shop_app/home_model.dart';
import 'package:todo_app/shared/componants/componants.dart';
import 'package:todo_app/shared/componants/constance.dart';

import '../../../models/shop_app/categories_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (contexr, state) {
        if (state is ShopSuccessChangeFavoritesStates) {
          if (!state.model.status!) {
            showToast(text: state.model.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            fallback: (context) {
              return const Center(child: CircularProgressIndicator());
            },
            builder: (context) {
              return productBuilder(ShopCubit.get(context).homeModel!,
                  ShopCubit.get(context).categoriesModel!, context);
            });
      },
    );
  }

  Widget productBuilder(
          HomeModel homeModel, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: homeModel.data?.banners
                    ?.map((e) => Image(
                          image: NetworkImage('${e.image}'),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250,
                  reverse: false,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  viewportFraction: 1,
                  initialPage: 0,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Categories',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: SizedBox(
                        height: 100,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return categoryItem(
                                  categoriesModel.data!.data![index]);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 15,
                              );
                            },
                            itemCount: categoriesModel.data!.data!.length),
                      )),
                  const Text('New Products',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                mainAxisSpacing: 1,
                childAspectRatio: 1 / 1.75,
                crossAxisSpacing: 1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                    homeModel.data!.products!.length,
                    (index) => buildGridProducts(
                        homeModel.data!.products![index], context)),
              ),
            )
          ],
        ),
      );

  Widget categoryItem(DataModel model) {
    return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
      Image(
        image: NetworkImage(model.image!),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(
          width: 100,
          height: 20,
          alignment: Alignment.center,
          color: Colors.black.withOpacity(.7),
          child: Text(
            model.name!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ))
    ]);
  }

  Widget buildGridProducts(ProductsModel model, context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: const Text(
                    'Discount',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()} \$',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()} \$',
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
                          child: Icon(
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
    );
  }
}
