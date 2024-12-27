import 'package:final_test/data/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../appBar/app_bar.dart';

class Chating extends StatefulWidget {
  const Chating({super.key});

  @override
  State<Chating> createState() => _ChatingState();
}

class _ChatingState extends State<Chating> with WidgetsBindingObserver {
  // 이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); // ImagePicker 초기화
  final List<Message> _messages = []; // Message 객체로 메시지 리스트 변경
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController =
      ScrollController(); // ScrollController 추가

  Future getImage(ImageSource imageSource) async {
    // pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        // 가져온 이미지를 _image에 저장
        _sendImageMessage(pickedFile.path); // 이미지를 메시지로 추가
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // 키보드 상태 감지 시작
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // 키보드 상태 감지 해제
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // 키보드 상태 변화를 감지하는 함수
  @override
  void didChangeMetrics() {
    // 키보드가 올라왔을 때
    if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
      _scrollToBottom();
    }
  }

  // 메시지 전송 함수
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages
            .add(Message(text: _controller.text, isUser: true)); // 사용자가 보낸 메시지
      });
      _controller.clear();

      _scrollToBottom(); // 새로운 메시지를 추가한 후 자동으로 하단으로 스크롤
    }
  }

  // 이미지 전송 함수
  void _sendImageMessage(String imagePath) {
    setState(() {
      _messages.add(Message(isUser: true, imagePath: imagePath)); // 이미지 메시지 추가
    });
    _scrollToBottom();
  }

  // 스크롤을 메시지 리스트의 가장 하단으로 이동시키는 함수
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100), // 애니메이션 속도 조정
        curve: Curves.easeOut,
      );
    }
  }

  Map<String, dynamic> userInformation = {
    "username": "사용자",
    "profileImage": Image.asset(
      'assets/images/ProfileEx.png',
      height: 40,
      width: 40,
    ),
  };
  Map<String, dynamic> postInformation = {
    "postTitle": "분실물을 찾습니다.",
    "postmoney": "2000",
    "postIamge": Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvk4CldcJ9R1fxhVjxP4b7TIER1SaHZAETBg&s",
      height: 100,
      width: 100,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // 화면이 전체적으로 이동하지 않게 설정
      appBar: AppBarCustom(
        onSearchChanged: (value) {},
      ),
      body: Column(
        children: [
          // 사용자 정보 영역
          SizedBox(
            height: size.height * 0.1,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.profile,
                    width: size.width * 0.07, // 반응형 크기 설정
                    height: size.height * 0.07,
                  ),
                  SizedBox(width: size.width * 0.02), // 간격 반응형 설정
                  Text(
                    userInformation["username"],
                    style: TextStyle(
                      fontSize: size.width * 0.06, // 반응형 텍스트 크기
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          line(),
          // 게시물 정보 영역
          SizedBox(
            height: size.height * 0.15, // 고정된 높이 설정
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(size.width * 0.02), // 반응형 패딩
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: postInformation["postIamge"],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      postInformation["postTitle"],
                      style: TextStyle(
                        fontSize: size.width * 0.05, // 반응형 텍스트 크기
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "사례금 " + postInformation["postmoney"] + "원",
                      style: TextStyle(
                        fontSize: size.width * 0.04, // 반응형 텍스트 크기
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          line(),
          // 메시지 리스트 영역
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // ScrollController 연결
              itemCount: _messages.length,
              itemBuilder: (ctx, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: message.isUser
                        ? EdgeInsets.only(
                            top: size.height * 0.01,
                            bottom: size.height * 0.01,
                            right: size.width * 0.02,
                            left: size.width * 0.1,
                          )
                        : EdgeInsets.only(
                            top: size.height * 0.01,
                            bottom: size.height * 0.01,
                            right: size.width * 0.1,
                            left: size.width * 0.02,
                          ),
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.04,
                    ),
                    decoration: BoxDecoration(
                      color: message.isUser
                          ? const Color(0xFFEEEEEE)
                          : const Color(0xFF7E8EF1), // 메시지 색상 구분
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: message.imagePath != null
                        ? Image.file(
                            File(message.imagePath!),
                            width: size.width * 0.4,
                            height: size.height * 0.2,
                          )
                        : Text(
                            message.text!,
                            style: TextStyle(
                              fontSize: size.width * 0.04, // 반응형 텍스트 크기
                              color:
                                  message.isUser ? Colors.black : Colors.white,
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
          // 입력 필드 및 전송 버튼
          Padding(
            padding: EdgeInsets.only(
              bottom:
                  MediaQuery.of(context).viewInsets.bottom, // 키보드 높이만큼 패딩 추가
            ),
            child: Container(
              color: const Color(0xFF615EFC),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: size.width * 0.08, // 반응형 아이콘 크기
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    icon: Icon(
                      Icons.image_outlined,
                      color: Colors.white,
                      size: size.width * 0.08, // 반응형 아이콘 크기
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02, // 반응형 높이 패딩
                      ),
                      child: SizedBox(
                        height: size.height * 0.06,
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Aa..',
                            labelStyle: TextStyle(fontSize: size.width * 0.04),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: size.width * 0.06, // 반응형 아이콘 크기
                    ),
                    onPressed: _sendMessage, // 메시지 전송 버튼
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container line() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 1,
      color: Colors.black.withOpacity(0.3),
    );
  }
}

class Message {
  final String? text;
  final bool isUser; // true면 사용자가 보낸 메시지, false면 상대방이 보낸 메시지
  final String? imagePath; // 이미지 경로 추가

  Message({this.text, required this.isUser, this.imagePath});
}
