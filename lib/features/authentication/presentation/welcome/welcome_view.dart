import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/constants/assets.dart';
import 'package:twitter_clone/constants/colors.dart';
import 'package:twitter_clone/constants/hardcoded.dart';
import 'package:twitter_clone/constants/sized_boxes.dart';
import 'package:twitter_clone/constants/text_styles.dart';

import '../../../../routing/router.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        title: SvgPicture.asset(twitterIcon48),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(),
            ),
            Text(
              "See what's".hardcoded,
              style: bigTextStyle,
            ),
            Text(
              "happening in the".hardcoded,
              style: bigTextStyle,
            ),
            Text(
              "world right now.".hardcoded,
              style: bigTextStyle,
            ),
            sbh24,
            InkWell(
              onTap: () {
                context.pushNamed(AppRoute.createAccount.name);
              },
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: const BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Create Account'.hardcoded,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Have an account already? '.hardcoded,
                    style: const TextStyle(
                      color: black54,
                    ),
                  ),
                  Text(
                    'Log in'.hardcoded,
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
