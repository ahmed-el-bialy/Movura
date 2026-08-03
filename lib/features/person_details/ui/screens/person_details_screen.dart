import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movura/core/constants/api_constants.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/app_error_widget.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';
import 'package:movura/core/widgets/layout/section_title.dart';
import 'package:movura/core/widgets/shared_details/person_credits_list.dart';
import '../../logic/person_details_cubit.dart';

class PersonDetailsScreen extends StatelessWidget {
  const PersonDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      body: BlocBuilder<PersonDetailsCubit, PersonDetailsState>(
        builder: (context, state) {
          if (state is PersonDetailsLoading) {
            return const Center(child: MovuraLoadingIndicator());
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
                            imageUrl:
                                "${ApiConstants.imageBaseUrl}${person.profilePath}",
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                Container(color: AppColors.onyxBlack),
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
                          style: TextStyles.font24SemiBoldNeonBlueManrope
                              .copyWith(
                                fontSize: 28.sp,
                                color: AppColors.iceBlue,
                              ),
                        ),
                        AppSpacing.verticalSpacing(AppSpacing.s),
                        if (person.knownFor != null)
                          Text(
                            person.knownFor!,
                            style: TextStyles.font14RegularDarkNeonBlueManrope,
                          ),
                        AppSpacing.verticalSpacing(20),
                        if (person.biography != null &&
                            person.biography!.isNotEmpty) ...[
                          const SectionTitle(sectionName: "BIOGRAPHY"),
                          AppSpacing.verticalSpacing(AppSpacing.s + 2),
                          Text(
                            person.biography!,
                            style: TextStyles.font12RegularCoolGrayManrope.copyWith(
                              height: 1.6,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                        AppSpacing.verticalSpacing(AppSpacing.xl),
                        const SectionTitle(sectionName: "PERSONAL INFO"),
                        AppSpacing.verticalSpacing(AppSpacing.l),
                        _PersonalInfoGrid(person: person),
                        AppSpacing.verticalSpacing(30),
                        if (person.movieCredits?.cast != null &&
                            person.movieCredits!.cast!.isNotEmpty) ...[
                          const SectionTitle(sectionName: "KNOWN FOR (MOVIES)"),
                          AppSpacing.verticalSpacing(AppSpacing.m),
                          PersonCreditsList(movies: person.movieCredits!.cast!),
                        ],
                        AppSpacing.verticalSpacing(30),
                        if (person.tvCredits?.cast != null &&
                            person.tvCredits!.cast!.isNotEmpty) ...[
                          const SectionTitle(
                            sectionName: "KNOWN FOR (TV SHOWS)",
                          ),
                          AppSpacing.verticalSpacing(AppSpacing.m),
                          PersonCreditsList(tvShows: person.tvCredits!.cast!),
                        ],
                        AppSpacing.verticalSpacing(100),
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

class _PersonalInfoGrid extends StatelessWidget {
  const _PersonalInfoGrid({required this.person});

  final dynamic person;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.onyxBlack.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.pureWhite.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          _InfoItem(
            icon: Icons.cake_rounded,
            label: "Birthday",
            value: person.birthday ?? "N/A",
          ),
          Divider(
            height: 24.h,
            color: AppColors.pureWhite.withValues(alpha: 0.05),
          ),
          _InfoItem(
            icon: Icons.location_on_rounded,
            label: "Place of Birth",
            value: person.placeOfBirth ?? "N/A",
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: AppSpacing.all(AppSpacing.s),
          decoration: BoxDecoration(
            color: AppColors.neonBlue.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: AppColors.neonBlue, size: 18.sp),
        ),
        AppSpacing.horizontalSpacing(AppSpacing.l),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyles.font10BoldCoolGray.copyWith(
                  color: AppColors.coolGray.withValues(alpha: 0.6),
                  letterSpacing: 1.1,
                ),
              ),
              AppSpacing.verticalSpacing(2),
              Text(
                value,
                style: TextStyles.font14RegularPureWhiteManrope.copyWith(
                  fontWeight: Weights.semiBold,
                  fontSize: 13.sp,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
