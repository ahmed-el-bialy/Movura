import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/person_details/data/person_details_model.dart';
import '../../constants/api_constants.dart';
import '../../extensions/routing_extension.dart';
import '../../routing/arguments_models.dart';
import '../../routing/route_names.dart';
import '../../helpers/spacing.dart';
import '../../theming/app_colors.dart';
import '../../theming/text_styles.dart';

class PersonCreditsList extends StatelessWidget {
  const PersonCreditsList({super.key, this.movies, this.tvShows});

  final List<PersonCastMovie>? movies;
  final List<PersonCastTv>? tvShows;

  @override
  Widget build(BuildContext context) {
    final itemCount = movies?.length ?? tvShows?.length ?? 0;

    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final posterPath =
              movies?[index].posterPath ?? tvShows?[index].posterPath;
          final title = movies?[index].title ?? tvShows?[index].name;
          final mediaId = movies?[index].id ?? tvShows?[index].id;
          final mediaType = movies != null ? "movie" : "tv";

          return GestureDetector(
            onTap: () {
              context.pushNamed(
                RouteNames.detailsScreen,
                arguments: DetailsArgumentModel(
                  mediaType: mediaType,
                  mediaId: mediaId!,
                ),
              );
            },
            child: Container(
              width: 120.w,
              margin: EdgeInsets.only(right: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CachedNetworkImage(
                        imageUrl: "${ApiConstants.imageBaseUrl}$posterPath",
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            Container(color: AppColors.onyxBlack),
                      ),
                    ),
                  ),
                  verticalSpacing(8),
                  Text(
                    title ?? "Unknown",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font12MediumPlatinumGray,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
