import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/res/components/input_text_field.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/forgot_password/forgot_password_controller.dart';
import 'package:tech_media/view_model/login/login_controller.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    emailFocusNode.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height * 1;
    return Scaffold(
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height * .03),
                Text('Forgot Password', style: Theme.of(context).textTheme.headline3,),
                SizedBox(height: height * .03),

                Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.03, bottom: height * 0.01),
                      child: Column(
                        children: [
                          InputTextFiled(
                              myController: emailController,
                              focusNode: emailFocusNode,
                              onFieldSubmittedValue: (value) {

                              },
                              onValidator: (value) {
                                return value.isEmpty ? 'enter email' : null;
                              },
                              keyBoardType: TextInputType.emailAddress,
                              hint: 'Email',
                              obscureText: false
                          ),
                        ],
                      ),
                    )

                ),
                SizedBox(height: height * 0.03,),
                const SizedBox(
                  height: 40,
                ),
                ChangeNotifierProvider(
                  create: (_) => ForgotPasswordController(),
                  child: Consumer<ForgotPasswordController>(
                      builder: (context, provider, child) {
                        return RoundButton(
                          title: 'Recover',
                          loading: provider.loading,
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              provider.forgotPassword(context, emailController.text);
                            }
                          },
                        );
                      }
                  ),
                ),
                SizedBox(height: height * .02),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
