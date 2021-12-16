import 'package:injectable/injectable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logchain/models/crypto_currency.dart';

import '../network/network_provider.dart';

@singleton
class UserDataProvider {
  static UserDataProvider get instance => _instance;

  static late final UserDataProvider _instance;
  final Box<String> _favouritesBox;
  final _preferencesBox;

  static const String PREFERENCES_DARK_MODE = "dark_mode";

  UserDataProvider._({
    required favouritesBox,
    required preferencesBox,
  })
      : _favouritesBox = favouritesBox,
        _preferencesBox = preferencesBox;

  static Future<UserDataProvider> init() async {
    await Hive.initFlutter();
    return _instance = UserDataProvider._(
      favouritesBox: await Hive.openBox<String>("favourites"),
      preferencesBox: await Hive.openBox("preferences")
    );
  }

  List<CryptoCurrency> get favourites => NetworkProvider.instance.currencyList
      .where((it) => _favouritesBox.containsKey(it.symbol))
      .toList();

  bool get isDarkThemeOn => _preferencesBox.get(PREFERENCES_DARK_MODE) ?? false;

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

  void switchTheme() {
    print(isDarkThemeOn);
    _preferencesBox.put(PREFERENCES_DARK_MODE, !isDarkThemeOn);
  }
}
