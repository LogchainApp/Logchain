import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'coingecko_dao.freezed.dart';
part 'coingecko_dao.g.dart';

@immutable
@freezed
class CoingeckoDao with _$CoingeckoDao {
  CoingeckoDao._();

  factory CoingeckoDao({
    @JsonKey(name: "usd") required double usd,
    @JsonKey(name: "usd_market_cap") required double usdMarketCap,
    @JsonKey(name: "usd_24h_vol") required double usd24hVolume,
    @JsonKey(name: "usd_24h_change") required double usd24hChange,
    @JsonKey(name: "last_updated_at") required double lastUpdatedAt,
  }) = _CoingeckoDao;

  factory CoingeckoDao.fromJson(Map<String, dynamic> json) =>
      _$CoingeckoDaoFromJson(json);
}
