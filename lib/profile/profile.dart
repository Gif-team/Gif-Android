import 'package:final_test/appBar/app_bar.dart';
import 'package:final_test/changePassWord/changePassWord.dart';
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

  final List<Map<String, dynamic>> postInfo = [
    {
      'title': '게시물 제목',
      'image':
          'https://img1.daumcdn.net/thumb/R1280x0.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/eDNQ/image/92MZWKbvqtzyta5_WkPIv4ZKFZw',
      'gratuity': '1,000원',
      'category': true,
      'building': 1,
      'floor': 1,
      'realtime': 1,
      'likeNumber': 0,
      'like': false,
    },
    {
      'title': '게시물 제목2',
      'image': '',
      'gratuity': '3,000원',
      'category': false,
      'building': 2,
      'floor': 3,
      'realtime': 3,
      'likeNumber': 2,
      'like': true,
    },
  ];

  void likeToggle(int index) {
    setState(() {
      postInfo[index]['like'] = !postInfo[index]['like']; // 상태 반전
      if (postInfo[index]['like']) {
        postInfo[index]['likeNumber']++; // 좋아요 증가
      } else {
        postInfo[index]['likeNumber']--; // 좋아요 감소
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const AppBarCustom(),
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
                        buildTextButton('로그아웃', () {}),
                        buildTextButton('뱃지 보기', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BadgePage(),
                              ));
                        }),
                        buildTextButton('비밀번호 변경', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePasswordPage(),
                              ));
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
                  onTap: () {},
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
                          child: postInfo[index]['image']?.isNotEmpty ?? false
                              ? Image.network(
                                  postInfo[index]['image'],
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
                                postInfo[index]['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.05),
                              ),
                              Text(
                                '사례금: ' + postInfo[index]['gratuity'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.04,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.4,
                                    child: Text(
                                      postInfo[index]['category']
                                          ? '찾았습니다 ' +
                                              '· ${postInfo[index]['floor']}층 ' +
                                              '· ${_searchBuilding(postInfo[index]['building'])}'
                                          : '찾습니다 ' +
                                              '· ${postInfo[index]['floor']}층 ' +
                                              '· ${_searchBuilding(postInfo[index]['building'])}',
                                      style: TextStyle(
                                        fontSize: size.width * 0.035,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          likeToggle(index); // 좋아요 토글 함수 호출
                                        },
                                        icon: postInfo[index]['like']
                                            ? const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : Icon(
                                                Icons.favorite_border_outlined,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                      ),
                                      Text(
                                        '${postInfo[index]['likeNumber']}',
                                        style: TextStyle(
                                          fontSize: size.width * 0.035,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
