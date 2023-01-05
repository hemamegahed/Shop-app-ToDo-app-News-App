import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/shop_app/regester/cubit/cubit.dart';
import 'package:todo_app/modules/shop_app/regester/cubit/states.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/componants/componants.dart';
import '../../../shared/componants/constance.dart';
import '../../../shared/network/lockal/cache_helper.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel!.status!) {
              print(state.loginModel!.message!);
              print(state.loginModel!.data!.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel!.data!.token)
                  .then((value) {
                token = state.loginModel!.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel!.message!);
              showToast(
                  state: ToastStates.ERROR, text: state.loginModel!.message!);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Regester',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Register now to browse our hot offers ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                            controller: nameController,
                            perfIcon: const Icon(Icons.person),
                            textType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name  must not be empty';
                              }
                            },
                            labelText: 'Name'),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                            sufix: ShopRegisterCubit.get(context).suffix,
                            sufixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            controller: passwordController,
                            onSubmit: (value) {},
                            perfIcon: const Icon(Icons.lock),
                            textType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password must not be empty';
                              }
                            },
                            labelText: 'Password',
                            ispassword:
                                ShopRegisterCubit.get(context).isSecure),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                            controller: emailController,
                            perfIcon: const Icon(Icons.email),
                            textType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email Address must not be empty';
                              }
                            },
                            labelText: 'Email'),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                            controller: phoneController,
                            perfIcon: const Icon(Icons.phone_android),
                            textType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone must not be empty';
                              }
                            },
                            labelText: 'Phone'),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadinglState,
                          builder: (context) => defaultButton(
                            text: 'Register',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    name: nameController.text);
                                print('register');
                              }
                            },
                            isUpper: true,
                          ),
                          fallback: (context) =>
                              const CircularProgressIndicator(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
