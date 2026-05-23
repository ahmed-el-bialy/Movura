import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/features/details_screen/data/models/about_model.dart';
import 'package:movura/core/widgets/company_card.dart';

class AboutCompaniesList extends StatelessWidget {
  const AboutCompaniesList({super.key, required this.company});

  final List<CompanyModel> company;

  @override
  Widget build(BuildContext context) {
    if (company.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: company.length,
        itemBuilder: (context, index) {
          return CompanyCard(company: company[index]);
        },
      ),
    );
  }
}
