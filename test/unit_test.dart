import 'package:flutter_test/flutter_test.dart';
import 'package:logchain/models/crypto_currency.dart';

void main() {
  test('test picture link on crypto currency', () {
    final cryptoCurrency = CryptoCurrency(
      name: "Bitcoin",
      symbol: "BTC",
      id: "bitcoin",
      website: "https://bitcoin.org/",
    );

    final expectedLink = "https://cryptologos.cc/logos/bitcoin-btc-logo.png";

    expect(cryptoCurrency.pictureLink, equals(expectedLink));
  });

  test('test picture link on crypto currency with spaces', () {
    final cryptoCurrency = CryptoCurrency(
      name: "Bitcoin 123-abc_qwerty",
      symbol: "BTC",
      id: "bitcoin",
      website: "https://bitcoin.org/",
    );

    final expectedLink = "https://cryptologos.cc/logos/bitcoin-123-abc_qwerty-btc-logo.png";

    expect(cryptoCurrency.pictureLink, equals(expectedLink));
  });
}
