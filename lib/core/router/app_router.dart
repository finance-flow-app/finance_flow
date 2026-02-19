import 'package:collection/collection.dart';
import 'package:finance_flow/core/router/branch_transition_container.dart';
import 'package:finance_flow/core/router/page_transitions.dart';
import 'package:finance_flow/core/shared/app_navigation_widget.dart';
import 'package:finance_flow/src/features/analytics/presentation/pages/analytics_page.dart';
import 'package:finance_flow/src/features/analytics/presentation/pages/mock_page.dart';
import 'package:finance_flow/src/features/expense_add/presentation/pages/expense_add.dart';
import 'package:finance_flow/src/features/home/presentation/pages/home_page.dart';
import 'package:finance_flow/src/features/search/presentation/pages/search_page.dart';
import 'package:finance_flow/src/features/settings/presentation/pages/settings_page.dart';
import 'package:finance_flow/src/features/theme/presentation/pages/theme_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter();

  static final GlobalKey<NavigatorState> homeBranchKey = GlobalKey();
  static final GlobalKey<NavigatorState> analyticsBranchKey = GlobalKey();
  static final GlobalKey<NavigatorState> searchBranchKey = GlobalKey();
  static final GlobalKey<NavigatorState> settingsBranchKey = GlobalKey();

  static final GoRouter _router = GoRouter(
    initialLocation: MobilePages.homePage.path,
    routes: [
      StatefulShellRoute(
        builder: (context, state, navigationShell) =>
            AppNavigationWidget(navigationShell: navigationShell),
        navigatorContainerBuilder: (context, navigationShell, children) {
          return BranchTransitionContainer(
            currentIndex: navigationShell.currentIndex,
            children: children,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: homeBranchKey,
            routes: [
              GoRoute(
                path: MobilePages.homePage.path,
                name: MobilePages.homePage.name,
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: HomePage()),
                routes: [
                  GoRoute(
                    path: MobilePages.expenseAddPage.path,
                    name: MobilePages.expenseAddPage.name,
                    pageBuilder: (context, state) => bottomUpPage(
                      key: state.pageKey,
                      child: const ExpenseAddScreen(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: analyticsBranchKey,
            routes: [
              GoRoute(
                path: MobilePages.analyticsPage.path,
                name: MobilePages.analyticsPage.name,
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: const AnalyticsPage()),
                routes: [
                  GoRoute(
                    path: MobilePages.mockAnalyticsPage.path,
                    name: MobilePages.mockAnalyticsPage.name,
                    pageBuilder: (context, state) => bottomUpPage(
                      key: state.pageKey,
                      child: const MockPage(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: searchBranchKey,
            routes: [
              GoRoute(
                path: MobilePages.searchPage.path,
                name: MobilePages.searchPage.name,
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: const SearchPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: settingsBranchKey,
            routes: [
              GoRoute(
                path: MobilePages.settingsPage.path,
                name: MobilePages.settingsPage.name,
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: const SettingsPage()),
                routes: [
                  GoRoute(
                    path: MobilePages.themePage.path,
                    name: MobilePages.themePage.name,
                    pageBuilder: (context, state) => bottomUpPage(
                      key: state.pageKey,
                      child: const ThemePage(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
  GoRouter get router => _router;
}

enum MobilePages {
  homePage,
  expenseAddPage,
  analyticsPage,
  mockAnalyticsPage,
  searchPage,
  settingsPage,
  themePage;

  static MobilePages? fromName(String? name) {
    return MobilePages.values.firstWhereOrNull(
      (MobilePages element) => element.name == name,
    );
  }
}

extension MobilePagesExt on MobilePages {
  String get path => '/$name';
}
