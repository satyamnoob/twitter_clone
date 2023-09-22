import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/constants/assets.dart';
import 'package:twitter_clone/constants/colors.dart';
import 'package:twitter_clone/constants/hardcoded.dart';
import 'package:twitter_clone/constants/sized_boxes.dart';
import 'package:twitter_clone/constants/text_styles.dart';
import 'package:twitter_clone/widgets/my_text_form_field.dart';

import '../../../../widgets/date_picker.dart';

class CreateAcoountView extends StatefulWidget {
  const CreateAcoountView({super.key});

  @override
  State<CreateAcoountView> createState() => _CreateAcoountViewState();
}

class _CreateAcoountViewState extends State<CreateAcoountView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  late FocusNode _focusNodeName;
  late FocusNode _focusNodePhone;
  late FocusNode _focusNodeEmail;
  late FocusNode _focusNodeDate;
  bool isPhone = true;
  bool errorOccured = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNodeName = FocusNode();
    _focusNodePhone = FocusNode();
    _focusNodeDate = FocusNode();
    _focusNodeEmail = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _focusNodeName.dispose();
    _focusNodePhone.dispose();
    _focusNodeDate.dispose();
    _dateOfBirthController.dispose();
    _emailController.dispose();
    _focusNodeEmail.dispose();
    super.dispose();
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  void onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      if (_dateOfBirthController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Date can\'t be empty')),
        );
      } else {
        DateTime dateTime =
            DateFormat("dd-MM-yyyy").parse(_dateOfBirthController.text);
        if (isAdult(dateTime)) {
        } else {
          Fluttertoast.showToast(
            msg: "User should be 18 years old to continue",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    }
  }

  bool isAdult(DateTime birthDate) {
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return yearDiff > 18 ||
        yearDiff == 18 && monthDiff > 0 ||
        yearDiff == 18 && monthDiff == 0 && dayDiff >= 0;
  }

  void switchBetweenPhoneAndEmail() {
    setState(() {
      if (isPhone) {
        _phoneController.clear();
      } else {
        _emailController.clear();
      }
      isPhone = !isPhone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(twitterIcon48),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create your account'.hardcoded,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sbh36,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyTextFormField(
                      errorHappened: errorOccured,
                      requestFocus: () {
                        _requestFocus(_focusNodeName);
                      },
                      focusNode: _focusNodeName,
                      controller: _nameController,
                      labelText: 'Name',
                      keyboardType: TextInputType.text,
                    ),
                    sbh24,
                    isPhone
                        ? MyTextFormField(
                            errorHappened: errorOccured,
                            requestFocus: () {
                              _requestFocus(_focusNodePhone);
                            },
                            focusNode: _focusNodePhone,
                            controller: _phoneController,
                            labelText: 'Phone',
                            keyboardType: TextInputType.phone,
                          )
                        : MyTextFormField(
                            errorHappened: errorOccured,
                            requestFocus: () {
                              _requestFocus(_focusNodeEmail);
                            },
                            focusNode: _focusNodeEmail,
                            controller: _emailController,
                            labelText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                          ),
                    sbh24,
                    DatePicker(
                      controller: _dateOfBirthController,
                      focusNode: _focusNodeDate,
                    ),
                    Visibility(
                      visible: _focusNodeDate.hasFocus,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: Text(
                          'This will not be shown publicly. Confirm your own age, even if this account is for a business, a pet or something else'
                              .hardcoded,
                          style: smallTextStyle30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(child: Container()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.14,
        width: double.infinity,
        child: Column(
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedButton(
                  text: isPhone ? 'Use email instead' : 'Use phone instead',
                  onTap: switchBetweenPhoneAndEmail,
                ),
                RoundedButton(
                  text: '   Sign up   ',
                  onTap: onSubmitForm,
                  isSignUp: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isSignUp = false,
  });

  final String text;
  final VoidCallback onTap;
  final bool isSignUp;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: isSignUp ? black : Colors.white,
          border: Border.all(color: grey),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          text.hardcoded,
          style: TextStyle(
            fontSize: 15,
            color: isSignUp ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
