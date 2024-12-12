import 'package:final_test/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../data/assets.dart';
import '../data/colorData.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  final _rePassWordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _emailHasError = false;
  bool _passWordHasError = false;
  bool _rePassWordHasError = false;

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return '이메일을 입력하세요';
    } else {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return '올바른 이메일 주소를 입력하세요.';
      } else {
        return null; //null을 반환하면 정상
      }
    }
  }

  String? validatePassword(String value) {
    String pattern =
        r'^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,15}$';
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      return '비밀번호를 입력하세요';
    }  else if (!regExp.hasMatch(value) || value.length < 8) {
      return '특수문자, 문자, 숫자 포함 8자 이상으로 적어주세요.';
    } else {
      return null; //null을 반환하면 정상
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                _buildTextField(
                  controller: _emailController,
                  label: '이메일',
                  hintText: '이메일을 입력해주세요...',
                  errorState: _emailHasError,
                  validator: (value) {
                    return validateEmail(value.toString());
                  },
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _passWordController,
                  label: '비밀번호',
                  hintText: '비밀번호을 입력해주세요...',
                  errorState: _passWordHasError,
                  obscureText: true,
                  validator: (value) {
                    return validatePassword(value.toString());
                  },
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _rePassWordController,
                  label: '비밀번호 재입력',
                  hintText: '비밀번호를 재입력해주세요...',
                  obscureText: true,
                  errorState: _rePassWordHasError,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 재입력하세요.';
                    } else if (value != _passWordController.text) {
                      return '비밀번호가 일치하지 않아요.';
                    }
                    return null; // 정상 상태
                  },
                ),
                const SizedBox(height: 20),
                _signUpBtn(context),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('이미 계정이 있으신가요?'),
                    _loginBtn(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 로고 이미지를 생성하는 위젯
  Align _logoImage() {
    return Align(
      alignment: const Alignment(0, -1 / 1.2),
      child: Image.asset('assets/images/logo.png'),
    );
  }

  // 텍스트 필드 위젯을 생성하는 메소드
  SizedBox _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
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
              color: errorState ? Colors.red : Colors.black,
            ),
          ),
          const SizedBox(height: 3),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
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
                fontSize: 14,
              ),
            ),
            style: TextStyle(
              color: errorState ? Colors.red : Colors.black,
            ),
            validator: (value) {
              final result = validator(value);
              setState(() {
                if (controller == _emailController) {
                  _emailHasError = result != null;
                } else if (controller == _passWordController) {
                  _passWordHasError = result != null;
                } else if (controller == _rePassWordController) {
                  _rePassWordHasError = result != null;
                }
              });
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
  SizedBox _signUpBtn(BuildContext context) {
    return SizedBox(
      width: 350,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorData.mainColor,
        ),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            // 회원가입 버튼 클릭 시 수행할 동작 정의
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          }
        },
        child: const Text(
          '회원가입',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // 로그인 버튼 위젯을 생성하는 메소드
  TextButton _loginBtn(BuildContext context) {
    return TextButton(
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
        style: TextStyle(color: Color(0XFF3269F6)),
      ),
    );
  }
}
