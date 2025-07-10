
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videos_trucker/core/constant/colors_class.dart';
import 'package:videos_trucker/routes.dart';
import 'package:videos_trucker/widgets/main_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        
        title: const Text('Home Page'),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
          child:MainCard(
            onTap: () {
              Get.toNamed(Routes.videosHome);
            },
            title: 'Videos',
            icon: Icons.video_library,
          )
          ),
          Expanded(
            child: MainCard(
              onTap: () {
                // Navigate to playlists or perform an action
              },
              title: 'Playlists',
              icon: Icons.playlist_play,
            ),
          ),
        ],
      ),
    );
  }
}