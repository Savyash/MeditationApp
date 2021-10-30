import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/models/see_all_model.dart';
import 'package:meditation_app/repository/repository.dart';
import 'package:meditation_app/screens/mental_training_screen.dart';
import 'package:meditation_app/utils/app_theme.dart';
import 'package:meditation_app/utils/asset_utils.dart';
import 'package:meditation_app/utils/string_utils.dart';
import 'package:meditation_app/widgets/bottom_bar_widget.dart';

class SeeAllScreen extends StatelessWidget {
  final Repository repository = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          StringUtils.popularAppbarTitle,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        backgroundColor: AppTheme.bgColor,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: snapshot.data!.docs.map(
                (item) {
                  final model =
                      SeeAllModel.fromJson(item.data() as Map<String, dynamic>);
                  return Item(model: model);
                },
              ).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppTheme.primaryColor),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    Key? key,
    required this.model,
  }) : super(key: key);

  final SeeAllModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MentalTrainingScreen()));

            // await showModalBottomSheet(
            //   context: context,
            //   enableDrag: false,
            //   isDismissible: false,
            //   isScrollControlled: true,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(16),
            //       topRight: Radius.circular(16),
            //     ),
            //   ),
            //   builder: (context) => MentalTrainingScreen(),
            // );
          },
          leading: Image.network(
            model.image ?? "",
            width: MediaQuery.of(context).size.width * .20,
            errorBuilder: (_, obj, stack) {
              return Icon(Icons.error_outline);
            },
            loadingBuilder: (_, child, imageChunck) {
              if (imageChunck == null) {
                return child;
              }
              return Text("Loading..");
            },
          ),
          title: Text(
            model.title ?? "",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          subtitle: Text(
            model.duration ?? "",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 15,
            ),
          ),
          trailing: InkWell(
            onTap: () {
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tapped")));
            },
            child: SvgPicture.asset(AssetUtils.seeAllUnlike),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Divider(
            color: AppTheme.unFavColor,
          ),
        ),
      ],
    );
  }
}
