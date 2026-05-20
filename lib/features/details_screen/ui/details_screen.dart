import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/colors.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/features/details_screen/ui/sub_screen/details_loading_skeleton.dart';
import 'package:movura/features/details_screen/ui/sub_screen/success_build_body.dart';

import '../../../core/helper/extension.dart';
import '../../../core/helper/strings.dart';
import '../logic/main_details/main_details_cubit.dart';

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
        title: Text(
          Strings.appName,
          style: Styles.font24NeonCyanSimiBoldManrope,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: AppColors.slateGray.withValues(alpha: .4),
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
          color: AppColors.slateGray.withValues(alpha: .4),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            splashColor: AppColors.neonCyan.withValues(alpha: .4),
            onTap: () {
              context.pop();
            },
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: Icon(Icons.arrow_back, color: AppColors.neonCyan),
            ),
          ),
        ),
      ),
      body: BlocBuilder<MainDetailsCubit, MainDetailsState>(
        builder: (context, state) {
          if (state is MainDetailsLoading) {
            return DetailsLoadingSkeleton();
          }
          else if (state is MainDetailsSuccess) {
            return SuccessBuildBody(model: state.model,);
          }
          else if (state is MainDetailsFailed) {
            return Center(child: Text(state.errorMessage),);
          }
          else{
            return Center(child: Text("There was An Error"),);
          }
        },
      ),
    );
  }
}
