import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';

import '../../../../../../core/helper/spacing.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/styles.dart';
import '../about_tab/about_tab_body.dart';
import 'additional_data.dart';
import 'buttons_part.dart';
import 'movie_main_details.dart';
import 'story_line_and_genres.dart';

class MoreDetailsPart extends StatelessWidget {
  const MoreDetailsPart({super.key, required this.model});

  final AboutModel model;

  @override
  Widget build(BuildContext context) {
    String? trailerKey;
    final videos = model.movieVideos?.videoList;

    if (videos != null && videos.isNotEmpty) {
      final trailer = videos.firstWhere(
        (v) => v.type.toLowerCase() == 'trailer',
        orElse: () => videos.first,
      );
      trailerKey = trailer.key;
      if (kDebugMode) {
        print("this is the trailer kay: $trailerKey");
      }
    } else {
      if (kDebugMode) {
        print("trailer not exist");
      }
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        MovieMainDetails(model: model),

        ButtonsPart(videoKey: trailerKey),

        verticalSpacing(20),
        AdditionalData(model: model),
        StoryLineAndGenres(model: model),
        verticalSpacing(10),

        DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                unselectedLabelStyle: Styles.font10MediumCoolGraySora.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
                labelStyle: Styles.font13BoldNeonCyanSora,
                indicatorColor: AppColors.neonCyan,
                indicatorWeight: 3.0,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppColors.neonCyan,
                unselectedLabelColor: AppColors.slateGray,
                tabs: const [
                  Tab(text: "ABOUT"),
                  Tab(text: "REVIEWS"),
                  Tab(text: "SIMILAR"),
                ],
              ),

              SizedBox(height: 10.h),

              SizedBox(
                height: 1700.h,
                child: TabBarView(
                  children: [
                    AboutTabBody(),

                    const Center(
                      child: Text(
                        "Cast Content",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    const Center(
                      child: Text(
                        "Similar Content",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
