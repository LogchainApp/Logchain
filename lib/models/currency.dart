import 'package:meta/meta.dart';

@immutable
class Currency {
  final CurrencyType type;
  final String label;
  final String apiId;

  Currency({required this.type, required this.label, required this.apiId});

  static final Currency usd =
          Currency(type: CurrencyType.USDT, label: "USDT", apiId: 'usd'),
      rub = Currency(type: CurrencyType.RUB, label: "RUB", apiId: 'rub'),
      eur = Currency(type: CurrencyType.EUR, label: "EUR", apiId: 'eur');

  static List<Currency> presets = [usd, rub, eur];
}

enum CurrencyType { USDT, RUB, EUR }
