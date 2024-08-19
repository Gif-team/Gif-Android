import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:io';

class ViewPostPage extends StatefulWidget {
  final String title;
  final String reward;
  final String content;
  final List<File?> images;
  final String floor;
  final String building;
  final String found;
  final int likes;
  final bool liked;
  final Function toggleLike;
  final bool initialLiked;

  const ViewPostPage({
    super.key,
    required this.title,
    required this.reward,
    required this.content,
    required this.images,
    required this.floor,
    required this.building,
    required this.found,
    required this.likes,
    required this.liked,
    required this.toggleLike,
    required this.initialLiked,
  });

  @override
  _ViewPostPageState createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage> {
  int _currentImageIndex = 0;

  void _nextImage() {
    setState(() {
      if (_currentImageIndex < widget.images.length - 1) {
        _currentImageIndex++;
      }
    });
  }

  void _previousImage() {
    setState(() {
      if (_currentImageIndex > 0) {
        _currentImageIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 350, // 이미지 높이 설정
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 30.0),
                    onPressed: _previousImage,
                  ),
                  Expanded(
                    child: widget.images.isNotEmpty &&
                            widget.images.any((image) => image != null)
                        ? PageView.builder(
                            itemCount: widget.images.length,
                            controller:
                                PageController(initialPage: _currentImageIndex),
                            onPageChanged: (index) {
                              setState(() {
                                _currentImageIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(16.0), // 모서리 둥글게 설정
                                  image: DecorationImage(
                                    image: widget.images[index] != null
                                        ? FileImage(widget.images[index]!)
                                        : const AssetImage(
                                                'assets/images/ex.png')
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(16.0), // 모서리 둥글게 설정
                              image: const DecorationImage(
                                image: AssetImage('assets/images/ex.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 30.0),
                    onPressed: _nextImage,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.account_circle, size: 40.0),
                    SizedBox(width: 8.0),
                    Text('사용자',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: null,
                      style: ButtonStyle(
                        minimumSize:
                            WidgetStateProperty.all<Size>(const Size(100, 45)),
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return Colors.blueGrey; // 눌림 상태에서의 색상
                          }
                          return const Color(0xFF615EFC); // 기본 배경색
                        }),
                        foregroundColor: WidgetStateProperty.all<Color>(
                            Colors.white), // 버튼의 텍스트 색상
                      ),
                      child: const Text("챗팅하기"),
                    ),
                    const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.more_vert_rounded,
                          color: Colors.black,
                        ))
                  ],
                )
              ],
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 20.0), // 줄과 상하 요소 간의 간격
              height: 4.0, // 줄의 두께
              decoration: BoxDecoration(
                color: const Color(0xFF7E8EF1), // 줄 색상
                borderRadius: BorderRadius.circular(5.0), // 모서리 둥글게 설정
              ),
              width: double.infinity, // 줄의 너비를 부모의 너비로 설정
            ),
          ],
        ),
      ),
    );
  }
}
