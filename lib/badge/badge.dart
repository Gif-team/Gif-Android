import 'package:final_test/appBar/app_bar.dart';
import 'package:final_test/data/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BadgePage extends StatelessWidget {
  BadgePage({super.key});

  @override
  final Map<String, bool> badges = {
    "badge1": true,
    "badge2": true,
    "badge3": false,
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget falseBox() {
      return Container(
        width: size.width * 0.3,
        height: size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFFD9D9D9),
        ),
      );
    }

    return Scaffold(
      appBar: AppBarCustom(onSearchChanged: (String value) {  },),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '뱃지',
              style: TextStyle(
                fontSize: size.width * 0.08,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    badges["badge1"]!
                        ? SvgPicture.asset(
                      Assets.badge1,
                      width: size.width * 0.3,
                    )
                        : falseBox(),
                    Text(
                      '탐색왕',
                      style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Column(
                  children: [
                    badges["badge2"]!
                        ? SvgPicture.asset(
                      Assets.badge2,
                      width: size.width * 0.3,
                    )
                        : falseBox(),
                    Text(
                      '깜빡이',
                      style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Column(
                  children: [
                    badges["badge3"]!
                        ? SvgPicture.asset(
                      Assets.badge3,
                      width: size.width * 0.3,
                    )
                        : falseBox(),
                    Text(
                      '인기왕',
                      style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
