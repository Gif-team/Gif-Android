import 'package:final_test/Chating/chating_list.dart';
import 'package:final_test/appBar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_test/data/assets.dart';
import 'package:final_test/data/colorData.dart';

import '../detail/detail.dart';
import '../edit/edit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, dynamic>> postInfo = [
    {
      'postId': 1,
      'details': {
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvk4CldcJ9R1fxhVjxP4b7TIER1SaHZAETBg&s',
        'title': '버즈 찾습니다',
        'price': 500,
        'realtime': '2024-12-14',
        'category': false,
        'Building': {
          'id': 1,
          'floor': 4,
        }
      },
    },
    {
      'postId': 2,
      'details': {
        'image':
            'https://sitem.ssgcdn.com/12/96/89/item/1000527899612_i1_750.jpg',
        'title': '텀블러 찾았습니다',
        'price': 700,
        'realtime': '2024-12-15',
        'category': true,
        'Building': {
          'id': 3,
          'floor': 2,
        }
      },
    },
    {
      'postId': 3,
      'details': {
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTu50GCJ0gTPBXCZi_9aOd0tjWfl_L7f6IwA&s',
        'title': '핸드폰 찾습니다',
        'price': 300,
        'realtime': '2024-12-15',
        'category': false,
        'Building': {
          'id': 2,
          'floor': 4,
        }
      },
    },
  ];

  String searchQuery = '';
  String? selectedCategory;
  int? selectedBuilding;
  int? selectedFloor;

  // 검색어 변경 시 호출되는 메서드
  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // 필터링 함수
    List<Map<String, dynamic>> getFilteredPosts() {
      return postInfo.where((post) {
        final title = post['details']['title'].toLowerCase();
        final matchCategory = selectedCategory == null ||
            post['details']['category'].toString() == selectedCategory;
        final matchBuilding = selectedBuilding == null ||
            post['details']['Building']['id'] == selectedBuilding;
        final matchFloor = selectedFloor == null ||
            post['details']['Building']['floor'] == selectedFloor;

        return title.contains(searchQuery.toLowerCase()) &&
            matchCategory &&
            matchBuilding &&
            matchFloor;
      }).toList();
    }

    final filteredPosts = getFilteredPosts();

    return Scaffold(
      appBar: AppBarCustom(onSearchChanged: _onSearchChanged),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '최신 게시물',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  Detail(
                                      postId: filteredPosts[index]['postId']),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0); // 오른쪽에서 왼쪽으로 이동
                                const end = Offset.zero;
                                const curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 1),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            side: BorderSide(
                              color: ColorData.postOutLine,
                              width: 2,
                            ),
                          ),
                          elevation: 0,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 16.0),
                                child: filteredPosts[index]['details']['image']
                                            .isNotEmpty ??
                                        false
                                    ? Image.network(
                                        filteredPosts[index]['details']
                                            ['image'],
                                        width: size.width * 0.3,
                                        height: size.width * 0.3,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        color: Colors.grey,
                                        width: size.width * 0.3,
                                        height: size.width * 0.3,
                                        child: Icon(Icons.image_not_supported,
                                            color: Colors.white),
                                      ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filteredPosts[index]['details']['title'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.05),
                                    ),
                                    Text(
                                      '사례금: ' +
                                          filteredPosts[index]['details']
                                                  ['price']
                                              .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width * 0.04,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.05),
                                    Text(
                                      (filteredPosts[index]['details']
                                                  ['category'] ??
                                              false)
                                          ? '찾았습니다 ' +
                                              '· ${filteredPosts[index]['details']['Building']['floor']}층 ' +
                                              '· ${_searchBuilding(filteredPosts[index]['details']['Building']['id'])}'
                                          : '찾습니다 ' +
                                              '· ${filteredPosts[index]['details']['Building']['floor']}층 ' +
                                              '· ${_searchBuilding(filteredPosts[index]['details']['Building']['id'])}',
                                      style: TextStyle(
                                        fontSize: size.width * 0.035,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatingList(),
                          ));
                    },
                    heroTag: 'chat',
                    backgroundColor: Colors.white,
                    elevation: 0,
                    child: SvgPicture.asset(Assets.chat_icon),
                  ),
                  const SizedBox(height: 16),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Edit(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0); // 아래에서 위로 이동
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    heroTag: 'add',
                    backgroundColor: Colors.white,
                    elevation: 0,
                    child: SvgPicture.asset(Assets.add_icon),
                  ),
                  const SizedBox(height: 16),
                  FloatingActionButton(
                    onPressed: () {
                      _showFilterDialog();
                    },
                    heroTag: 'flitter',
                    backgroundColor: Colors.white,
                    elevation: 0,
                    child: SvgPicture.asset(Assets.flitter_icon),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Map<int, String> buildingNames = {
    1: '기숙사',
    2: '본관',
    3: '금봉관',
  };

  String _searchBuilding(int num) => buildingNames[num] ?? '기타';

  // 필터 다이얼로그 표시
  void _showFilterDialog() {
    // 필터 초기화 함수
    void _resetFilters() {
      setState(() {
        selectedCategory = null;
        selectedBuilding = null;
        selectedFloor = null;
      });
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('필터 설정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedCategory,
                hint: const Text('카테고리 선택'),
                items: ['true', 'false']
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e == 'true' ? '찾았습니다' : '찾습니다'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              DropdownButton<int>(
                value: selectedBuilding,
                hint: const Text('건물 선택'),
                items: buildingNames.entries
                    .map((entry) => DropdownMenuItem<int>(
                          value: entry.key,
                          child: Text(entry.value),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBuilding = value;
                  });
                },
              ),
              DropdownButton<int>(
                value: selectedFloor,
                hint: const Text('층 선택'),
                items: List.generate(5, (index) => index + 1)
                    .map((floor) => DropdownMenuItem<int>(
                          value: floor,
                          child: Text('$floor 층'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFloor = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                _resetFilters(); // 필터 초기화
              },
              child: const Text('적용 취소'),
            ),
            TextButton(
              onPressed: () {
                setState(() {}); // 필터 적용
                Navigator.pop(context);
              },
              child: const Text('적용'),
            ),
          ],
        );
      },
    );
  }
}
