import 'package:final_test/data/colorData.dart';
import 'package:final_test/mainPage/main_page.dart';
import 'package:final_test/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/assets.dart';

class AppBarCustom extends StatefulWidget implements PreferredSizeWidget {
  final ValueChanged<String> onSearchChanged; // 콜백 함수

  const AppBarCustom({super.key, required this.onSearchChanged});

  @override
  _AppBarCustomState createState() => _AppBarCustomState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      shape: Border(
        bottom: BorderSide(
          color: ColorData.mainColor,
          width: 1,
        ),
      ),
      actions: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0, 1); // 오른쪽에서 왼쪽으로 이동
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              icon: SvgPicture.asset(
                Assets.logo1,
                width: size.width * 0.035,
                height: size.height * 0.035,
              ),
            ),

            Center(
              child: SearchBar(
                backgroundColor: WidgetStatePropertyAll(ColorData.grayColor),
                elevation: WidgetStatePropertyAll(0),
                leading: SvgPicture.asset(
                  Assets.search,
                  height: size.height * 0.03,
                  width: size.width * 0.03,
                ),
                constraints: BoxConstraints(
                  minHeight: size.height * 0.045,
                  maxWidth: size.width * 0.65,
                ),
                onChanged: widget.onSearchChanged, // 콜백 함수 호출
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                Assets.alarm,
                height: size.height * 0.03,
                width: size.width * 0.03,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => Profile(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0); // 오른쪽에서 왼쪽으로 이동
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              icon: SvgPicture.asset(
                Assets.profile,
                height: size.height * 0.03,
                width: size.width * 0.03,
              ),
            ),

          ],
        ),
      ],
    );
  }
}
