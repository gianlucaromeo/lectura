import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lectura/main/app.dart';
import 'package:lectura/main/app_env.dart';

void main() {
  group("App environments after startup", () {
    testWidgets("PRODUCTION Banner", (tester) async {
      EnvInfo.initialize(AppEnvironment.prod);
      await tester.pumpWidget(App());
      expect(
        find.byType(Banner),
        findsNothing,
        reason: 'Banner must be hidden in production',
      );
    });

    testWidgets("STAGING Banner", (tester) async {
      EnvInfo.initialize(AppEnvironment.staging);
      await tester.pumpWidget(App());
      expect(
        tester.widget(find.byType(Banner)),
        isA<Banner>().having(
          (b) => b.message,
          'staging banner',
          equals('staging'),
        ),
      );
    });

    testWidgets("DEV Banner", (tester) async {
      EnvInfo.initialize(AppEnvironment.dev);
      await tester.pumpWidget(App());
      expect(
        tester.widget(find.byType(Banner)),
        isA<Banner>().having(
          (b) => b.message,
          'dev banner',
          equals('dev'),
        ),
      );
    });
  });
}
