import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/constants/hardcoded.dart';

import '../constants/colors.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required this.focusNode,
    required this.controller,
  });

  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context, color: black54, width: 2),
    );
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context, color: blue, width: 2),
    );
    return TextFormField(
      onTap: () async {
        FocusScope.of(context).requestFocus(widget.focusNode);

        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          setState(() {
            widget.controller.text =
                DateFormat('dd-MM-yyyy').format(pickedDate);
          });
        }
      },
      decoration: InputDecoration(
        alignLabelWithHint: true,
        label: Text("Date Of Birth".hardcoded),
        labelStyle: TextStyle(color: widget.focusNode.hasFocus ? blue : grey),
        border: border,
        focusedBorder: inputBorder,
        enabledBorder: border,
      ),
      controller: widget.controller,
    );
  }
}
