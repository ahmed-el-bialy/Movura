import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/helpers/spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/section_title.dart';
import 'package:movura/core/widgets/shared_details/person_credits_list.dart';
import 'package:movura/features/person_details/logic/person_details_cubit.dart';

class PersonDetailsScreen extends StatelessWidget {
  const PersonDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: BlocBuilder<PersonDetailsCubit, PersonDetailsState>(
        builder: (context, state) {
          if (state is PersonDetailsLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.neonBlue));
          } else if (state is PersonDetailsLoaded) {
            final person = state.personDetails;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 400.h,
                  pinned: true,
                  backgroundColor: AppColors.richEerieBlack,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (person.profilePath != null)
                          CachedNetworkImage(
                            imageUrl: "${ApiConstants.imageBaseUrl}${person.profilePath}",
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Container(color: AppColors.onyxBlack),
                          )
                        else
                          Container(color: AppColors.onyxBlack),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.transparent,
                                AppColors.richEerieBlack.withValues(alpha: 0.8),
                                AppColors.richEerieBlack,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          person.name ?? "Unknown",
                          style: TextStyles.font24SimiBoldNeonBlueManrope.copyWith(
                            fontSize: 28.sp,
                            color: AppColors.iceBlue,
                          ),
                        ),
                        verticalSpacing(8),
                        if (person.knownFor != null)
                          Text(
                            person.knownFor!,
                            style: TextStyles.font14DarkNeonBlueManrope,
                          ),
                        verticalSpacing(20),
                        if (person.biography != null && person.biography!.isNotEmpty) ...[
                          const SectionTitle(sectionName: "BIOGRAPHY"),
                          verticalSpacing(10),
                          Text(
                            person.biography!,
                            style: TextStyles.font12CoolGrayManrope.copyWith(height: 1.6, fontSize: 13.sp),
                          ),
                        ],
                        verticalSpacing(24),
                        const SectionTitle(sectionName: "PERSONAL INFO"),
                        verticalSpacing(12),
                        _InfoRow(label: "Birthday", value: person.birthday ?? "N/A"),
                        _InfoRow(label: "Place of Birth", value: person.placeOfBirth ?? "N/A"),
                        verticalSpacing(30),
                        if (person.movieCredits?.cast != null && person.movieCredits!.cast!.isNotEmpty) ...[
                          const SectionTitle(sectionName: "KNOWN FOR (MOVIES)"),
                          verticalSpacing(12),
                          PersonCreditsList(movies: person.movieCredits!.cast!),
                        ],
                        verticalSpacing(30),
                        if (person.tvCredits?.cast != null && person.tvCredits!.cast!.isNotEmpty) ...[
                          const SectionTitle(sectionName: "KNOWN FOR (TV SHOWS)"),
                          verticalSpacing(12),
                          PersonCreditsList(tvShows: person.tvCredits!.cast!),
                        ],
                        verticalSpacing(100),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is PersonDetailsError) {
            return AppErrorWidget(errorMessage: state.errorMessage);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Text("$label: ", style: TextStyles.font12BoldCoolGray),
          Expanded(
            child: Text(
              value,
              style: TextStyles.font12MediumPlatinumGray,
            ),
          ),
        ],
      ),
    );
  }
}
