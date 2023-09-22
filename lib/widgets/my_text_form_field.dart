import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/colors.dart';

// ignore: must_be_immutable
class MyTextFormField extends StatefulWidget {
  MyTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    required this.focusNode,
    required this.requestFocus,
    required this.errorHappened,
    this.isObsecure = false,
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool isObsecure;
  final FocusNode focusNode;
  final VoidCallback requestFocus;
  bool errorHappened;

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context, color: black54, width: 2),
    );
    final inputBorder = OutlineInputBorder(
      borderSide:
          Divider.createBorderSide(context, color: Colors.blue, width: 2),
    );
    return TextFormField(
      onTap: widget.requestFocus,
      focusNode: widget.focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        label: Text(widget.labelText),
        labelStyle: TextStyle(
          color: widget.errorHappened
              ? red
              : widget.focusNode.hasFocus
                  ? blue
                  : grey,
          fontSize: 20,
        ),
        border: border,
        focusedBorder: inputBorder,
        enabledBorder: border,
        // filled: true,
        contentPadding: const EdgeInsets.all(20),
      ),
      keyboardType: widget.keyboardType,
      obscureText: widget.isObsecure,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            widget.errorHappened = true;
          });
          return 'fields can\'t be empty';
        }
        if (widget.keyboardType == TextInputType.emailAddress) {
          final bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(widget.controller.text);
          if (!emailValid) {
            setState(() {
              widget.errorHappened = true;
            });
            return 'enter a valid email address';
          }
        }
        if (widget.keyboardType == TextInputType.phone) {
          String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
          RegExp regExp = RegExp(patttern);
          if (!regExp.hasMatch(value)) {
            setState(() {
              widget.errorHappened = true;
            });
            return 'Please enter valid mobile number';
          }
        }
        return null;
      },
    );
  }
}
