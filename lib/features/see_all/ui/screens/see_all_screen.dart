import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/routing_extension.dart';
import '../../../../core/networking/di.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../data/models/see_all_arguments.dart';
import '../../data/repo/see_all_repo.dart';
import '../../logic/see_all_cubit.dart';
import '../widgets/see_all_grid.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key, required this.arguments});

  final SeeAllArguments arguments;

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  late final SeeAllCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = SeeAllCubit(sl<SeeAllRepo>());
    _cubit.init(widget.arguments);
  }

  @override
  void dispose() {
    _cubit.close();
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
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.arguments.title,
          style: TextStyles.font20SimiBoldPlatinumGray,
        ),
      ),
      body: BlocProvider.value(value: _cubit, child: const SeeAllGrid()),
    );
  }
}
