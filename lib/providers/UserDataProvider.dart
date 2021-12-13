import 'package:injectable/injectable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logchain/models/crypto_currency.dart';

import '../network/network_provider.dart';

@singleton
class UserDataProvider {
  static UserDataProvider get instance => _instance;

  static late final UserDataProvider _instance;
  final Box<String> _favouritesBox;
  final Box<CryptoCurrency> _savedDataBox;

  UserDataProvider._({required favouritesBox, required savedDataBox})
      : _favouritesBox = favouritesBox,
        _savedDataBox = savedDataBox;

  static Future<UserDataProvider> init() async {
    await Hive.initFlutter();
    return _instance = UserDataProvider._(
      favouritesBox: await Hive.openBox<String>("favourites"),
      savedDataBox: await Hive.openBox<CryptoCurrency>("savedData"),
    );
  }

  List<CryptoCurrency> get favourites => NetworkProvider.instance.currencyList
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
