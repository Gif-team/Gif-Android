import 'package:final_test/login/login_assets.dart';
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
  bool _emailHasError = false;
  bool _passwordHasError = false;

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
                  SvgPicture.asset(LoginAssets.logo1),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _emailController,
                    label: '이메일',
                    hintText: '이메일을 입력해주세요...',
                    errorState: _emailHasError,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이메일을 입력해주세요.';
                      } else if (value.length < 5) {
                        return '이메일은 5자 이상이어야 합니다.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _passwordController,
                    label: '비밀번호',
                    hintText: '비밀번호를 입력해주세요...',
                    obscureText: true,
                    // 비밀번호 필드에서 문자를 숨김
                    errorState: _passwordHasError,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '비밀번호를 입력해주세요.';
                      } else if (value.length < 8) {
                        return '비밀번호는 8자 이상이어야 합니다.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  _changePasswordBtn(context),
                  const SizedBox(height: 20),
                  _loginBtn(context),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('아직 회원이 아니신가요?'),
                      _signUpBtn(context),
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

  // 텍스트 필드 위젯을 생성하는 메소드
  SizedBox _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false, // 비밀번호 필드에서 문자를 숨길지 여부
    required FormFieldValidator<String> validator,
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
              color:
                  errorState ? Colors.red : Colors.black, // 오류 상태에 따라 라벨 색상 변경
            ),
          ),
          const SizedBox(height: 3),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            // 문자를 숨기도록 설정
            decoration: InputDecoration(
              border: _inputBorder(),
              enabledBorder: _inputBorder(),
              focusedBorder: _inputBorder(),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.red),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: errorState ? Colors.red : Colors.grey,
                // 오류 상태에 따라 힌트 텍스트 색상 변경
                fontSize: 14,
              ),
            ),
            style: TextStyle(
              color: errorState
                  ? Colors.red
                  : Colors.black, // 오류 상태에 따라 입력된 텍스트 색상 변경
            ),
            validator: (value) {
              final result = validator(value);
              if (result != null) {
                setState(() {
                  if (controller == _emailController) {
                    _emailHasError = true;
                  } else if (controller == _passwordController) {
                    _passwordHasError = true;
                  }
                });
              } else {
                setState(() {
                  if (controller == _emailController) {
                    _emailHasError = false;
                  } else if (controller == _passwordController) {
                    _passwordHasError = false;
                  }
                });
              }
              return result;
            },
          ),
        ],
      ),
    );
  }

  // 공통 입력 경계 스타일
  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFEFF0F2)),
    );
  }

  // 회원가입 버튼 위젯을 생성하는 메소드
  TextButton _signUpBtn(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        '회원가입',
        style: TextStyle(color: Color(0XFF3269F6)),
      ),
    );
  }

  // 로그인 버튼 위젯을 생성하는 메소드
  SizedBox _loginBtn(BuildContext context) {
    return SizedBox(
      width: 350,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7E8EF1),
        ),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            // 로그인 버튼 클릭 시 수행할 동작 정의
          }
        },
        child: const Text(
          '로그인',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // 비밀번호 재설정 버튼 위젯을 생성하는 메소드
  TextButton _changePasswordBtn(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        '비밀번호 재설정',
        style: TextStyle(color: Color(0XFF3269F6)),
      ),
    );
  }
}
