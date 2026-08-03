import 'package:flutter/material.dart';
import '../app_error_widget.dart';
import '../empty_section_message.dart';
import 'details_tab_loading.dart';

class DetailsTabStateWrapper extends StatelessWidget {
  const DetailsTabStateWrapper({
    super.key,
    required this.isLoading,
    this.errorMessage,
    this.onRetry,
    this.isEmpty = false,
    this.emptyIcon = Icons.info_outline,
    this.emptyTitle = "No data found",
    this.emptySubTitle = "",
    required this.child,
  });

  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final bool isEmpty;
  final IconData emptyIcon;
  final String emptyTitle;
  final String emptySubTitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const DetailsTabLoading();
    }

    if (errorMessage != null) {
      return AppErrorWidget(
        errorMessage: errorMessage!,
        onRetry: onRetry,
      );
    }

    if (isEmpty) {
      return EmptySectionMessage(
        icon: emptyIcon,
        title: emptyTitle,
        subTitle: emptySubTitle,
      );
    }

    return child;
  }
}
