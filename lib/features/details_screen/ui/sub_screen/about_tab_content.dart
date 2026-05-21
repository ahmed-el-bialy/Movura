import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/styles.dart';
import 'package:movura/core/widgets/actor_card.dart';
import 'package:movura/core/widgets/section_title.dart';
import 'package:movura/features/details_screen/logic/about_section/about_section_cubit.dart';

import 'details_loading_skeleton.dart';

class AboutTabContent extends StatelessWidget {
  const AboutTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutSectionCubit, AboutSectionState>(
      builder: (context, state) {
        if (state is AboutSectionLoading) {
          return DetailsLoadingSkeleton();
        }
        else if (state is AboutSectionLoaded) {
          print(
            "عدد الممثلين القادمين من السيرفر: ${state.model.actors.movieActors
                .length}",
          );
          return Column(
            children: [
              SectionTitle(sectionName: "sectionName"),
              SizedBox(
                height: 220.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.model.actors.movieActors.length,
                  itemBuilder: (context, index) {
                    return ActorCard(
                      actor: state.model.actors.movieActors[index],);
                  },
                ),
              ),
            ],
          );
        }
        else if (state is AboutSectionFailed) {
          return Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(state.errorMessage, style: Styles.font11IGoldBold,),
          ),);
        }
        else {
          return Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "There was An Error", style: TextStyle(color: Colors.white),),
          ),);
        }
      },
    );
  }
}
