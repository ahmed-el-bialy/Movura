import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/colors.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.charcoalBlack,
      ),

      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: AppColors.coolGray,fontSize: 16.sp),
        border: InputBorder.none,

        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: AppColors.slateGray,fontSize: 16.sp),
      ),
    );
  }
  @override
  List<Widget>? buildActions(context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear, color: AppColors.neonCyan),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.filter_alt, color: AppColors.neonCyan),
      ),
    ];
  }

  @override
  Widget? buildLeading(context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back, color: AppColors.neonCyan),
    );
  }

  @override
  Widget buildResults(context) {
    return Container(color: AppColors.richEerieBlack);
  }

  @override
  Widget buildSuggestions(context) {
    return Container(color: AppColors.richEerieBlack);
  }
}
