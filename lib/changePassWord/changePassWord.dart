import 'package:flutter/material.dart';
import 'package:final_test/data/colorData.dart';
import 'package:final_test/login/login.dart';
import 'package:flutter_svg/svg.dart';

import '../data/assets.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    }
    String pattern =
        r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[$@!%*?&#]).{8,}$'; // 비밀번호 형식: 문자, 숫자, 특수문자 포함
    if (!RegExp(pattern).hasMatch(value) || value.length < 8) {
      return '특수문자, 문자, 숫자 포함 8자 이상으로 적어주세요.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
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
                  _buildTextField(
                    controller: _newPasswordController,
                    label: '새 비밀번호',
                    hintText: '새 비밀번호를 입력해주세요...',
                    obscureText: true,
                    validator: (value) {
                      return _validatePassword(value ?? '');
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _confirmNewPasswordController,
                    label: '새 비밀번호 재입력',
                    hintText: '새 비밀번호를 입력해주세요...',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '비밀번호를 입력해주세요.';
                      }
                      if (value != _newPasswordController.text) {
                        return '비밀번호가 일치하지 않습니다.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _resetPasswordButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 텍스트 필드 위젯
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
    required FormFieldValidator<String> validator,
  }) {
    return SizedBox(
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFEFF0F2)),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }

  // 비밀번호 재설정 버튼
  Widget _resetPasswordButton(BuildContext context) {
    return SizedBox(
      width: 350,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorData.mainColor,
        ),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            // 모든 입력이 유효한 경우
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('비밀번호가 성공적으로 변경되었습니다!')),
            );

            // 로그인 화면으로 이동
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          }
        },
        child: const Text(
          '비밀번호 변경',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
