import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/actor_card.dart';
import 'package:movura/core/widgets/section_title.dart';

class AboutTabContent extends StatelessWidget {
  const AboutTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(sectionName: "sectionName"),
        SizedBox(
          height: 210.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              return ActorCard();
            },
          ),
        ),
      ],
    );
  }
}
