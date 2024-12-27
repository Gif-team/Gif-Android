import 'dart:convert';

import 'package:final_test/appBar/app_bar.dart';
import 'package:final_test/data/assets.dart';
import 'package:final_test/data/colorData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UpdatePost extends StatefulWidget {
  final int postId;

  const UpdatePost({super.key, required this.postId});

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<File> _images = []; // 선택된 이미지 리스트

  bool _category = true; // 기본 값: true (찾았습니다)
  int _buildingId = 1; // 기본 값: 기숙사
  int _floor = 1; // 기본 값: 1층

  @override
  void initState() {
    super.initState();
    _loadPostData();
  }

  void _loadPostData() {
    // 서버 호출 대신 하드코딩된 데이터로 대체
    final Map<String, dynamic> mockData = {
      'title': '임시 제목',
      'content': '임시 내용',
      'price': 10000,
      'category': true,
      'building': {'id': 1, 'floor': 2},
      'images': [],
    };

    setState(() {
      _titleController.text = mockData['title'] as String; // 타입 명시적으로 변환
      _contentController.text = mockData['content'] as String; // 타입 명시적으로 변환
      _priceController.text =
          (mockData['price'] as int).toString(); // 정수를 문자열로 변환
      _category = mockData['category'] as bool; // 타입 변환
      _buildingId = mockData['building']['id'] as int; // 중첩 데이터 변환
      _floor = mockData['building']['floor'] as int; // 중첩 데이터 변환
      _images = []; // 이미지 데이터는 비워둠
    });
  }

  bool _isFormValid() {
    // 유효성 검사
    return _titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _images.isNotEmpty;
  }

  Future<void> _pickImage() async {
    if (_images.length < 3) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _images.add(File(image.path));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이미지는 최대 3개까지 선택할 수 있습니다.')),
      );
    }
  }

  void _updatePost() {
    if (_isFormValid()) {
      // 수정 완료 시뮬레이션
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('게시물이 수정되었습니다. (임시 데이터 처리)')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 필드를 채워주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarCustom(onSearchChanged: (String value) {}),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                ..._images.map((image) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        image,
                        width: size.width * 0.3,
                        height: size.width * 0.3,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
                if (_images.length < 3)
                  IconButton(
                    onPressed: _pickImage,
                    icon: SvgPicture.asset(
                      Assets.camera,
                      width: size.width * 0.3,
                    ),
                  ),
              ],
            ),
            const Divider(thickness: 1.0),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: '제목을 입력해주세요',
                border: InputBorder.none,
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: size.height * 0.05,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.06,
                    height: size.width * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  SizedBox(
                    width: size.width * 0.5,
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '사례금을 입력해주세요',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: '설명을 입력하세요',
                border: InputBorder.none,
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDropdownButton<bool>(
                  value: _category,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: true,
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.find),
                          const SizedBox(width: 8),
                          const Text('찾았습니다'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.lost),
                          const SizedBox(width: 8),
                          const Text('잃어버렸습니다'),
                        ],
                      ),
                    ),
                  ],
                ),
                _buildDropdownButton<int>(
                  value: _buildingId,
                  onChanged: (int? newValue) {
                    setState(() {
                      _buildingId = newValue!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.dormitory),
                          const SizedBox(width: 8),
                          const Text('기숙사'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.mainBuilding),
                          const SizedBox(width: 8),
                          const Text('본관'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.geumbong),
                          const SizedBox(width: 8),
                          const Text('금봉관'),
                        ],
                      ),
                    ),
                  ],
                ),
                _buildDropdownButton<int>(
                  value: _floor,
                  onChanged: (int? newValue) {
                    setState(() {
                      _floor = newValue!;
                    });
                  },
                  items: List.generate(5, (index) {
                    return DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1}층'),
                    );
                  }),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.2),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorData.mainColor,
              ),
              onPressed: _updatePost,
              child: const Text(
                '수정하기',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownButton<T>({
    required T value,
    required void Function(T?) onChanged,
    required List<DropdownMenuItem<T>> items,
  }) {
    return DropdownButton<T>(
      value: value,
      onChanged: onChanged,
      items: items,
      icon: const Icon(
        Icons.arrow_drop_down,
        size: 30,
      ),
      underline: Container(),
    );
  }
}
