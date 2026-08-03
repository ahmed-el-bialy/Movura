import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_spacing.dart';
import 'package:movura/core/widgets/cards/actor_card.dart';

import '../../models/actor_model.dart';

class ActorsList extends StatelessWidget {
  const ActorsList({super.key, required this.actors});

  final List<ActorModel> actors;

  @override
  Widget build(BuildContext context) {
    if (actors.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 250.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: actors.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: AppSpacing.horizontal(AppSpacing.xs),
            child: ActorCard(actor: actors[index]),
          );
        },
      ),
    );
  }
}
