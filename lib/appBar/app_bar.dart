import 'package:final_test/data/colorData.dart';
import 'package:final_test/mainPage/main_page.dart';
import 'package:final_test/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/assets.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({super.key});

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
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ));
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
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
              icon: SvgPicture.asset(
                Assets.profile,
                height: size.height * 0.03,
                width: size.width * 0.03,
              ),
            )
          ],
        ),
      ],
    );
  }

  // AppBar의 기본 높이 지정
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
