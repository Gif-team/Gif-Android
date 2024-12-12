import 'package:final_test/data/colorData.dart';

import '../data/assets.dart';
import 'package:final_test/signUp/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // 오류 상태 관리
  bool _hasError = false; // 이메일 또는 비밀번호 오류 여부

  // 테스트용 고정 데이터 (실제 서버 통신 필요시 이 부분을 대체)
  final String _testEmail = "test@example.com";
  final String _testPassword = "password123";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.logo1,
                    placeholderBuilder: (context) =>
                        const CircularProgressIndicator(),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _emailController,
                    label: '이메일',
                    hintText: '이메일을 입력해주세요...',
                    errorState: _hasError,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _passwordController,
                    label: '비밀번호',
                    hintText: '비밀번호를 입력해주세요...',
                    obscureText: true,
                    errorState: _hasError,
                  ),
                  _changePassWordBtn(),
                  if (_hasError)
                    const Text(
                      '아이디와 비밀번호를 다시 한 번 확인해주세요.',
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  _loginBtn(context),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('아직 회원이 아니신가요?'),
                      _signUpBtn(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 텍스트 필드 위젯 생성
  SizedBox _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
    required bool errorState, // 오류 상태 관리
  }) {
    return SizedBox(
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: errorState ? Colors.red : Colors.black, // 오류 시 라벨 색상 변경
            ),
          ),
          const SizedBox(height: 3),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: errorState ? Colors.red : const Color(0xFFEFF0F2),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: errorState ? Colors.red : const Color(0xFFEFF0F2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: errorState ? Colors.red : const Color(0xFF7E8EF1),
                ),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: errorState ? Colors.red : Colors.grey,
                fontSize: 14,
              ),
            ),
            style: TextStyle(
              color: errorState ? Colors.red : Colors.black, // 입력 텍스트 색상 변경
            ),
          ),
        ],
      ),
    );
  }

  // 로그인 버튼
  SizedBox _loginBtn(BuildContext context) {
    return SizedBox(
      width: 350,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorData.mainColor,
        ),
        onPressed: () {
          setState(() {
            // 이메일과 비밀번호 검증
            if (_emailController.text != _testEmail ||
                _passwordController.text != _testPassword) {
              _hasError = true; // 오류 상태 활성화
            } else {
              _hasError = false; // 오류 상태 해제

              // 성공적인 로그인 처리
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('로그인 성공!')),
              );

              // 로그인 성공 시 다음 화면으로 이동 (예시)
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => HomePage()));
            }
          });
        },
        child: const Text(
          '로그인',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // 회원가입 버튼
  TextButton _signUpBtn() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUp(),
          ),
        );
      },
      child: const Text(
        '회원가입',
        style: TextStyle(
          color: Color(0XFF3269F6),
          fontSize: 16,
        ),
      ),
    );
  }
}

Widget _changePassWordBtn() {
  return TextButton(
    onPressed: () {},
    child: const Text(
      '비밀번호 재설정',
      style: TextStyle(
        color: Color(0XFF3269F6),
      ),
    ),
  );
}
