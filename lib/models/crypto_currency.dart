import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'crypto_currency.freezed.dart';

@immutable
@freezed
class CryptoCurrency with _$CryptoCurrency {
  CryptoCurrency._();

  String get pictureLink =>
      "https://cryptologos.cc/logos/" +
      "${this.customName == "" ? this.name.replaceAll(" ", "-").toLowerCase() : this.customName}" +
      "-${this.symbol.toLowerCase()}-logo.png";

  double get change => changePercents * price / 100;

  factory CryptoCurrency({
    @Default("") String name,
    @Default("") String symbol,
    @Default(false) bool isFavourite,
    @Default(0) double price,
    @Default(0) double changePercents,
    @Default("ethereum") String id,
    @Default("") String customName,
  }) = _CryptoCurrency;

  static CryptoCurrency byId(String id) =>
      presets.firstWhere((element) => element.id == id);

  static List<CryptoCurrency> presets = [
    CryptoCurrency(
      name: "Bitcoin",
      symbol: "BTC",
      isFavourite: false,
      id: "bitcoin",
    ),
    CryptoCurrency(
      name: "Ethereum",
      symbol: "ETH",
      isFavourite: false,
      id: "ethereum",
    ),
    CryptoCurrency(
      name: "Ripple",
      symbol: "XRP",
      isFavourite: true,
      customName: "xrp",
      id: "ripple",
    ),
    CryptoCurrency(
      name: "Polkadot",
      symbol: "DOT",
      isFavourite: false,
      price: 23.04,
      customName: "polkadot-new",
      id: "polkadot",
    ),
    CryptoCurrency(
      name: "Dogecoin",
      symbol: "DOGE",
      isFavourite: true,
      price: 0.73,
      id: "dogecoin",
    ),
    CryptoCurrency(
      name: "Shiba Inu",
      symbol: "SHIB",
      isFavourite: false,
      price: 0.02,
      id: "shiba-inu",
    ),
    CryptoCurrency(
      name: "Uniswap",
      symbol: "UNI",
      isFavourite: false,
      price: 34.2,
      id: "uniswap",
    ),
    CryptoCurrency(
      name: "Monero",
      symbol: "XMR",
      isFavourite: false,
      price: 75.4,
      id: "monero",
    ),
    CryptoCurrency(
      name: "PancakeSwap",
      symbol: "CAKE",
      isFavourite: false,
      price: 32.45,
      id: "pancakeswap-token",
    ),
    CryptoCurrency(name: "Cosmos", symbol: "ATOM", id: "cosmos"),
    CryptoCurrency(name: "BakeryToken", symbol: "BAKE", id: "bakerytoken"),
    CryptoCurrency(name: "PooCoin", symbol: "POOCOIN", id: "poocoin"),
    CryptoCurrency(name: "Cardano", symbol: "ADA", id: "cardano"),
    CryptoCurrency(name: "Solana", symbol: "SOL", id: "solana"),
    CryptoCurrency(
      name: "Terra",
      symbol: "LUNA",
      id: "terra-luna",
      customName: "terra-luna",
    ),
  ];
}

class CurrencyGroup {
  late final String title;
  late final List<CryptoCurrency>? content;

  CurrencyGroup({this.title = "Title", this.content});
}
