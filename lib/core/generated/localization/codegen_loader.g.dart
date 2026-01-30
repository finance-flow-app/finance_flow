// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ru = {
  "welcome_to_finance_flow": "Добро пожаловать в Finance Flow",
  "expense_add_title": "Внесение расходов",
  "current_limit": "Текущий лимит",
  "description_optional": "Описание (необязательно)",
  "add": "Внести",
  "categories": {
    "food": "Еда",
    "transport": "Транспорт",
    "shopping": "Покупки",
    "bills": "Счета",
    "sources": "Доходы",
    "education": "Образование",
    "other": "Другое"
  },
  "limit_period": {
    "day": "День",
    "week": "Неделя",
    "month": "Месяц"
  },
  "limit_exceeded": {
    "day": "Превышен дневной лимит",
    "week": "Превышен недельный лимит",
    "month": "Превышен месячный лимит"
  },
  "expense_saved": "Трата успешно записана.",
  "expense_save_error": "Не удалось сохранить. Попробуйте ещё раз."
};
static const Map<String,dynamic> _en = {
  "welcome_to_finance_flow": "Welcome to Finance Flow",
  "expense_add_title": "Add Expense",
  "current_limit": "Current Limit",
  "description_optional": "Description (optional)",
  "add": "Add",
  "categories": {
    "food": "Food",
    "transport": "Transport",
    "shopping": "Shopping",
    "bills": "Bills",
    "sources": "Sources",
    "education": "Education",
    "other": "Other"
  },
  "limit_period": {
    "day": "Day",
    "week": "Week",
    "month": "Month"
  },
  "limit_exceeded": {
    "day": "Daily limit exceeded",
    "week": "Weekly limit exceeded",
    "month": "Monthly limit exceeded"
  },
  "expense_saved": "Expense saved successfully.",
  "expense_save_error": "Failed to save. Please try again."
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": _ru, "en": _en};
}
