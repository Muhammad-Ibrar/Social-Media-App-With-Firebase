import 'package:flutter/material.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/res/components/input_text_field.dart';
import 'package:tech_media/utils/routes/route_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height *1;
    return Scaffold(
      body: SafeArea(
        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height*.03),
                Text('Welcome to My App' , style: Theme.of(context).textTheme.headline3,),
                SizedBox(height: height*.03),

                Form(
                  key: _formKey,
                    child: Padding(
                      padding:EdgeInsets.only(top: height * 0.03 , bottom: height * 0.01),
                      child: Column(
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
                          InputTextFiled(
                              myController: passwordController,
                              focusNode: passwordFocusNode,
                              onFieldSubmittedValue: (value){

                              },
                              onValidator: (value){
                                return value.isEmpty ? 'enter password': null;
                              },
                              keyBoardType: TextInputType.text,
                              hint: 'password',
                              obscureText: true
                          ),
                        ],
                      ),
                    )

                ),
                Align(
                  alignment: Alignment.centerRight,
                    child: Text(
                        'Forgot Password',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 15,
                        decoration: TextDecoration.underline
                      ),
                    )
                ),
                SizedBox(height: height* 0.03,),
                const SizedBox(
                  height: 40,
                ),

                RoundButton(
                  title: 'Login',
                  loading: false,
                  onPress: () { },
                ),
                SizedBox(height: height*.02),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RouteName.signupScreen);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Do not have an account?',
                      children: [
                        TextSpan(
                          text: 'SignUp' , style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15),
                        )
                      ]
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
