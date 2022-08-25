// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palnts/core/utils/extentions.dart';

import '../../core/utils/app_strings.dart';
import '../../core/utils/assets_manger.dart';
import '../../core/utils/constants.dart';
import '../../network/local/cashe_helper.dart';
import '../root/root_page.dart';
import '../shared_cubit/app_cubit.dart';
import '../shared_widget/default_button.dart';
import '../shared_widget/default_form_field.dart';
import '../shared_widget/separetor_widget.dart';
import 'cubit/loginCubit.dart';
import 'cubit/loginStates.dart';

class LoginScreeen extends StatelessWidget {
  TextEditingController emailConrtoller = TextEditingController();
  TextEditingController passConrtoller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginStates>(
          listener: (context, state) {
        if (state is AppLoginSuccessState) {
          print('access tolken is ${state.loginModel.userData?.accessToken}');
          CashHelper.setData("token", state.loginModel.userData?.accessToken)
              .then((value) {
            Constants.pushReplace(context, RootPage());
            BlocProvider.of<AppCubit>(context).getProducts();
            AppStrings.token = state.loginModel.userData?.accessToken;
            print(AppStrings.token);
            if (value) {
              ///  Constants.push(context, Scaffold());
            }
          });
          Constants.showToast(
            color: Colors.green,
            msg: "${state.loginModel.message}",
          );
        } else {
          Constants.showToast(
            msg: "${context.loginCubit.loginModel.message}",
          );
        }
      }, builder: (context, state) {
        var cubit = BlocProvider.of<AppLoginCubit>(context);
        return Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: context.caption,
                    ),
                    DefaultFormField(
                      controller: emailConrtoller,
                      inputType: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "email address must not be empty";
                        } else if (!value.contains("@")) {
                          return "email must be contain @";
                        } else
                          return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password",
                      style: context.caption,
                    ),
                    DefaultFormField(
                      controller: passConrtoller,
                      inputType: TextInputType.visiblePassword,
                      isObscure: true,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "password must not be empty";
                        } else if (value.length < 6) {
                          return "password must be at least 6 character";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                        condition: state is! AppLoginLoadingState,
                        builder: (context) => DefaultButton(
                            text: "login",
                            onpressed: () {
                              if (formkey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailConrtoller.text,
                                    password: passConrtoller.text);
                              }
                            },
                            color: Theme.of(context).primaryColor),
                        fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            )),
                    SizedBox(
                      height: 20,
                    ),
                    SeparetorWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            cubit.signInWithGoogle();
                          },
                          child: Container(
                            padding: EdgeInsets.zero,
                            child: Image.asset(
                              ImgAssets.google,
                              width: 30,
                              height: 30,
                              //  fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            cubit.signInWithFace();
                          },
                          child: Image.asset(
                            ImgAssets.face,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
