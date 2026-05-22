import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/helper/routing_extension.dart';
import '../../core/theming/colors.dart';

class VideoScreen extends StatefulWidget {
  final YoutubePlayerController controller;

  const VideoScreen({super.key, required this.controller});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> with WidgetsBindingObserver {
  bool _isLandscape = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _enterVideoMode();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _exitVideoMode();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.controller.pause();
    }
  }

  void _enterVideoMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _exitVideoMode() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: SystemUiOverlay.values,
    );
  }

  void _handleBack() {
    widget.controller.pause();
    _exitVideoMode();
    context.pop();
  }

  void _toggleControls() {
    if (!_isLandscape) return;
    setState(() => _showControls = !_showControls);

    if (_showControls) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted && _isLandscape) {
          setState(() => _showControls = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        _isLandscape = orientation == Orientation.landscape;

        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) _exitVideoMode();
          },
          child: Scaffold(
            backgroundColor: AppColors.trueBlack,
            body: GestureDetector(
              onTap: _isLandscape ? _toggleControls : null,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: YoutubePlayer(
                      controller: widget.controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: AppColors.neonCyan,
                      progressColors: ProgressBarColors(
                        playedColor: AppColors.neonCyan,
                        handleColor: AppColors.neonCyan,
                        bufferedColor: AppColors.darkNeonCyan.withValues(
                          alpha: 0.7,
                        ),
                        backgroundColor: Colors.white24,
                      ),
                      onEnded: (_) => _handleBack(),
                    ),
                  ),

                  if (!_isLandscape || _showControls)
                    Positioned(
                      top: _isLandscape ? 28 : 15,
                      left: _isLandscape ? 20 : 16,
                      child: _BackButton(onTap: _handleBack),
                    ),

                  if (_isLandscape && !_showControls)
                    Positioned(
                      top: 28,
                      left: 20,
                      child: GestureDetector(
                        onTap: _toggleControls,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.jetBlack.withValues(alpha: 0.85),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.neonCyan.withValues(alpha: 0.7),
                              width: 1.6,
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.neonCyan,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.jetBlack.withValues(alpha: 0.82),
          border: Border.all(
            color: AppColors.neonCyan.withValues(alpha: 0.9),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonCyan..withValues(alpha: 0.35),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.neonCyan,
          size: 22,
        ),
      ),
    );
  }
}
