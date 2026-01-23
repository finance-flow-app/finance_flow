import 'package:collection/collection.dart';
import 'package:finance_flow/src/features/home/presentation/pages/home_page.dart';
import 'package:finance_flow/src/features/test_sreen/presentation/pages/test_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter router() {
    return GoRouter(
      initialLocation: MobilePages.homePage.path,
      routes: [
        GoRoute(
          path: MobilePages.homePage.path,
          name: MobilePages.homePage.name,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: MobilePages.testScreenPage.path,
          name: MobilePages.testScreenPage.name,
          builder: (context, state) => const TestScreen(),
        ),
      ],
    );
  }
}

enum MobilePages {
  homePage,
  testScreenPage;

  static MobilePages? fromName(String? name) {
    return MobilePages.values.firstWhereOrNull(
      (MobilePages element) => element.name == name,
    );
  }
}

extension MobilePagesExt on MobilePages {
  String get path => '/$name';
}
