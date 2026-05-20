import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/helper/spacing.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/styles.dart';

class ActorCard extends StatelessWidget {
  const ActorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        elevation: 10,
        color: AppColors.onyxBlack,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: AppColors.platinumGray,
                radius: 60,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://imgs.search.brave.com/YYT78Q7ftK1i5nymCo942ryHb4Q38Mo-ibnwjH7dt3Q/rs:fit:0:180:1:0/g:ce/aHR0cHM6Ly9zdGF0/aWMud2lraWEubm9j/b29raWUubmV0L21h/cnZlbGNpbmVtYXRp/Y3VuaXZlcnNlL2lt/YWdlcy9iL2I5L1Rv/bnlfU3RhcmtfKDIw/MDgpLmpwZy9yZXZp/c2lvbi9sYXRlc3Qv/c2NhbGUtdG8td2lk/dGgtZG93bi8yNTA_/Y2I9MjAyNTA5MTQx/NDM0NDY",
                    fit: BoxFit.cover,
                    width: 112,
                    height: 112,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 15.w),
              child: Text(
                "Robert Downey Jr",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.font13NeonCyanBoldSora,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                "Tony Stark",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.font10IceBlueBoldMontserrat,
              ),
            ),
            verticalSpacing(6),
          ],
        ),
      ),
    );
  }
}
