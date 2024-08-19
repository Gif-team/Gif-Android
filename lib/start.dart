import 'package:flutter/material.dart';
import 'package:idea_festival/login.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 100.0,
            ), // 아래쪽에 패딩을 추가하여 이미지를 위로 이동
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200, // 원하는 너비
                  height: 200, // 원하는 높이
                  child: Image.asset(
                    'assets/images/logo2.png',
                    width: 100, // 이미지의 너비
                    height: 100, // 이미지의 높이
                  ),
                ),
                const SizedBox(height: 90), // 이미지와 버튼 사이의 간격
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFF615EFC)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                      // 로그인 버튼을 눌렀을 때의 동작을 여기에 작성
                      print('로그인 버튼 클릭');
                    },
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // 버튼 사이의 간격
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFFFFE812)),
                    ),
                    onPressed: () {
                      // 카카오톡 로그인 버튼을 눌렀을 때의 동작을 여기에 작성
                      print('카카오톡 로그인 버튼 클릭');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/kakao_logo.png', // 카카오톡 로고 이미지 경로
                          width: 24, // 로고 너비
                          height: 24, // 로고 높이
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          '카카오톡 로그인',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
