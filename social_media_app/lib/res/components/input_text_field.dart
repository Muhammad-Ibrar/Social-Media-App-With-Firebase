import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class InputTextFiled extends StatelessWidget {
  const InputTextFiled({
    Key? key,
    required this.myController,
    required this.focusNode,
    required this.onFieldSubmittedValue,
    required this.onValidator,
    required this.keyBoardType,
    required this.hint,
    required this.obscureText,
    this.enable = true,
    this.autoFocus = false

  }) : super(key: key);

  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  final FormFieldValidator onValidator;

  final TextInputType keyBoardType;
  final String hint;
  final bool obscureText;
  final bool autoFocus , enable;


  @override

  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmittedValue,
      validator: onValidator,
      keyboardType: keyBoardType,
      obscureText: obscureText,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyText2,
        border:const OutlineInputBorder(
          borderSide: BorderSide(
            color:AppColors.textFieldDefaultFocus,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))
        )
      ),


    );
  }
}
