import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/widgets/company_card.dart';

import '../../../../../core/models/company_model.dart';

class CompaniesList extends StatelessWidget {
  const CompaniesList({super.key, required this.company});

  final List<CompanyModel> company;

  @override
  Widget build(BuildContext context) {
    if (company.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 210.h,
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
