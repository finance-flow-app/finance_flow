import 'package:easy_localization/easy_localization.dart';
import 'package:finance_flow/core/assets/app_fonts.dart';
import 'package:finance_flow/core/di/service_locator.dart';
import 'package:finance_flow/core/generated/localization/locale_keys.g.dart';
import 'package:finance_flow/core/shared/app_custom_appbar.dart';
import 'package:finance_flow/src/features/manage_categories/domain/repository/manage_categories_repository.dart';
import 'package:finance_flow/src/features/manage_categories/presentation/bloc/manage_categories_bloc.dart';
import 'package:finance_flow/src/features/manage_categories/presentation/widgets/categories_tabs_widget.dart';
import 'package:finance_flow/src/features/manage_categories/presentation/widgets/category_list_widget.dart';
import 'package:finance_flow/src/features/manage_categories/presentation/widgets/group_chips_row_widget.dart';
import 'package:finance_flow/src/features/manage_categories/presentation/widgets/settings_categories_bar_widget.dart';
import 'package:finance_flow/src/features/manage_categories/presentation/widgets/sticky_footer_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageCategoriesPage extends StatelessWidget {
  const ManageCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = ManageCategoriesBloc(sl<ManageCategoriesRepository>());
        bloc.add(LoadCategoriesOrder());
        return bloc;
      },
      child: const _ManageCategoriesContent(),
    );
  }
}

class _ManageCategoriesContent extends StatelessWidget {
  const _ManageCategoriesContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(
        title: Text(
          LocaleKeys.manage_categories_title.tr(),
          style: AppFonts.b5s26medium,
        ),
        actions: const [SettingsCategoriesBarWidget()],
      ),
      body: BlocBuilder<ManageCategoriesBloc, ManageCategoriesState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoriesTabsWidget(
                        selectedTab: state.selectedTab,
                        onTabChanged: (tab) {
                          context.read<ManageCategoriesBloc>().add(
                            ManageCategoriesTabChanged(tab),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      GroupChipsRowWidget(
                        selectedGroup: state.selectedGroup,
                        onGroupSelected: (group) {
                          context.read<ManageCategoriesBloc>().add(
                            ManageCategoriesGroupChanged(group),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      CategoryListWidget(
                        categoriesOrder: state.categoriesOrder,
                        onOrderChanged: (entity) {
                          context.read<ManageCategoriesBloc>().add(
                            CategoriesOrderDraftChanged(entity),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              StickyFooterButtonWidget(
                onCancel: () {
                  context.read<ManageCategoriesBloc>().add(
                    RevertCategoriesOrder(),
                  );
                },
                onSaveChanges: () {
                  context.read<ManageCategoriesBloc>().add(
                    SaveCategoriesOrder(),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
