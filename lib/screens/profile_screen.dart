import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/utils/app_theme.dart';
import 'package:meditation_app/utils/asset_utils.dart';
import 'package:meditation_app/widgets/bottom_bar_widget.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Profile(),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 36, 16, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(AssetUtils.likeIcon),
              Expanded(
                child: Column(
                  children: [
                    Image.asset(
                      AssetUtils.avatarIcon,
                      width: MediaQuery.of(context).size.width * .3,
                    ),
                    Text(
                      "Nataliya Lebediva",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              SvgPicture.asset(AssetUtils.settingIcon),
            ],
          ),
        ),
        ProfileCard(
          title: "Practices",
          icon: AssetUtils.practiceIcon,
          session: "13",
          time: "4:23:04",
        ),
        ProfileCard(
          title: "Meditations",
          icon: AssetUtils.meditationIcon,
          session: "6",
          time: "0:55:04",
        ),
        StatsCard(),
      ],
    );
  }
}

class StatsCard extends StatelessWidget {
  final List days = ["Sun", "Mon", "Tue", "Wen", "Thu", "Fri", "Sat"];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppTheme.profileCardBg,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Stats",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Last week",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          StatsIndicator(
            title: "Practices",
            time: "0:43:05",
            color: Color(0xff2D31AC),
          ),
          const SizedBox(height: 8),
          StatsIndicator(
            title: "Meditations",
            time: "0:15:45",
            color: Color(0xffFB9B9C),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(7, (i) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Bar(
                            color: Color(0xffFB9B9C),
                          ),
                          Bar(
                            color: Color(0xff2D31AC),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      days[i],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  Bar({
    required this.color,
  });

  final Color color;
  final Random random = new Random();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: random.nextInt(15).roundToDouble() + 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
      ),
    );
  }
}

class StatsIndicator extends StatelessWidget {
  final String? title;
  final Color? color;
  final String? time;

  const StatsIndicator({Key? key, this.title, this.color, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title ?? "",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 16,
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              Text(
                time ?? "",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String? title;
  final String? icon;
  final String? session;
  final String? time;

  const ProfileCard({Key? key, this.title, this.icon, this.session, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppTheme.profileCardBg,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon ?? "",
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title ?? "",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CardRow(
                title: "Sessions",
                value: session,
                flex: 1,
              ),
              CardRow(
                title: "Time",
                value: time,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardRow extends StatelessWidget {
  final String? title;
  final String? value;
  final int? flex;

  const CardRow({Key? key, this.title, this.value, this.flex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title ?? "",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: flex ?? 2,
            child: Text(
              value ?? "",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
