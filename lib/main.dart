import 'package:flutter/material.dart';
import 'package:idea_festival/boardpage.dart';
import 'appBar.dart'; // 앱바 파일 임포트

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context), // 앱바 사용
      body: const BoardPage(),
    );
  }
}
