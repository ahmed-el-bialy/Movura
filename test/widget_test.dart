import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movura/core/widgets/buttons/app_text_button.dart';

void main() {
  testWidgets('AppTextButton renders and triggers onPressed', (WidgetTester tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (_, child) => MaterialApp(
          home: Scaffold(
            body: Center(
              child: AppTextButton(
                buttonText: 'TEST BUTTON',
                onPressed: () {
                  pressed = true;
                },
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('TEST BUTTON'), findsOneWidget);

    await tester.tap(find.text('TEST BUTTON'));
    await tester.pump();

    expect(pressed, true);
  });
}
