import 'package:final_test/appBar/app_bar.dart';
import 'package:final_test/data/assets.dart';
import 'package:final_test/data/colorData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  // 텍스트 입력 컨트롤러 정의
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // 이미지 리스트 (선택된 이미지들을 저장)
  List<File> _images = [];

  // 상태 변수 초기화
  bool _category = true; // 카테고리 기본값: 찾았습니다 (true)
  int _buildingId = 1; // 건물 기본값: 기숙사 (1)
  int _floor = 1; // 층 기본값: 1층

  // 폼 검증 함수
  bool _isFormValid() {
    // 필수 항목들이 비어있는지 확인
    if (_titleController.text.isEmpty) return false; // 제목 확인
    if (_contentController.text.isEmpty) return false; // 설명 확인
    if (_priceController.text.isEmpty) return false; // 가격 확인
    if (_images.isEmpty) return false; // 이미지 확인
    if (_buildingId == 0) return false; // 건물 선택 확인
    if (_floor == 0) return false; // 층 선택 확인
    return true; // 모든 필수 항목이 채워진 경우
  }

  // 갤러리에서 이미지 선택 함수
  Future<void> _pickImage() async {
    if (_images.length < 3) {
      // 최대 3개까지만 이미지 추가 가능
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _images.add(File(image.path)); // 이미지 추가
        });
      }
    } else {
      // 이미지가 3개를 초과할 경우 경고 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이미지는 최대 3개까지 선택할 수 있습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // 화면 크기 가져오기
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarCustom(
        onSearchChanged: (String value) {}, // 검색 입력 이벤트 핸들러
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // 전체 여백 설정
        child: Column(
          children: [
            // 이미지 및 이미지 추가 아이콘 표시 영역
            Row(
              children: [
                ..._images.map((image) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        image,
                        width: size.width * 0.27,
                        height: size.width * 0.27,
                        fit: BoxFit.cover, // 이미지 비율 유지
                      ),
                    ),
                  );
                }).toList(),
                if (_images.length < 3) // 최대 3개 제한
                  IconButton(
                    onPressed: _pickImage, // 이미지 선택 함수 호출
                    icon: SvgPicture.asset(
                      Assets.camera,
                      width: size.width * 0.27,
                    ),
                  ),
              ],
            ),
            const Divider(thickness: 1.0), // 구분선

            // 제목 입력 필드
            TextField(
              controller: _titleController, // 제목 입력 컨트롤러
              decoration: InputDecoration(
                hintText: '제목을 입력해주세요',
                border: InputBorder.none, // 테두리 없음
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold),
              ),
            ),

            // 가격 입력 필드
            SizedBox(
              height: size.height * 0.05, // 높이 조정
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.06,
                    height: size.width * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2), // 색상 투명도 조정
                      borderRadius: BorderRadius.circular(5), // 둥근 테두리
                    ),
                  ),
                  SizedBox(width: size.width * 0.02), // 간격
                  SizedBox(
                    width: size.width * 0.5, // 필드 너비 조정
                    child: TextField(
                      controller: _priceController, // 가격 입력 컨트롤러
                      keyboardType: TextInputType.number, // 숫자 키패드
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

            // 설명 입력 필드
            TextField(
              controller: _contentController, // 설명 입력 컨트롤러
              decoration: InputDecoration(
                hintText: '설명을 입력하세요',
                border: InputBorder.none,
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: size.height * 0.02), // 간격 추가

            // 드롭다운 메뉴들 (카테고리, 건물, 층)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 카테고리 드롭다운
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

                // 건물 드롭다운
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

                // 층 드롭다운
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
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          Text('${index + 1}층'),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),

            // 하단 버튼
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorData.mainColor, // 버튼 배경색
                ),
                onPressed: () {
                  if (_isFormValid()) {
                    // 게시물 데이터 출력 (디버깅용)
                    print('제목: ${_titleController.text}');
                    print('설명: ${_contentController.text}');
                    print('가격: ${_priceController.text}');
                    print('카테고리: $_category');
                    print('건물 ID: $_buildingId');
                    print('층: $_floor');
                    print('이미지 수: ${_images.length}');

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('게시물 작성 완료!')),
                    );
                  } else {
                    // 폼 검증 실패 시 경고 메시지
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('모든 필드를 채워주세요.')),
                    );
                  }
                },
                child: const Text(
                  '추가하기',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
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
