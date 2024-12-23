import 'package:final_test/appBar/app_bar.dart';
import 'package:final_test/changePassWord/changePassWord.dart';
import 'package:final_test/profile/profile_detail.dart';
import 'package:final_test/start/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/assets.dart';
import '../data/colorData.dart';
import '../badge/badge.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = '사용자';

  // 하드코딩된 게시물 데이터
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
  ];

  void logout() {
    // 로그아웃 시 앱의 시작 화면으로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Start()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarCustom(
        onSearchChanged: (String value) {},
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Assets.profile, height: size.width * 0.25),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Text(
                      userName,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.055),
                    ),
                  ],
                ),
                Card(
                  color: Colors.white,
                  elevation: 0,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          '프로필',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.04),
                        ),
                        Container(
                          height: 0.5,
                          width: size.width * 0.17,
                          color: Colors.grey,
                        ),
                        buildTextButton('회원탈퇴', () {}),
                        buildTextButton('로그아웃', logout),
                        buildTextButton('뱃지 보기', () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      BadgePage(),
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
                        }),
                        buildTextButton('비밀번호 변경', () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      ChangePasswordPage(),
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
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: postInfo.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ProfileDetail(postId: postInfo[index]['postId']),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0); // 아래에서 위로 이동
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
                          child: postInfo[index]['details']['image']
                                      ?.isNotEmpty ??
                                  false
                              ? Image.network(
                                  postInfo[index]['details']['image'],
                                  width: size.width * 0.3,
                                  height: size.width * 0.3,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Container(
                                      width: size.width * 0.3,
                                      height: size.width * 0.3,
                                      color: Colors.grey[300],
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: size.width * 0.3,
                                      height: size.width * 0.3,
                                      color: Colors.grey,
                                      child: Icon(Icons.broken_image,
                                          color: Colors.white),
                                    );
                                  },
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                postInfo[index]['details']['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.05),
                              ),
                              Text(
                                '가격: ' +
                                    postInfo[index]['details']['price']
                                        .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.04,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Text(
                                (postInfo[index]['details']['category'] ??
                                        false)
                                    ? '찾았습니다 ' +
                                        '· ${postInfo[index]['details']['Building']['floor']}층 ' +
                                        '· ${_searchBuilding(postInfo[index]['details']['Building']['id'])}'
                                    : '찾습니다 ' +
                                        '· ${postInfo[index]['details']['Building']['floor']}층 ' +
                                        '· ${_searchBuilding(postInfo[index]['details']['Building']['id'])}',
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
          )
        ],
      ),
    );
  }

  Widget buildTextButton(String buttonText, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  String? _searchBuilding(int num) {
    if (num == 1) {
      return '기숙사';
    } else if (num == 2) {
      return '본관';
    } else {
      return '금봉관';
    }
  }
}
