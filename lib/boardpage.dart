import 'package:flutter/material.dart';
import 'addpostpage.dart';
import 'viewpostpage.dart';
import 'dart:io';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  final List<Map<String, dynamic>> posts = [
    {
      'title': '첫 번째 게시글',
      'reward': '100,000원',
      'content': '본문 내용',
      'images': [null], // 이미지 파일 리스트
      'floor': '1층',
      'building': 'A관',
      'found': '찾습니다', // 잃어버린 상태
      'likes': 0, // 좋아요 수
      'liked': false, // 좋아요 여부
    },
    {
      'title': '두 번째 게시글',
      'reward': '200,000원',
      'content': '본문 내용',
      'images': [null],
      'floor': '2층',
      'building': 'B관',
      'found': '찾았습니다', // 찾은 상태
      'likes': 0,
      'liked': false, // 좋아요 여부
    },
  ];

  void addPost(String title, String reward, String content, List<File?> images,
      String floor, String building, String found) {
    setState(() {
      posts.add({
        'title': title,
        'reward': reward,
        'content': content,
        'images': images,
        'floor': floor,
        'building': building,
        'found': found,
        'likes': 0,
        'liked': false, // 추가된 게시글의 좋아요 여부 초기화
      });
    });
  }

  void toggleLikePost(int index) {
    setState(() {
      posts[index]['liked'] = !posts[index]['liked'];
      posts[index]['liked']
          ? posts[index]['likes'] += 1
          : posts[index]['likes'] -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewPostPage(
                    title: posts[index]['title'],
                    reward: posts[index]['reward'],
                    content: posts[index]['content'],
                    images: posts[index]['images'],
                    floor: posts[index]['floor'],
                    building: posts[index]['building'],
                    found: posts[index]['found'],
                    likes: posts[index]['likes'],
                    liked: posts[index]['liked'],
                    toggleLike: () => toggleLikePost(index),
                    initialLiked: posts[index]['liked'], // 필수 매개변수 추가
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: posts[index]['images'].isNotEmpty &&
                                  posts[index]['images'][0] != null
                              ? Image.file(
                                  posts[index]['images'][0],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/ex.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                posts[index]['title'],
                                style: const TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6.0),
                              Text(
                                '사례금: ${posts[index]['reward']}',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 12.0),
                              Text(
                                '${posts[index]['found']} • ${posts[index]['floor']} • ${posts[index]['building']}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        posts[index]['liked']
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: posts[index]['liked']
                                            ? Colors.red
                                            : null,
                                      ),
                                      onPressed: () {
                                        toggleLikePost(index);
                                      },
                                    ),
                                    Text(
                                      '${posts[index]['likes']}',
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 1,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPostPage(
                addPostCallback: addPost,
              ),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Image.asset('assets/images/add.png'),
      ),
    );
  }
}
