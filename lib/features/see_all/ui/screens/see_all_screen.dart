import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/models/poster_model.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/core/theming/weights.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';
import 'package:movura/core/widgets/poster_card/poster_card.dart';

import '../../data/models/see_all_arguments.dart';

// Each TMDB page returns up to 20 items, so we use this to detect the last page.
const _pageSize = 20;

class SeeAllScreen extends StatefulWidget {
  final SeeAllArguments arguments;

  const SeeAllScreen({super.key, required this.arguments});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  // v5 API: we provide the fetch logic and next-key logic in the constructor.
  late final PagingController<int, PosterModel> _pagingController;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController<int, PosterModel>(
      getNextPageKey: (state) {
        final lastPage = state.pages?.last;
        final isLastPage = (lastPage?.length ?? 0) < _pageSize;
        return isLastPage ? null : state.nextIntPageKey;
      },
      fetchPage: (pageKey) => widget.arguments.fetchData(pageKey),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richEerieBlack,
      appBar: AppBar(
        backgroundColor: AppColors.richEerieBlack,
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColors.pureWhite),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.arguments.title,
          style: TextStyles.font20SemiBoldPlatinumGray,
        ),
      ),
      // PagingListener bridges the controller to the paged widget.
      body: PagingListener(
        controller: _pagingController,
        builder: (context, state, fetchNextPage) => CustomScrollView(
          slivers: [
            SliverPadding(
              padding: AppSpacing.symmetric(
                horizontal: AppSpacing.xs,
                vertical: AppSpacing.s,
              ),
              sliver: PagedSliverGrid<int, PosterModel>(
                state: state,
                fetchNextPage: fetchNextPage,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.55,
                  crossAxisSpacing: 8.w,
                  mainAxisSpacing: 12.h,
                ),
                builderDelegate: PagedChildBuilderDelegate<PosterModel>(
                  itemBuilder: (context, item, index) => PosterCard(
                    mediaModel: item,
                    mediaType: item.mediaType,
                    elevation: 6,
                    width: double.infinity,
                    height: double.infinity,
                    border: 12,
                    titleStyle: TextStyles.font14BoldIceBlueMontserrat.copyWith(
                      fontSize: 11.sp,
                      fontWeight: Weights.extraBold,
                    ),
                    subTextStyle: TextStyles.font16SemiBoldPlatinumGray.copyWith(
                      fontSize: 10.sp,
                      letterSpacing: 0.5,
                    ),
                    showMediaType: true,
                    maxLines: 2,
                  ),
                  firstPageProgressIndicatorBuilder: (_) => const Center(
                    child: MovuraLoadingIndicator(),
                  ),
                  newPageProgressIndicatorBuilder: (_) => Padding(
                    padding: AppSpacing.vertical(AppSpacing.xl),
                    child: const Center(
                      child: MovuraLoadingIndicator(size: 60),
                    ),
                  ),
                  noItemsFoundIndicatorBuilder: (_) => Center(
                    child: Text(
                      "No items found.",
                      style: TextStyle(
                        color: AppColors.platinumGray,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  firstPageErrorIndicatorBuilder: (_) => Center(
                    child: Text(
                      "An error occurred. Please try again.",
                      style: TextStyle(color: AppColors.softRed, fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            AppSpacing.sliverVerticalSpacing(40),
          ],
        ),
      ),
    );
  }
}
