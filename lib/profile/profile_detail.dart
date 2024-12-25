import 'dart:convert';
import 'package:final_test/data/colorData.dart';
import 'package:final_test/update/update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../appBar/app_bar.dart';
import '../data/assets.dart';

class ProfileDetail extends StatefulWidget {
  ProfileDetail({super.key, required this.postId});

  final int postId;

  @override
  State<ProfileDetail> createState() => _DetailState();
}

final Map<int, Map<String, dynamic>> postData = {
  1: {
    'title': '버즈 찾습니다',
    'content': '하얀색 버즈2 찾습니다. 기숙사 4층에서 잃어버린거 같습니다.',
    'likeNumber': 3,
    'images': [
      {
        'imageId': 1,
        'imageName': 'name',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvk4CldcJ9R1fxhVjxP4b7TIER1SaHZAETBg&s',
      },
      {
        'imageId': 2,
        'imageName': 'name',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTeLA6EOhpwUL2OIooP7vUSRD6HiMfWMNzFy4VCwCjdk-XvM5wynApyFgOQriINUfFR7P7OHXzzheydE1kjIeWZHa_PhAbcLHDg1t7kXKxS45s4hDkSGZ2JRzg&usqp=CAE',
      }
    ],
    'price': 500,
    'writer': '나현욱',
    'writerId': 1,
    'realtime': 20241214,
    'category': true,
    'building': {
      'id': 2,
      'floor': 5,
    },
  },
  2: {
    'title': '텀블러 찾았습니다',
    'content': '텀블러 찾았습니다. 중간에 곰 그림이 그려져있습니다.',
    'likeNumber': 4,
    'images': [
      {
        'imageId': 1,
        'imageName': 'name',
        'imageUrl':
            'https://sitem.ssgcdn.com/12/96/89/item/1000527899612_i1_750.jpg',
      },
    ],
    'price': 700,
    'writer': '나현욱',
    'writerId': 1,
    'realtime': 20241214,
    'category': true,
    'building': {
      'id': 2,
      'floor': 5,
    },
  },
};

class _DetailState extends State<ProfileDetail> {
  int _currentImageIndex = 0;
  bool _isLiked = false; // 좋아요 상태 추적
  int _likeNumber = 0;

  // 좋아요 클릭 시 상태 업데이트하는 함수
  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _isLiked = false;
        _likeNumber--;
      } else {
        _isLiked = true;
        _likeNumber++;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // 서버 통신을 없애고 postData를 사용하여 초기 값 설정
    final post = postData[widget.postId];
    if (post != null) {
      _likeNumber = post['likeNumber'];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // postId로 해당 게시물을 찾기
    final post = postData[widget.postId];

    if (post == null) {
      // 해당 ID의 게시글이 없으면 에러 처리
      return Scaffold(
        body: Center(child: Text("게시글을 찾을 수 없습니다.")),
      );
    }

    // 초기 좋아요 숫자 설정
    _likeNumber = post['likeNumber'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCustom(onSearchChanged: (String value) {}),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 이미지 슬라이더
            SizedBox(
              height: size.height * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: post['images']!.length,
                      controller: PageController(
                        initialPage: _currentImageIndex,
                      ),
                      onPageChanged: (index) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final imageUrl = post['images'][index]['imageUrl'] ??
                            'https://via.placeholder.com/150'; // 기본 이미지 URL 설정
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(size.width * 0.1),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                  'https://via.placeholder.com/150');
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),

            // 사용자 정보
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Assets.profile), // 프로필 이미지
                    SizedBox(width: size.width * 0.02),
                    Text(post['writer'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorData.mainColor),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UpdatePost(postId: widget.postId),
                            ));
                      },
                      child: Text(
                        '수정하기',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          side: BorderSide(
                            width: 1,
                            color: ColorData.mainColor,
                          )),
                      onPressed: () {},
                      child: Text(
                        '끌어올리기',
                        style: TextStyle(
                          color: ColorData.mainColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),

            // 구분선
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 15),
              height: size.height * 0.002,
              decoration: BoxDecoration(
                color: const Color(0xFF7E8EF1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              width: double.infinity,
            ),

            // 게시글 상세 정보
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post['title'],
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: size.height * 0.001),
                    Text(
                        "${post['category'] ? '찾습니다' : '잃어버렸습니다'} · ${post['realtime']}",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(height: size.height * 0.01),
                    Text("사례금 : ${post['price']}",
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: size.height * 0.02),
                    Text(post['content'], style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),

            // 좋아요와 좋아요 수
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    color: _isLiked ? Colors.red : Colors.black,
                  ),
                  onPressed: _toggleLike,
                ),
                Text('$_likeNumber', style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
