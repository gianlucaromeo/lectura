import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lectura/app.dart';
import 'package:lectura/core/app_env.dart';
import 'package:lectura/providers/environment_provider.dart';

void main() {
  group("App environments after startup", () {
    testWidgets("PRODUCTION Banner", (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            environmentInfoProvider.overrideWith(
              (ref) => EnvironmentInfo(AppEnvironment.prod),
            ),
          ],
          child: App(),
        ),
      );
      expect(
        find.byType(Banner),
        findsNothing,
        reason: 'Banner must be hidden in production',
      );
    });

    testWidgets("STAGING Banner", (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            environmentInfoProvider.overrideWith(
              (ref) => EnvironmentInfo(AppEnvironment.staging),
            ),
          ],
          child: App(),
        ),
      );
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
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            environmentInfoProvider.overrideWith(
              (ref) => EnvironmentInfo(AppEnvironment.dev),
            ),
          ],
          child: App(),
        ),
      );
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
