// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/blocs/bloc.dart';
import 'package:meditation_app/screens/home_screen.dart';
import 'package:meditation_app/screens/profile_screen.dart';
import 'package:meditation_app/utils/app_theme.dart';
import 'package:meditation_app/utils/asset_utils.dart';

class BottomBarWidget extends StatefulWidget {
  @override
  BottomBarWidgetState createState() => BottomBarWidgetState();
}

class BottomBarWidgetState extends State<BottomBarWidget> {
  // static int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        initialData: 0,
        stream: Bloc.getInstance()!.selectedStream(),
        builder: (context, snapshot) {
          final isSelected = snapshot.data ?? 0;
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppTheme.bgColor,
            selectedItemColor: AppTheme.bottomNavBarSelectedColor,
            unselectedItemColor: AppTheme.bottomNavBarUnselectedColor,
            onTap: (value) {
              // if (isSelected != value) {
              // Navigator.of(context).popUntil((route) => route.isFirst);
              // isSelected = value;
              if (value == 0 || value == 3) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
              if (value == 0 && value != snapshot.data) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
                Bloc.getInstance()!.selectTab(value);
              } else if (value == 3 && value != snapshot.data) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
                Bloc.getInstance()!.selectTab(value);
              }

              // }
            },
            items: [
              BottomNavigationBarItem(
                title: Container(),
                icon: SvgPicture.asset(
                  isSelected == 0
                      ? AssetUtils.selectedHomeIcon
                      : AssetUtils.unselectedHomeIcon,
                ),
              ),
              BottomNavigationBarItem(
                title: Container(),
                icon: SvgPicture.asset(
                  isSelected == 1
                      ? AssetUtils.selectedLessonIcon
                      : AssetUtils.unselectedLessonIcon,
                ),
              ),
              BottomNavigationBarItem(
                title: Container(),
                icon: SvgPicture.asset(
                  isSelected == 2
                      ? AssetUtils.selectedMeditationIcon
                      : AssetUtils.unselectedMeditationIcon,
                ),
              ),
              BottomNavigationBarItem(
                title: Container(),
                icon: SvgPicture.asset(
                  isSelected == 3
                      ? AssetUtils.selectedProfileIcon
                      : AssetUtils.unselectedProfileIcon,
                ),
              ),
            ],
          );
        });
  }
}
