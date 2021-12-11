import 'package:injectable/injectable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logchain/models/crypto_currency.dart';

@singleton
class UserDataProvider {
  static UserDataProvider get instance => _instance;

  static late final UserDataProvider _instance;
  final Box<String> _favouritesBox;

  UserDataProvider._({required favouritesBox}) : _favouritesBox = favouritesBox;

  static Future<UserDataProvider> init() async {
    await Hive.initFlutter();
    return _instance = UserDataProvider._(
      favouritesBox: await Hive.openBox<String>("favourites"),
    );
  }

  List<CryptoCurrency> get favourites => CryptoCurrency.presets
      .where((it) => _favouritesBox.containsKey(it.symbol))
      .toList();

  bool isFavourite(CryptoCurrency cryptoCurrency) =>
      _favouritesBox.containsKey(cryptoCurrency.symbol);

  void addToFavourite(CryptoCurrency cryptoCurrency) {
    if (isFavourite(cryptoCurrency)) {
      return;
    }

    _favouritesBox.put(cryptoCurrency.symbol, "");
  }

  void removeFromFavourite(CryptoCurrency cryptoCurrency) {
    if (!isFavourite(cryptoCurrency)) {
      return;
    }

    _favouritesBox.delete(cryptoCurrency.symbol);
  }
}
