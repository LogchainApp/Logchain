import 'package:meta/meta.dart';

@immutable
class Currency {
  final CurrencyType type;
  final String label;

  Currency({
    required this.type,
    required this.label,
  });

  static List<Currency> presets = [
    Currency(type: CurrencyType.USDT, label: "USDT"),
    Currency(type: CurrencyType.RUB, label: "RUB"),
    Currency(type: CurrencyType.EUR, label: "EUR"),
  ];
}

enum CurrencyType { USDT, RUB, EUR }
