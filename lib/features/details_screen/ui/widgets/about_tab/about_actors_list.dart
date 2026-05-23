import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/actor_card.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';

class AboutActorsList extends StatelessWidget {
  const AboutActorsList({super.key, required this.actors});

  final List<ActorModel> actors;

  @override
  Widget build(BuildContext context) {
    if (actors.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 240.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          return ActorCard(actor: actors[index]);
        },
      ),
    );
  }
}
