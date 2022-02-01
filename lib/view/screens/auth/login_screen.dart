import 'package:alloha/helper/compenents.dart';
import 'package:alloha/helper/email_checker.dart';
import 'package:alloha/localization/language_constrants.dart';
import 'package:alloha/provider/auth_provider.dart';
import 'package:alloha/util/color_resources.dart';
import 'package:alloha/util/images.dart';
import 'package:alloha/util/routes.dart';
import 'package:alloha/view/base/custom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formEmailKey = GlobalKey<FormState>();
  final formPasswordKey = GlobalKey<FormState>();

  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AuthProvider>(
        builder: (context, AuthProvider authProvider, child) => Stack(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomAppBar(
                            context: context,
                            isBackButtonExist: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            getTranslated('welcome', context),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Form(
                            key: formEmailKey,
                            child: CustomTextField(
                              hintText: getTranslated('email', context),
                              // key: formEmailKey,
                              focusNode: _emailFocus,
                              nextFocus: _passwordFocus,
                              controller: emailController,
                              inputType: TextInputType.emailAddress,
                              onChanged: (value) {
                                formEmailKey.currentState!.validate();
                              },
                              validator: (value) {
                                return validateEmail(value);
                              },
                              labelText: getTranslated('email', context),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Form(
                            key: formPasswordKey,
                            child: CustomTextField(
                              hintText: getTranslated('password', context),
                              isPassword: true,
                              focusNode: _passwordFocus,
                              controller: passwordController,
                              inputType: TextInputType.text,
                              inputAction: TextInputAction.done,
                              onChanged: (value) {
                                formPasswordKey.currentState!.validate();
                              },
                              validator: (value) {
                                return validatePassword(value);
                              },
                              labelText: getTranslated('password', context),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Text(
                              getTranslated('forget_password', context),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            child: MyOutlinedButton(
                              raduis: 5,
                              onPressed: () {
                                login(authProvider);
                              },
                              gradient: const LinearGradient(colors: [
                                ColorResources.COLOR_PRIMAY,
                                ColorResources.COLOR_SECONDRY
                              ]),
                              child: Text(
                                getTranslated('sign_in', context),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Row(
                              children: [
                                const Expanded(
                                    child: Divider(
                                  color: Colors.black,
                                )),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Text(
                                      getTranslated('or', context),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                const Expanded(
                                    child: Divider(
                                  color: Colors.black,
                                )),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              loginFaceBook(authProvider);
                            },
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color(0xFFB8B8B8),
                                    width: 1,
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(Imagess.facebook),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    getTranslated('face_book', context),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: (){loginGoogle(authProvider);},
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color(0xFFB8B8B8),
                                    width: 1,
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(Imagess.google),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    getTranslated('google', context),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                getTranslated('no_account', context),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.getSignUpRoute());
                                },
                                child: Text(
                                  getTranslated('sign_up', context),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ]),
                  ),
                )),
            if (authProvider.isLoading)
              Align(
                alignment: Alignment.center,
                child: Container(
                  color: Colors.white70,
                  child: const SpinKitFadingCircle(
                    color: Colors.red,
                    size: 60.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return getTranslated('validate_password', context);
    } else if (value.toString().length < 6) {
      return getTranslated('password_should_be', context);
    }
    return null;
  }

  String? validateEmail(value) {
    if (value == null || value.isEmpty) {
      return getTranslated('validate_email', context);
    } else if (EmailChecker.isNotValid(value.toString())) {
      return getTranslated('email_should_be', context);
    }
    return null;
  }

  void login(AuthProvider authProvider) {
    // ignore: curly_braces_in_flow_control_structures
    if (formKey.currentState != null) if (formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());

      authProvider
          .login(emailController.text.toString(),
              passwordController.text.toString())
          .then((status) async {
        if (status.isSuccess) {
          showSuccess(context, getTranslated('success', context));
        } else {
          showError(context, getTranslated('invalid_email', context));
        }
      }).catchError((error) {
        print(error.toString());
        showError(context, getTranslated('invalid_email', context));
      });
    }
  }
  void loginGoogle(AuthProvider authProvider) {

      authProvider.signInWithGoogle(context: context).then((value) => {
        value!=null ? showSuccess(context, value.displayName) : null

      });

  }
  void loginFaceBook(AuthProvider authProvider) {

      authProvider.signInWithFacebook().then((value) => {
         showSuccess(context, value.user?.displayName)

      }).catchError((onError){
        showError(context, onError.toString());
      });

  }
}
