import 'package:flutter/material.dart';
import 'package:idea_festival/signup.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logoImage(),
                const SizedBox(height: 20), // 간격 추가
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('이메일'),
                    SizedBox(height: 3),
                    SizedBox(
                      width: 350, // 입력창 너비 조절
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '이메일',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("비밀번호"),
                    SizedBox(height: 3),
                    SizedBox(
                      width: 350, // 입력창 너비 조절
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '비밀번호',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                changePasswordBtn(context),
                const SizedBox(height: 20),
                loginBtn(context),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('아직 회원이 아니신가요?'),
                    signUpBtn(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align logoImage() {
    return Align(
      alignment: const Alignment(0, -1 / 1.2),
      child: Image.asset('assets/images/logo.png'),
    );
  }

  TextButton signUpBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUp()),
        );
      },
      child: const Text(
        '회원가입',
        style: TextStyle(color: Color(0XFF3269F6)),
      ),
    );
  }

  SizedBox loginBtn(BuildContext context) {
    return SizedBox(
      width: 350, // 로그인 버튼의 너비를 조절
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7E8EF1), // 버튼 배경 색상을 파란색으로 설정
        ),
        onPressed: () {
          // 로그인 버튼 클릭 시 수행할 동작 정의
        },
        child: const Text(
          '로그인',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  TextButton changePasswordBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        // 비밀번호 재설정 버튼 클릭 시 수행할 동작 정의
      },
      child: const Text(
        '비밀번호 재설정',
        style: TextStyle(color: Color(0XFF3269F6)),
      ),
    );
  }
}
