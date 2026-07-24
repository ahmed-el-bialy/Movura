import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movura/core/widgets/app_icon_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/extensions/routing_extension.dart';

class VideoScreen extends StatefulWidget {
  final YoutubePlayerController controller;

  const VideoScreen({super.key, required this.controller});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Note: controller is disposed by the caller or by the player widget usually,
    // but here it's passed as an argument.
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.controller.pauseVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trueBlack,
      body: Stack(
        children: [
          Center(
            child: YoutubePlayer(
              controller: widget.controller,
              aspectRatio: 16 / 9,
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: AppIconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onPressed: () => context.pop(),
              backgroundColor: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
