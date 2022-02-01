import 'package:alloha/helper/compenents.dart';
import 'package:alloha/localization/language_constrants.dart';
import 'package:alloha/util/color_resources.dart';
import 'package:alloha/util/dimensions.dart';
import 'package:alloha/util/images.dart';
import 'package:alloha/util/routes.dart';
import 'package:alloha/view/base/custom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    TextStyle defaultStyle = TextStyle(color: Colors.black, fontSize: 14.0);
    TextStyle linkStyle = TextStyle(color: Colors.red);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: formKey,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              CustomAppBar(
                context: context,
                isBackButtonExist: false,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                getTranslated('create_account', context),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              const SizedBox(
                height: Dimensions.FONT_SIZE_BOX_TEXTS,
              ),
              CustomTextField(
                controller: emailController,
                inputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Full Name';
                  }
                  return null;
                },
                hintText: getTranslated('full_name', context),
              ),
              const SizedBox(
                height: Dimensions.FONT_SIZE_BOX_TEXTS,
              ),
              CustomTextField(
                controller: emailController,
                inputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Email';
                  }
                  return null;
                },
                hintText: getTranslated('email', context),
              ),
              const SizedBox(
                height: Dimensions.FONT_SIZE_BOX_TEXTS,
              ),
              CustomTextField(
                isPassword: true,
                controller: passwordController,
                inputType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Password';
                  }
                  return null;
                },
                hintText: getTranslated('password', context),
              ),
              const SizedBox(
                height: Dimensions.FONT_SIZE_BOX_TEXTS,
              ),
              CustomTextField(
                isPassword: true,
                controller: passwordController,
                inputType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Confirm Password';
                  }
                  return null;
                },
                hintText: getTranslated('confirm_password', context),
              ),
              const SizedBox(
                height: 55,
              ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
              child: RichText(
                textAlign: TextAlign.center,
                  text: TextSpan(
                    style: defaultStyle,
                    children: <TextSpan>[
                      TextSpan(text: getTranslated('privacy_policy_part01', context)),
                      TextSpan(text: getTranslated('privacy_policy_part02', context),
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Terms of Service"');
                            }),
                      TextSpan(text: getTranslated('privacy_policy_part03', context)),
                      TextSpan(text: getTranslated('privacy_policy_part04', context),
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Terms of Service"');
                            }),
                    ],
                  ),
              ),
            ), const SizedBox(
                height: 15,
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: MyOutlinedButton(
                  raduis: 5,
                  onPressed: () {},
                  gradient: const LinearGradient(colors: [
                    ColorResources.COLOR_PRIMAY,
                    ColorResources.COLOR_SECONDRY
                  ]),
                  child: Text(
                    getTranslated('sign_up', context),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
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
                    getTranslated('aleardy_account', context),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      getTranslated('sign_in', context),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );

  }
}
