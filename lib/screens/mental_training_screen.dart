import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/utils/app_theme.dart';
import 'package:meditation_app/utils/asset_utils.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class MentalTrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: AppTheme.primaryColor,
        toolbarHeight: 3,
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset(
                    AssetUtils.mentalTrainingBG,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Mental Training",
                              style: TextStyle(
                                color: AppTheme.textColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: AppTheme.textColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          color: AppTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PlayerWidget()
            ],
          ),
        ],
      ),
    );
  }
}

class PlayerWidget extends StatefulWidget {
  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  format(Duration d) => d.toString().substring(2, 7);

  @override
  void initState() {
    super.initState();
    audioPlayer.open(Audio(AssetUtils.audio));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: height * .10,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
        width: width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SvgPicture.asset(AssetUtils.unlikeIcon),
                ),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () async {
                      if (audioPlayer.isPlaying.value) {
                        audioPlayer.pause();
                      } else {
                        audioPlayer.play();
                      }
                    },
                    child: StreamBuilder<bool>(
                      stream: audioPlayer.isPlaying,
                      builder: (context, snapshot) {
                        if (snapshot.data ?? false) {
                          return SvgPicture.asset(
                            AssetUtils.pauseIcon,
                            // height: 54,
                            // width: 54,
                          );
                        } else {
                          return Icon(
                            Icons.play_arrow_sharp,
                            size: 54,
                            color: AppTheme.textColor,
                          );
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SvgPicture.asset(AssetUtils.sliderIcon),
                ),
              ],
            ),
            StreamBuilder<RealtimePlayingInfos>(
              stream: audioPlayer.realtimePlayingInfos,
              builder: (context, snapshot) {
                return SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 1,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.0),
                  ),
                  child: Slider(
                    value: double.parse(snapshot
                            .data?.currentPosition.inMilliseconds
                            .toString() ??
                        "0"),
                    onChanged: (v) {
                      audioPlayer.seek(Duration(milliseconds: v.round()));
                    },
                    activeColor: AppTheme.textColor,
                    inactiveColor: Colors.black12,
                    max: double.parse(
                      snapshot.data?.duration.inMilliseconds.toString() ??
                          "0.0",
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  StreamBuilder(
                    stream: audioPlayer.currentPosition,
                    initialData: const Duration(),
                    builder: (BuildContext context,
                        AsyncSnapshot<Duration> snapshot) {
                      Duration duration = snapshot.data!;
                      return Text(
                        format(duration),
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textColor,
                        ),
                      );
                    },
                  ),
                  StreamBuilder<RealtimePlayingInfos>(
                    stream: audioPlayer.realtimePlayingInfos,
                    builder: (BuildContext context,
                        AsyncSnapshot<RealtimePlayingInfos> snapshot) {
                      if (snapshot.hasData) {
                        final info = snapshot.data!;
                        return Text(
                          "-${format(info.duration - info.currentPosition)}",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textColor,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
