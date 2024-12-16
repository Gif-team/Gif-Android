import 'package:final_test/appBar/app_bar.dart';
import 'package:final_test/data/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BadgePage extends StatelessWidget {
  BadgePage({super.key});

  @override
  final List<Map<String, dynamic>> badges = [
    {
      "badgeId": 1,
      "trueOrFalse": true,
    },
    {
      "badgeId": 2,
      "trueOrFalse": false,
    },
    {
      "badgeId": 3,
      "trueOrFalse": false,
    },
  ];

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarCustom(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '뱆지',
              style: TextStyle(
                fontSize: size.width * 0.08,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(Assets.badge1),
                SvgPicture.asset(Assets.badge2),
                SvgPicture.asset(Assets.badge3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
