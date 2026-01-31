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
    "health": "Здоровье",
    "entertainment": "Развлечения",
    "savings": "Вклады",
    "taxi": "Такси",
    "restaurants": "Рестораны",
    "internet": "Интернет",
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
  "expense_save_error": "Не удалось сохранить. Попробуйте ещё раз.",
  "expenses_history_title": "История расходов",
  "expenses_history": {
    "all_categories": "Все",
    "select_period": "Выбрать период",
    "quick_select": "Быстрый выбор",
    "custom_period": "Свой период",
    "apply": "Применить",
    "spending_limits": "Расходы",
    "no_expenses": "Нет расходов за этот период",
    "today": "Сегодня",
    "yesterday": "Вчера",
    "limit_exceeded_warning": "Вы превысили лимит"
  }
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
    "health": "Health",
    "entertainment": "Entertainment",
    "savings": "Savings",
    "taxi": "Taxi",
    "restaurants": "Restaurants",
    "internet": "Internet",
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
  "expense_save_error": "Failed to save. Please try again.",
  "expenses_history_title": "Expenses History",
  "expenses_history": {
    "all_categories": "All",
    "select_period": "Select period",
    "quick_select": "Quick select",
    "custom_period": "Custom period",
    "apply": "Apply",
    "spending_limits": "Expenses",
    "no_expenses": "No expenses for this period",
    "today": "Today",
    "yesterday": "Yesterday",
    "limit_exceeded_warning": "You have exceeded the limit"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": _ru, "en": _en};
}
