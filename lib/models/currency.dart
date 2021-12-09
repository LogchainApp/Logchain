class Currency {
  final CurrencyType type;
  final String label;

  Currency({
    required this.type,
    required this.label
  }) {

  }

  static List<Currency> presets = [
    Currency(
      type: CurrencyType.USD,
      label: "USD"
    ),
    Currency(
        type: CurrencyType.RUB,
        label: "RUB"
    ),
    Currency(
        type: CurrencyType.EUR,
        label: "EUR"
    ),
  ];
}

enum CurrencyType {
  USD,
  RUB,
  EUR
}
