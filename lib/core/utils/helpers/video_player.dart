import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movura/core/utils/constants/strings.dart';
import 'package:movura/core/utils/extensions/routing_extension.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Future<void> playYoutubeVideo(
  BuildContext context,

  String videoKey, {

  bool autoPlay = true,

  bool mute = false,

  bool enableCaption = true,

  String? captionLanguage = 'en',

  bool forceHD = true,

  bool loop = false,
}) async {
  try {
    await _prepareVideoMode();

    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoKey,

      flags: YoutubePlayerFlags(
        autoPlay: autoPlay,

        mute: mute,

        disableDragSeek: false,

        loop: loop,

        isLive: false,

        forceHD: forceHD,

        enableCaption: enableCaption,

        captionLanguage: captionLanguage!,

        hideControls: false,

        hideThumbnail: false,

        showLiveFullscreenButton: true,
      ),
    );

    if (!context.mounted) return;

    await context.pushNamed(Strings.videoPlayScreen, controller);
  } catch (e) {
    debugPrint('Error playing YouTube video: $e');

    _restoreSystemDefaults();
  }
}

Future<void> _prepareVideoMode() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,

    DeviceOrientation.landscapeLeft,

    DeviceOrientation.landscapeRight,
  ]);

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,

    overlays: [],
  );
}

void _restoreSystemDefaults() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,

    overlays: SystemUiOverlay.values,
  );
}
