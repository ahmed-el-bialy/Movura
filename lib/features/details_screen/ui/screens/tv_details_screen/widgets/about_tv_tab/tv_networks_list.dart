import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/company_card.dart';
import 'package:movura/features/details_screen/data/models/tv_models/about_tv_series_model.dart';


class NetworksList extends StatelessWidget {
  const NetworksList({super.key, required this.network});

  final List<TvNetworkModel> network;

  @override
  Widget build(BuildContext context) {
    if (network.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 210.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: network.length,
        itemBuilder: (context, index) {
          return CompanyCard(company: network[index]);
        },
      ),
    );
  }
}
