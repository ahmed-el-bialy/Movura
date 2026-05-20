import 'package:flutter/material.dart';
import 'package:movura/features/details_screen/data/models/main_details_model.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../details_screen/ui/widgets/action_buttons_part.dart';
import '../../../details_screen/ui/widgets/first_lock_part.dart';
import '../../../details_screen/ui/widgets/story_line.dart';

class SuccessBuildBody extends StatelessWidget {
  const SuccessBuildBody({super.key, required this.model});

  final MainDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        FirstLockPart(model: model),

        ActionButtonsPart(),

        verticalSpacing(20),
        StoryLine(model: model),
        verticalSpacing(10),

        Divider(color: AppColors.onyxBlack, thickness: 2),

        verticalSpacing(20),
      ],
    );
  }
}

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
