class CryptoCurrency {
  final String name, symbol, iconPath, link;
  final bool isFavourite;

  final double price, change;

  CryptoCurrency({
    this.name = "Name",
    this.symbol = "SYM",
    this.isFavourite = false,
    this.price = 100.0,
    this.change = 5.0,
    link = "",
  })  : this.iconPath = "assets/icons/logo/${symbol.toLowerCase()}",
        this.link = (link == ""
            ? "https://cryptologos.cc/logos/"
                "${name.toLowerCase()}-${symbol.toLowerCase()}-logo.png"
            : link);

  CryptoCurrency copyWith({
    name = "Name",
    symbol = "SYM",
    isFavourite = false,
    price = 100.0,
    change = 5.0,
    link = "",
  }) =>
      CryptoCurrency(
        name: this.name,
        symbol: this.symbol,
        isFavourite: this.isFavourite,
        price: this.price,
        change: this.change,
        link: this.link,
      );

  static List<CryptoCurrency> presets = [
    CryptoCurrency(
      name: "Bitcoin",
      symbol: "BTC",
      isFavourite: true,
      price: 51450.04,
      change: -1304.78,
    ),
    CryptoCurrency(
      name: "Ethereum",
      symbol: "ETH",
      isFavourite: false,
      price: 3409.04,
      change: 324.78,
    ),
    CryptoCurrency(
      name: "Ripple",
      symbol: "XRP",
      isFavourite: true,
      price: 1.04,
      change: 0.08,
      link: "https://cryptologos.cc/logos/xrp-xrp-logo.png",
    ),
    CryptoCurrency(
        name: "Polkadot",
        symbol: "DOT",
        isFavourite: false,
        price: 23.04,
        change: -3.78,
        link: "https://cryptologos.cc/logos/polkadot-new-dot-logo.png"),
  ];
}

class CurrencyGroup {
  late final String title;
  late final List<CryptoCurrency>? content;

  CurrencyGroup({this.title = "Title", this.content});
}
