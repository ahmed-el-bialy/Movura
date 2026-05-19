import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class StoryLine extends StatelessWidget {
  const StoryLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0.r),
      child: SizedBox(
        height: 210.h,
        width: 3000.w,
        child: Card(
          elevation: 5,
          color: AppColors.onyxBlack.withValues(alpha: .8),
          child: Column(
            children: [
              verticalSpacing(12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text("STORYLINE", style: Styles.font13NeonCyanBoldSora),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                child: Text(
                  "Deep beneath the shifting sands of Egypt ,an ancient entity awakens from a millennia-long slumber. A team of explorers must race against time to stop the return of a cursed pharaoh whose wrath threatens to plunge the modern world into eternal darkness.",
                  style: Styles.font14IceBlueBoldMontserrat,
                ),
              ),

              SizedBox(
                height: 45.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        color: AppColors.onyxBlack,
                        child: InkWell(
                          onTap: () {},
                          splashColor: AppColors.iceBlue.withValues(alpha: .5),
                          borderRadius: BorderRadius.circular(20),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 6.h,
                                horizontal: 10.w,
                              ),
                              child: Text(
                                "Action",
                                style: Styles.font12platinumGrayMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
