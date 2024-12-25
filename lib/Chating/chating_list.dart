import 'package:final_test/data/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../appBar/app_bar.dart';
import '../Chating/chating.dart';

class ChatingList extends StatelessWidget {
  ChatingList({super.key});

  final userInformation = <Map<String, dynamic>>[
    {
      "name": "김민준",
      "preMessage": "안녕하세요/프로필메시지",
    },
    {
      "name": "김준혁",
      "preMessage": "안녕하세요/프로필메시지",
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarCustom(
        onSearchChanged: (value) {},
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft, // 왼쪽 정렬로 변경
              child: Text(
                "채팅",
                style: TextStyle(
                  fontSize: size.width * 0.1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: size.width * 0.05,
                horizontal: size.width * 0.05,
              ),
            ),
            Expanded(
              // ListView를 Expanded로 감싸기
              child: ListView.builder(
                itemCount: userInformation.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Chating(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0); // 오른쪽에서 왼쪽으로
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
                      margin: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(width: 0.5, color: Color(0xFFBEBEBE)),
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              Assets.profile,
                              width: size.width * 0.15,
                            ),
                            // 추가적으로 다른 정보도 표시할 수 있습니다.
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text(
                                          userInformation[index]["name"],
                                          style: TextStyle(
                                              fontSize: size.width * 0.1,
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xFF3C3C3E))),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Text(
                                    userInformation[index]["preMessage"],
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
