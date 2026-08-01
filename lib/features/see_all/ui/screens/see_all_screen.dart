import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movura/core/extensions/routing_extension.dart';
import 'package:movura/core/theming/app_colors.dart';
import 'package:movura/core/theming/text_styles.dart';
import 'package:movura/features/see_all/data/models/see_all_arguments.dart';
import 'package:movura/features/see_all/data/repo/see_all_repo.dart';
import 'package:movura/features/see_all/logic/see_all_cubit.dart';
import 'package:movura/features/see_all/ui/widgets/see_all_grid.dart';
import 'package:movura/core/networking/di.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({Key? key, required this.arguments}) : super(key: key);

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
      body: BlocProvider.value(
        value: _cubit,
        child: const SeeAllGrid(),
      ),
    );
  }
}
