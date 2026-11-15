import 'package:material_ui/material_ui.dart';

class CategoryCardModel {
  final Color color;
  final String title;
  final String? hint;
  final IconData? icon;
  final VoidCallback onTap;

  CategoryCardModel({
    required this.color,
    required this.title,
    this.hint,
    this.icon,
    required this.onTap,
  });
}
