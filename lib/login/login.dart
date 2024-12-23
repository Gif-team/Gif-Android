import 'package:final_test/changePassWord/changePassWord.dart';
import 'package:final_test/data/colorData.dart';
import 'package:final_test/mainPage/main_page.dart';

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

  bool _hasError = false; // 오류 상태 관리
  bool _isLoading = false; // 로딩 상태 관리

  final Map<String, String> mockUserData = {
    'test@example.com': 'password123', // 이메일: 비밀번호
  };

  Future<void> _login() async {
    setState(() {
      _isLoading = true; // 로딩 상태 활성화
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      // 이메일과 비밀번호가 임시 데이터와 일치하는지 확인
      if (mockUserData.containsKey(email) && mockUserData[email] == password) {
        setState(() {
          _hasError = false; // 오류 상태 해제
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 성공!')),

        );

        // main 페이지로 이동 (애니메이션 추가)
        Navigator.push(
          context,
          _createSlideTransitionRoute(const MainPage()),
        );
      } else {
        setState(() {
          _hasError = true; // 오류 상태 활성화
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('아이디와 비밀번호를 다시 한 번 확인해주세요.')),
        );
      }
    } catch (e) {
      setState(() {
        _hasError = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류가 발생했습니다. 다시 시도해주세요.')),
      );
    } finally {
      setState(() {
        _isLoading = false; // 로딩 상태 비활성화
      });
    }
  }

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
                  _isLoading
                      ? const CircularProgressIndicator()
                      : _loginBtn(context),
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

  // 페이지 이동 애니메이션
  PageRouteBuilder _createSlideTransitionRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0); // 시작 위치 (아래에서)
        var end = Offset.zero; // 끝 위치 (현재 위치)
        var curve = Curves.easeInOut; // 부드러운 커브 애니메이션
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400), // 애니메이션 속도 조정
    );
  }

  SizedBox _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
    required bool errorState,
  }) {
    return SizedBox(
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: errorState ? Colors.red : Colors.black,
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
              color: errorState ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _loginBtn(BuildContext context) {
    return SizedBox(
      width: 350,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorData.mainColor,
        ),
        onPressed: _login,
        child: const Text(
          '로그인',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  TextButton _signUpBtn() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          _createSlideTransitionRoute(const SignUp()),
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

  Widget _changePassWordBtn() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          _createSlideTransitionRoute(ChangePasswordPage()),
        );
      },
      child: const Text(
        '비밀번호 재설정',
        style: TextStyle(
          color: Color(0XFF3269F6),
        ),
      ),
    );
  }
}
