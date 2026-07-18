import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('fridgenius logo SVG asset renders', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SvgPicture.asset(
            'assets/fridgenius_icon.svg',
            width: 96,
            height: 96,
          ),
        ),
      ),
    );
    // Let flutter_svg load & parse the asset.
    await tester.pumpAndSettle();

    expect(find.byType(SvgPicture), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
