
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/components/input_text_field.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/signup/signup_controller.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();

  final userNameFocusNode = FocusNode();
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
      appBar: AppBar(
       elevation: 0,
      ),
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ChangeNotifierProvider(
            create: (_) => SignUpController (),
            child: Consumer<SignUpController>(
              builder: (context , provider , child){
                return SingleChildScrollView(
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
                                    myController: userNameController,
                                    focusNode: userNameFocusNode,
                                    onFieldSubmittedValue: (value){

                                    },
                                    onValidator: (value){
                                      return value.isEmpty ? 'enter userName': null;
                                    },
                                    keyBoardType: TextInputType.text,
                                    hint: 'UserName',
                                    obscureText: false
                                ),
                                SizedBox(height: height* 0.01,),
                                InputTextFiled(
                                    myController: emailController,
                                    focusNode: emailFocusNode,
                                    onFieldSubmittedValue: (value){
                                      Utils.fieldFocus(context, emailFocusNode, passwordFocusNode);
                                    },
                                    onValidator: (value){
                                      return value.isEmpty ? 'enter email': null;
                                    },
                                    keyBoardType: TextInputType.emailAddress,
                                    hint: 'Email',
                                    obscureText: false
                                ),
                                SizedBox(height: height* 0.01,),
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
                      SizedBox(height: height* 0.03,),
                      const SizedBox(
                        height: 40,
                      ),

                      RoundButton(
                        title: 'SignUp',
                        loading: provider.loading,
                        onPress: () {
                          if(_formKey.currentState!.validate()){
                            provider.signUp( context , userNameController.text, emailController.text, passwordController.text);
                          }
                        },
                      ),
                      SizedBox(height: height*.02),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RouteName.loginView);
                        },
                        child: Text.rich(
                          TextSpan(
                              text: 'Already have an account? ',
                              children: [
                                TextSpan(
                                  text: 'Login' ,
                                  style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15),
                                )
                              ]
                          ),
                        ),
                      ),

                    ],
                  ),
                );
              },
            ),

          )
        ),
      ),
    );
  }
}
