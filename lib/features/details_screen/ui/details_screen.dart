import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/features/details_screen/ui/widgets/details_body/screen_body.dart';
import 'package:movura/features/details_screen/ui/widgets/details_loading_skeleton.dart';

import '../../../core/utils/helpers/routing_extension.dart';
import '../logic/main_details/about_cubit.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

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
      body: BlocBuilder<AboutCubit, AboutState>(
        builder: (context, state) {
          if (state is AboutLoading) {
            return DetailsLoadingSkeleton();
          } else if (state is AboutSuccess) {
            return MoreDetailsPart(model: state.model);
          } else if (state is AboutFailed) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Center(child: Text("There was An Error"));
          }
        },
      ),
    );
  }
}
