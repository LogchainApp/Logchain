import 'package:injectable/injectable.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:dio/dio.dart';
import 'package:logchain/models/currency.dart';
import 'package:logchain/models/period.dart';

import '../models/dao/coingecko_dao.dart';
import '../providers/UserDataProvider.dart';

@singleton
class NetworkProvider {
  static NetworkProvider get instance => _instance;

  static String baseUrl = "https://api.coingecko.com/api/v3";

  static late NetworkProvider _instance;
  late final Dio _dio;
  late final UserDataProvider _userDataProvider;

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
      : this._dio = dio,
        this._userDataProvider = userDataProvider;

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

    print(response.realUri);

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

  Future<List<double>> fetchMarketChart({
    required CryptoCurrency cryptoCurrency,
    required Currency currency,
    int days = 1,
    String dataInterval = "hourly"
  }) async {
    var response = await _dio.get(
        '/coins/${cryptoCurrency.id}/market_chart',
        queryParameters: {
          'vs_currency': currency.apiId,
          'days': days,
          'interval': dataInterval
        }
    );

    return response.data['prices'].map((data) {
      return data[1];
    });
  }
}
