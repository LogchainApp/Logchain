import 'package:injectable/injectable.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:dio/dio.dart';

import '../models/dao/coingecko_dao.dart';

@singleton
class NetworkProvider {
  static NetworkProvider get instance => _instance;

  static String baseUrl = "https://api.coingecko.com/api/v3";
  static late NetworkProvider _instance;
  late final Dio _dio;

  late Map<String, CryptoCurrency> _savedData = {};

  NetworkProvider._({required dio}) : this._dio = dio;

  static Future<NetworkProvider> init() async {
    return _instance = NetworkProvider._(
      dio: Dio(
        BaseOptions(baseUrl: baseUrl, responseType: ResponseType.json),
      ),
    );
  }

  Future<Map<String, CryptoCurrency>> fetchPrices() async {
    var response = await _dio.get(
      '/simple/price',
      queryParameters: {
        'ids': CryptoCurrency.presets.map((e) => e.id).join(","),
        'vs_currencies': 'usd',
        'include_market_cap': true,
        'include_24hr_vol': true,
        'include_24hr_change': true,
        'include_last_updated_at': true,
      },
    );

    Map<String, CoingeckoDao> decoded = (response.data as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, CoingeckoDao.fromJson(value)));

    print(response.realUri);

    _savedData = decoded.map(
      (key, value) => MapEntry(
        key,
        CryptoCurrency.byId(key).copyWith(price: value.usd),
      ),
    );
    return _savedData;
  }

  Future<CryptoCurrency> fetchCurrency(CryptoCurrency currency) async {
    if (_savedData[currency.id] == null) {
      await fetchPrices();
    }

    return currency.copyWith(
      price: _savedData[currency.id]!.price,
      change: _savedData[currency.id]!.change,
    );
  }
}
