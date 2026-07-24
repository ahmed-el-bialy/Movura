import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movura/features/details/ui/widgets/shared_widgets/back_button.dart';
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
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.controller.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: widget.controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.neonBlue,
        topActions: [
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              widget.controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        onReady: () {
          widget.controller.addListener(() {
            if (mounted) setState(() {});
          });
        },
        onEnded: (data) {
          context.pop();
        },
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: AppColors.trueBlack,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: CustomBackButton(
              onTap: () => context.pop(),
            ),
          ),
          body: Center(child: player),
        );
      },
    );
  }
}
