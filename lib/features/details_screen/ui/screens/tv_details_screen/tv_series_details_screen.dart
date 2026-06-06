import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/details_screen/logic/tv_series_cubit/about_tv/about_tv_cubit.dart';
import 'package:movura/features/details_screen/ui/screens/tv_details_screen/widgets/main_screen/screen_body.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/utils/extensions/routing_extension.dart';
import '../../widgets/details_loading_skeleton.dart';

class TvSeriesDetailsScreen extends StatelessWidget {
  const TvSeriesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.richEerieBlack,
      appBar: AppBar(
        automaticallyImplyActions: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: AppColors.onyxBlack.withValues(alpha: .9),
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
          color: AppColors.onyxBlack.withValues(alpha: .9),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              splashColor: AppColors.neonCyan.withValues(alpha: .4),
              onTap: () {
                context.pop();
              },
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Icon(Icons.arrow_back_ios, color: AppColors.neonCyan),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<AboutTvCubit, AboutTvState>(
        builder: (context, state) {
          if (state is AboutTvLoading) {
            return DetailsLoadingSkeleton();
          } else if (state is AboutTvLoaded) {
            return TvScreenBody(model: state.model);
          } else if (state is AboutTvFailed) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Center(child: Text("There was An Error"));
          }
        },
      ),
    );
  }
}
