import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movura/core/widgets/loading/movura_loading_indicator.dart';

void main() {
  testWidgets('MovuraLoadingIndicator renders without overflow or error', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (_, child) => const MaterialApp(
          home: Scaffold(
            body: Center(
              child: MovuraLoadingIndicator(size: 100),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(MovuraLoadingIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 100));

    expect(
      find.descendant(
        of: find.byType(MovuraLoadingIndicator),
        matching: find.byType(CustomPaint),
      ),
      findsOneWidget,
    );
  });
}
