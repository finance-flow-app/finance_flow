import 'package:collection/collection.dart';
import 'package:finance_flow/core/router/page_transitions.dart';
import 'package:finance_flow/src/features/expense_add/presentation/pages/expense_add.dart';
import 'package:finance_flow/src/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter();

  static final GoRouter _router = GoRouter(
    initialLocation: MobilePages.homePage.path,
    routes: [
      GoRoute(
        path: MobilePages.homePage.path,
        name: MobilePages.homePage.name,
        pageBuilder: (context, state) =>
            bottomUpPage(key: state.pageKey, child: const HomePage()),
      ),
      GoRoute(
        path: MobilePages.expenseAddPage.path,
        name: MobilePages.expenseAddPage.name,
        pageBuilder: (context, state) =>
            bottomUpPage(key: state.pageKey, child: const ExpenseAddScreen()),
      ),
    ],
  );
  GoRouter get router => _router;
}

enum MobilePages {
  homePage,
  expenseAddPage;

  static MobilePages? fromName(String? name) {
    return MobilePages.values.firstWhereOrNull(
      (MobilePages element) => element.name == name,
    );
  }
}

extension MobilePagesExt on MobilePages {
  String get path => '/$name';
}
