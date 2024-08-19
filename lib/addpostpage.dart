import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class AddPostPage extends StatefulWidget {
  final Function(String, String, String, List<File?>, String, String, String)
      addPostCallback;

  const AddPostPage({required this.addPostCallback, super.key});

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _rewardController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final List<File?> _images = [];

  String? _selectedFloor;
  String? _selectedBuilding;
  String? _selectedFound;

  final List<String> _floors = ['4층', '3층', '2층', '1층'];
  final List<String> _buildings = ['D관', 'C관', 'B관', 'A관'];
  final List<String> _founds = ['찾습니다', '찾았습니다'];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      setState(() {
        if (_images.length < 2) {
          _images.addAll(
            pickedFiles.take(2 - _images.length).map((file) => File(file.path)),
          );
        }
      });
    }
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String iconPath,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Expanded(
      child: Stack(
        children: [
          DropdownButtonFormField<String>(
            value: value,
            icon: Image.asset('assets/images/dropdown_icon.png',
                width: 24, height: 24),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero, borderSide: BorderSide.none),
              filled: true,
              fillColor: backgroundColor,
            ),
            isExpanded: true,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 16, color: textColor),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            hint: Align(
              alignment: Alignment.center,
              child: Text(
                hint,
                style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Image.asset(iconPath, width: 30, height: 30),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('게시물 추가', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Wrap(
                        spacing: 8.0,
                        children: _images
                            .map((image) => image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: SizedBox(
                                      width: 120,
                                      height: 120,
                                      child:
                                          Image.file(image, fit: BoxFit.cover),
                                    ),
                                  )
                                : const SizedBox.shrink())
                            .toList(),
                      ),
                      if (_images.length < 2)
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: IconButton(
                            onPressed: _pickImages,
                            icon: Image.asset('assets/images/camera.png',
                                fit: BoxFit.cover),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: Color(0xFFCBCCCE), thickness: 1.6),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: '제목을 입력해주세요 (최대글자 20자)',
                      hintStyle: TextStyle(
                          color: Color(0xFFCBCCCE),
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 16.0),
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(20)],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w700),
                    textAlignVertical: TextAlignVertical.center,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          controller: _rewardController,
                          decoration: const InputDecoration(
                            hintText: '사례금을 입력하세요',
                            hintStyle: TextStyle(
                                color: Color(0xFFCBCCCE),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      hintText: '설명을 입력하세요 (최대 200글자)',
                      hintStyle: TextStyle(
                          color: Color(0xFFCBCCCE),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(200)],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      _buildDropdown(
                        hint: '  층',
                        value: _selectedFloor,
                        items: _floors,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedFloor = newValue;
                          });
                        },
                        iconPath: 'assets/images/floor_icon.png',
                        backgroundColor: const Color(0xFFEDEDED),
                        textColor: Colors.black,
                      ),
                      _buildDropdown(
                        hint: '   관',
                        value: _selectedBuilding,
                        items: _buildings,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedBuilding = newValue;
                          });
                        },
                        iconPath: 'assets/images/building_icon.png',
                        backgroundColor: const Color(0xFFF4F4F4),
                        textColor: Colors.black,
                      ),
                      _buildDropdown(
                        hint: '분실물',
                        value: _selectedFound,
                        items: _founds,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedFound = newValue;
                          });
                        },
                        iconPath: 'assets/images/found_icon.png',
                        backgroundColor: const Color(0xFFF4F4F4),
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final String title = _titleController.text;
                    final String reward = _rewardController.text;
                    final String content = _contentController.text;

                    if (title.isNotEmpty &&
                        content.isNotEmpty &&
                        _selectedFloor != null &&
                        _selectedBuilding != null &&
                        _selectedFound != null) {
                      widget.addPostCallback(
                        title,
                        reward,
                        content,
                        _images,
                        _selectedFloor!,
                        _selectedBuilding!,
                        _selectedFound!,
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('모든 필드를 입력해주세요.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7E8EF1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: const Text(
                    '수정',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
