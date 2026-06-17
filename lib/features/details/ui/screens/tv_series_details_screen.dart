import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/features/details/logic/tv_series_cubit/about_tv/about_tv_cubit.dart';
import 'package:movura/features/details/ui/widgets/tv_widgets/screen_body.dart';

import '../../../../core/theming/colors.dart';
import '../details_loading_skeleton.dart';

class TvSeriesDetailsScreen extends StatelessWidget {
  const TvSeriesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.richEerieBlack,
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
