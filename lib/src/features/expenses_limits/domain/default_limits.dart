/// Дефолтные лимиты по категориям по ключу (имена enum CategoryForLimit).
/// en — до 1000 USD, ru — до 100 000 RUB. Единый источник для блока и репозитория.
Map<String, double> defaultCategoryLimitsMap(String languageCode) {
  final isRu = languageCode == 'ru';
  return isRu
      ? <String, double>{
          'food': 20000,
          'restaurant': 12000,
          'taxi': 8000,
          'transport': 10000,
          'shopping': 15000,
          'bills': 10000,
          'education': 5000,
          'health': 8000,
          'entertainment': 6000,
          'internet': 4000,
          'other': 12000,
        }
      : <String, double>{
          'food': 200,
          'restaurant': 120,
          'taxi': 80,
          'transport': 100,
          'shopping': 150,
          'bills': 100,
          'education': 50,
          'health': 80,
          'entertainment': 60,
          'internet': 40,
          'other': 120,
        };
}
