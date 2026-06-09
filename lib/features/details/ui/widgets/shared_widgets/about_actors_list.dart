import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/actor_card.dart';

import '../../../../../core/models/actor_model.dart';

class AboutActorsList extends StatelessWidget {
  const AboutActorsList({super.key, required this.actors});

  final List<ActorModel> actors;

  @override
  Widget build(BuildContext context) {
    if (actors.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 245.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ActorCard(actor: actors[index]),
          );
        },
      ),
    );
  }
}
