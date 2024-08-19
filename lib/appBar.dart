import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Row(
      children: [
        Image.asset(
          'assets/images/logo.png', // 로고 이미지 경로
          height: 40,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFEEEEEE),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/images/search.png', // 힌트 이미지 경로
                      height: 20,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              suggestionsCallback: (pattern) async {
                // 예시: 검색어를 포함한 항목들을 반환
                List<String> items = [
                  'Apple',
                  'Banana',
                  'Cherry',
                  'Date',
                  'Elderberry'
                ];
                return items
                    .where((item) =>
                        item.toLowerCase().contains(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) {
                // 사용자가 제안을 선택했을 때의 동작
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You selected: $suggestion')));
              },
            ),
          ),
        ),
      ],
    ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(4.0),
      child: Container(
        color: Colors.blue, // 파란색 줄 색상
        height: 4.0, // 파란색 줄 높이
      ),
    ),
    actions: [
      IconButton(
        icon: Image.asset('assets/images/sort.png'),
        onPressed: () {
          // 정렬 버튼 기능 추가
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sort button pressed')));
        },
      ),
      IconButton(
        icon: Image.asset('assets/images/alarm.png'),
        onPressed: () {
          // 알림 버튼 기능 추가
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notification button pressed')));
        },
      ),
      IconButton(
        icon: const Icon(Icons.account_circle),
        onPressed: () {
          // 사용자 프로필 버튼 기능 추가
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile button pressed')));
        },
      ),
    ],
  );
}
