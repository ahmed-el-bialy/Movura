import 'package:material_ui/material_ui.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/routing/route_names.dart';

Future<void> playYoutubeVideo(
  BuildContext context,
    String videoKey,) async {
  try {
    if (!context.mounted) return;

    await context.pushNamed(RouteNames.videoPlayScreen, arguments: videoKey);
  } catch (e) {
    debugPrint('Error playing YouTube video: $e');
  }
}
