import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:dio/dio.dart';
import 'package:logchain/models/currency.dart';
import 'package:interactive_chart/interactive_chart.dart';

import '../models/dao/coingecko_dao.dart';
import '../providers/user_data_provider.dart';

@singleton
class NetworkProvider {
  static NetworkProvider get instance => _instance;

  static String baseUrl = "https://api.coingecko.com/api/v3";
  static String etherscanApiKey = "4ISPC3AVM2WVYXA9CITT749CT6YY8RTX46";

  static late NetworkProvider _instance;
  late final Dio _dio;

  late Map<String, CryptoCurrency> _savedData = {};

  List<CryptoCurrency> get currencyList => CryptoCurrency.presets
      .map((e) => _savedData.containsKey(e.symbol)
          ? e.copyWith(
              price: _savedData[e.id]?.price ?? 0,
              changePercents: _savedData[e.id]?.changePercents ?? 0,
            )
          : e)
      .toList();

  NetworkProvider._({required dio, required userDataProvider})
      : this._dio = dio;

  static Future<NetworkProvider> init() async {
    return _instance = NetworkProvider._(
      dio: Dio(
        BaseOptions(baseUrl: baseUrl, responseType: ResponseType.json),
      ),
      userDataProvider: await UserDataProvider.init(),
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

    _savedData = decoded.map(
      (key, value) => MapEntry(
        CryptoCurrency.byId(key).symbol,
        CryptoCurrency.byId(key).copyWith(
          price: value.usd,
          changePercents: value.usd24hChange,
        ),
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
      changePercents: _savedData[currency.id]!.changePercents,
    );
  }

  Future<List<CandleData>> fetchMarketChart({
    required CryptoCurrency cryptoCurrency,
    required Currency currency,
    int days = 1,
    String dataInterval = "hourly",
  }) async {
    var response = await _dio.get(
      '/coins/${cryptoCurrency.id}/ohlc',
      queryParameters: {
        'id': cryptoCurrency.id,
        'vs_currency': currency.apiId,
        'days': days,
      },
      options: Options(responseType: ResponseType.json),
    );

    var result = (response.data as List<dynamic>)
        .map(
          (e) => CandleData(
            timestamp: e[0] as int,
            open: e[1] as double,
            high: e[2] as double,
            low: e[3] as double,
            close: e[4] as double,
            volume: Random().nextDouble(),
          ),
        )
        .toList();

    print(response.realUri);
    return result;
  }
}
