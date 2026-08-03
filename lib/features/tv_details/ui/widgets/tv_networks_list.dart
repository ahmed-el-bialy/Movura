import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/tv_details/ui/widgets/tv_network_card.dart';

import '../../data/about_tv_series_model.dart';

class TvNetworksList extends StatelessWidget {
  const TvNetworksList({super.key, required this.network});

  final List<TvNetworkModel> network;

  @override
  Widget build(BuildContext context) {
    if (network.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        itemExtent: 150.w,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: network.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: TvNetworkCard(network: network[index]),
          );
        },
      ),
    );
  }
}
