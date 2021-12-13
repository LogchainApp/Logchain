import 'package:meta/meta.dart';

@immutable
class Currency {
  final CurrencyType type;
  final String label;
  final String apiId;

  Currency({
    required this.type,
    required this.label,
    required this.apiId
  });

  static List<Currency> presets = [
    Currency(type: CurrencyType.USDT, label: "USDT", apiId: 'usd'),
    Currency(type: CurrencyType.RUB, label: "RUB", apiId: 'rub'),
    Currency(type: CurrencyType.EUR, label: "EUR", apiId: 'eur'),
  ];
}

enum CurrencyType { USDT, RUB, EUR }
