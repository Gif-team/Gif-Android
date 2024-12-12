import 'package:final_test/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../start/start_assets.dart';
import '../color/colorData.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(StartAssets.logo),
          SizedBox(
            width: size.width * 0.5,
            height: 35,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorData.mainColor,
                surfaceTintColor: ColorData.mainColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: const Text(
                '로그인',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
