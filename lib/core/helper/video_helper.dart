import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movura/core/helper/routing_extension.dart';
import 'package:movura/core/constants/strings.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Future<void> playVideo(
  BuildContext context,
  String videoKey, {
  String? trailerTitle,
}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(
      child: CircularProgressIndicator(color: Color(0xFF00F2FF)),
    ),
  );

  try {
    await _prepareForVideo();

    final controller = YoutubePlayerController(
      initialVideoId: videoKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true,
        enableCaption: true,
        captionLanguage: 'ar',
        hideControls: false,
      ),
    );

    if (context.mounted) Navigator.pop(context);

    if (context.mounted) {
      await context.pushNamed(Strings.videoPlayScreen, controller);
    }
  } catch (e) {
    if (context.mounted) Navigator.pop(context);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while playing the trailer.'),
        ),
      );
    }
  }

  _restoreSystemDefaults();
}

Future<void> _prepareForVideo() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

void _restoreSystemDefaults() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: SystemUiOverlay.values,
  );
}
