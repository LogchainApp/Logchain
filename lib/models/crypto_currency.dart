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
    @Default(0) double volume,
    @Default("") String website,
  }) = _CryptoCurrency;

  static CryptoCurrency byId(String id) =>
      presets.firstWhere((element) => element.id == id);

  static List<CryptoCurrency> presets = [
    CryptoCurrency(
      name: "Bitcoin",
      symbol: "BTC",
      id: "bitcoin",
      website: "https://bitcoin.org/",
    ),
    CryptoCurrency(
        name: "Ethereum",
        symbol: "ETH",
        id: "ethereum",
        website: "https://www.ethereum.com/"),
    CryptoCurrency(
      name: "Ripple",
      symbol: "XRP",
      customName: "xrp",
      id: "ripple",
      website: "https://ripple.com/",
    ),
    CryptoCurrency(
      name: "Polkadot",
      symbol: "DOT",
      customName: "polkadot-new",
      id: "polkadot",
      website: "https://polkadot.network/",
    ),
    CryptoCurrency(
      name: "Dogecoin",
      symbol: "DOGE",
      id: "dogecoin",
      website: "https://dogecoin.com/",
    ),
    CryptoCurrency(
      name: "Shiba Inu",
      symbol: "SHIB",
      id: "shiba-inu",
      website: "https://shibatoken.com/",
    ),
    CryptoCurrency(
      name: "Uniswap",
      symbol: "UNI",
      id: "uniswap",
      website: "https://uniswap.org/",
    ),
    CryptoCurrency(
      name: "Monero",
      symbol: "XMR",
      isFavourite: false,
      price: 75.4,
      id: "monero",
      website: "https://www.getmonero.org/",
    ),
    CryptoCurrency(
      name: "PancakeSwap",
      symbol: "CAKE",
      isFavourite: false,
      price: 32.45,
      id: "pancakeswap-token",
      website: "https://pancakeswap.finance/",
    ),
    CryptoCurrency(
      name: "Cosmos",
      symbol: "ATOM",
      id: "cosmos",
      website: "https://cosmos.network/",
    ),
    CryptoCurrency(
      name: "BakeryToken",
      symbol: "BAKE",
      id: "bakerytoken",
      website: "https://www.bakeryswap.org/",
    ),
    CryptoCurrency(
      name: "PooCoin",
      symbol: "POOCOIN",
      id: "poocoin",
      website: "https://poocoin.app/",
    ),
    CryptoCurrency(
      name: "Cardano",
      symbol: "ADA",
      id: "cardano",
      website: "https://cardano.org/",
    ),
    CryptoCurrency(
      name: "Solana",
      symbol: "SOL",
      id: "solana",
      website: "https://solana.com/",
    ),
    CryptoCurrency(
      name: "Terra",
      symbol: "LUNA",
      id: "terra-luna",
      customName: "terra-luna",
      website: "https://www.terra.money/",
    ),
  ];
}

class CurrencyGroup {
  late final String title;
  late final List<CryptoCurrency>? content;

  CurrencyGroup({this.title = "Title", this.content});
}
