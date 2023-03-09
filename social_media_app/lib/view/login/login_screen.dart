import 'package:flutter/material.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/res/components/input_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputTextFiled(
              myController: emailController,
              focusNode: emailFocusNode,
              onFieldSubmittedValue: (value){

              },
              onValidator: (value){
                return value.isEmpty ? 'enter email': null;
              },
              keyBoardType: TextInputType.emailAddress,
              hint: 'Email',
              obscureText: false
          ),
          const SizedBox(
            height: 40,
          ),
          RoundButton(
            title: 'Login',
            loading: false,
            onPress: () { },
          )
        ],
      ),
    );
  }
}
