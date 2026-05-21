import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({super.key, required this.company});

  final CompanyModel company;

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
            company.logo != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 6.h,
                      horizontal: 4.w,
                    ),
                    child: CircleAvatar(
                      radius: 65.r,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              "${ApiConstants.imageBaseUrl}${company.logo!}",
                          fit: BoxFit.contain,
                          width: 130.w,
                          height: 130.w,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.person, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 6.h,
                      horizontal: 4.w,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://imgs.search.brave.com/EJMCxyVRjJtDJDePd6-7kPazT9g-Q5_Xx5cUcKwVmhY/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMjE1/NjQ1MDcwMy92ZWN0/b3IvNDA0LXBhZ2Ut/bm90LWZvdW5kLWlj/b24uanBnP3M9NjEy/eDYxMiZ3PTAmaz0y/MCZjPTlwRVFrbTRt/Y0x1Zmdzb1BhRkRp/cEsxNE1OSkV3aV9Q/QVZ1ZDBkaTV6aDg9",
                        fit: BoxFit.cover,
                        width: 130.w,
                        height: 130.w,
                        alignment: Alignment.topCenter,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.villa_sharp, color: Colors.white),
                      ),
                    ),
                  ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
              child: Text(
                company.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.font13NeonCyanBoldSora,
              ),
            ),

            verticalSpacing(8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                company.originCountry,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.font10IceBlueBoldMontserrat,
              ),
            ),
            verticalSpacing(5),
          ],
        ),
      ),
    );
  }
}
