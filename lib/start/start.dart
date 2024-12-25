import 'package:final_test/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/colorData.dart';
import '../data/assets.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.logo2),
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
                    _createSlideTransitionRoute(),
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
      ),
    );
  }

  PageRouteBuilder _createSlideTransitionRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Login();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0); // 시작 위치 (아래에서)
        var end = Offset.zero; // 끝 위치 (현재 위치)
        var curve = Curves.easeInQuad; // 부드러운 커브 애니메이션
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        // 자연스러운 애니메이션을 위해 작은 딜레이와 함께 적용
        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 500), // 애니메이션 속도 조정
    );
  }
}
