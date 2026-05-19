import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helper/spacing.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/details_screen/ui/widgets/action_buttons_part.dart';
import 'package:movura/features/details_screen/ui/widgets/first_lock_part.dart';
import 'package:movura/features/details_screen/ui/widgets/story_line.dart';

import '../../../core/helper/constants/strings.dart';
import '../../../core/helper/extension.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? path = ModalRoute.of(context)?.settings.arguments as String?;

    final String imageUrl = (path != null && path.isNotEmpty && path != "null")
        ? "https://image.tmdb.org/t/p/w500$path"
        : "https://imgs.search.brave.com/xZq9nb2uUi_S166e0LIEbWEbWXT354C_1_1ps_3HNEs/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly93d3cu/ZHZkc3JlbGVhc2Vk/YXRlcy5jb20vcG9z/dGVycy8zMDAvTC9M/ZWUtQ3Jvbmlucy1U/aGUtTXVtbXktMjAy/Ni5qcGc";

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.richEerieBlack,
      appBar: AppBar(
        automaticallyImplyActions: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          Strings.appName,
          style: Styles.font24NeonCyanSimiBoldManrope,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: AppColors.slateGray.withValues(alpha: .4),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                splashColor: AppColors.neonCyan.withValues(alpha: .4),
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Icon(Icons.favorite_border, color: AppColors.neonCyan),
                ),
              ),
            ),
          ),
        ],
        leading: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: AppColors.slateGray.withValues(alpha: .4),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            splashColor: AppColors.neonCyan.withValues(alpha: .4),
            onTap: () {
              context.pop();
            },
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: Icon(Icons.arrow_back, color: AppColors.neonCyan),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          FirstLockPart(imageUrl: imageUrl),

          ActionButtonsPart(),

          verticalSpacing(20),
          StoryLine(),
          verticalSpacing(10),

          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 12.w),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       ElevatedButton(
          //         onPressed: () {},
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: AppColors.onyxBlack,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(14),
          //           ),
          //         ),
          //         child: Padding(
          //           padding: EdgeInsets.symmetric(vertical: 8.h),
          //           child: Text("About", style: Styles.font13NeonCyanBoldSora),
          //         ),
          //       ),
          //       ElevatedButton(
          //         onPressed: () {},
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: AppColors.onyxBlack,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(14),
          //           ),
          //         ),
          //         child: Padding(
          //           padding: EdgeInsets.symmetric(vertical: 8.h),
          //           child: Text("Cast", style: Styles.font13NeonCyanBoldSora),
          //         ),
          //       ),
          //       ElevatedButton(
          //         onPressed: () {},
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: AppColors.onyxBlack,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(14),
          //           ),
          //         ),
          //         child: Padding(
          //           padding: EdgeInsets.symmetric(vertical: 8.h),
          //           child: Text(
          //             "Similar",
          //             style: Styles.font13NeonCyanBoldSora,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Divider(color: AppColors.onyxBlack,thickness: 2,),

          verticalSpacing(20),
        ],
      ),
    );
  }
}
