import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/cubit/cubit.dart';
import 'package:todo_app/layout/shop_app/cubit/states.dart';
import 'package:todo_app/shared/componants/componants.dart';

import '../../../shared/componants/constance.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).shopUserModel;

        emailController.text = model!.data!.email!;
        nameController.text = model.data!.name!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
            condition: ShopCubit.get(context).shopUserModel != null,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(
                    bottom: 20.0, left: 20, right: 20, top: 50),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is ShopLoadingUpdateProfileStates)
                        const LinearProgressIndicator(),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextFormField(
                          controller: nameController,
                          perfIcon: const Icon(Icons.person),
                          textType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name must not be empty';
                            }
                          },
                          labelText: 'Name'),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultTextFormField(
                          controller: phoneController,
                          perfIcon: const Icon(Icons.phone),
                          textType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'phone must not be empty';
                            }
                          },
                          labelText: 'Phone'),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultTextFormField(
                          controller: emailController,
                          perfIcon: const Icon(Icons.email_outlined),
                          textType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            }
                          },
                          labelText: 'Email'),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultButton(
                          text: 'SIGN OUT',
                          onPressed: () {
                            signOut(context);
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultButton(
                          text: 'UpDate Profile',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).updateProfileData(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text);
                            }
                          })
                    ],
                  ),
                ),
              );
              ;
            },
            fallback: (context) {
              return Center(child: CircularProgressIndicator());
            });
      },
    );
  }
}
