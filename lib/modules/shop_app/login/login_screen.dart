import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/layout/shop_app/shop_layout.dart';
import 'package:todo_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:todo_app/modules/shop_app/login/cubit/states.dart';
import 'package:todo_app/modules/shop_app/regester/regester_screen.dart';

import 'package:todo_app/shared/componants/componants.dart';
import 'package:todo_app/shared/componants/constance.dart';
import 'package:todo_app/shared/network/lockal/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
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
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'login now to browse our hot offers ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                            controller: emailController,
                            perfIcon: const Icon(Icons.email),
                            textType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email Address mut not be empty';
                              }
                            },
                            labelText: 'Email Address'),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                            sufix: ShopLoginCubit.get(context).suffix,
                            sufixPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            controller: passwordController,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                                print('login');
                              }
                            },
                            perfIcon: const Icon(Icons.lock),
                            textType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password must not be empty';
                              }
                            },
                            labelText: 'Password',
                            ispassword: ShopLoginCubit.get(context).isSecure),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadinglState,
                          builder: (context) => defaultButton(
                            text: 'LOGIN',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                                print('login');
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('don\'t have an account ?'),
                            defaultTextButton(
                                onPressed: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                text: 'Register Now',
                                isUpper: true),
                          ],
                        )
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
