// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/screens/see_all_screen.dart';
import 'package:meditation_app/utils/app_theme.dart';
import 'package:meditation_app/utils/asset_utils.dart';
import 'package:meditation_app/widgets/bottom_bar_widget.dart';
import 'package:meditation_app/widgets/heading_section.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: AppTheme.primaryColor,
        toolbarHeight: 3,
      ),
      body: Home(),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        HomeHeader(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadingSection(
              title: "Popular",
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SeeAllScreen()));
              },
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HomeCard(
                    bg: AssetUtils.card1,
                    title: "Anxiety",
                    desc: "Turn down the stress\nvolume",
                    duration: "7 steps | 5-11 min",
                  ),
                  const SizedBox(width: 12),
                  HomeCard(
                    bg: AssetUtils.card2,
                    title: "Anxiety",
                    desc: "Turn down the stress\nvolume",
                    duration: "5 steps | 5-11 min",
                  ),
                ],
              ),
            ),
            HeadingSection(title: "New"),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HomeCard(
                    bg: AssetUtils.card3,
                    title: "Happiness",
                    desc: "Daily Calm",
                    duration: "7 steps | 3-11 min",
                  ),
                  const SizedBox(width: 12),
                  HomeCard(
                    bg: AssetUtils.card4,
                    title: "Spiritual",
                    desc: "Daily Calm",
                    duration: "5 steps | 6-11 min",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ],
    );
  }
}

class HomeCard extends StatelessWidget {
  final String? bg;
  final String? title;
  final String? desc;
  final String? duration;

  const HomeCard({Key? key, this.bg, this.title, this.desc, this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          bg ?? "",
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      title ?? "",
                      style: TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  desc ?? "",
                  style: TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
            child: Text(
              duration ?? "",
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              AssetUtils.homeHeaderBg,
              fit: BoxFit.fill,
            ),
          ],
        ),
        Positioned(
          top: 30,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DAY 7",
                style: TextStyle(
                  color: AppTheme.bottomNavBarUnselectedColor,
                  fontSize: 13,
                ),
              ),
              Text(
                "Love And Accept\nYourself",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 0,
          child: SvgPicture.asset(
            AssetUtils.illustrationNatureRht,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: SvgPicture.asset(
            AssetUtils.illustrationNatureBtm,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          bottom: -20,
          right: 0,
          child: SvgPicture.asset(
            AssetUtils.illustrationGirl,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
