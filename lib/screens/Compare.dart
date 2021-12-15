import 'dart:math';

import 'package:flutter/material.dart';
import 'package:interactive_chart/interactive_chart.dart';

import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/models/currency.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/widgets/CompareCrypto.dart';
import 'package:logchain/widgets/CompareRow.dart';
import 'package:logchain/widgets/Exchange.dart';
import 'package:logchain/widgets/ui_components/PeriodPicker.dart';

import '../network/network_provider.dart';

class Compare extends StatefulWidget {
  final CryptoCurrency cryptoCurrencyLeft;
  final CryptoCurrency cryptoCurrencyRight;

  late double exchangeLeftValue = cryptoCurrencyRight.price;
  late double exchangeRightValue = cryptoCurrencyLeft.price;

  Compare(
      {required this.cryptoCurrencyLeft,
      required this.cryptoCurrencyRight,
      Key? key})
      : super(key: key);

  @override
  State<Compare> createState() => _CompareState();
}

class _CompareState extends State<Compare> {
  String calcChange(CryptoCurrency currency) {
    return (currency.change > 0 ? "\$" : "-\$") +
        currency.change.abs().toStringAsFixed(2) +
        " (${(currency.change / currency.price).toStringAsFixed(2)}%)";
  }

  double calcExchange(double value, double priceFirst, double priceSecond) {
    return value * priceFirst / priceSecond;
  }

  @override
  Widget build(BuildContext context) {
    var changeLeft = calcChange(widget.cryptoCurrencyLeft);
    var changeRight = calcChange(widget.cryptoCurrencyRight);
    print(changeLeft);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 32),
          Row(
            children: [
              CompareCrypto(currency: widget.cryptoCurrencyLeft),
              CompareCrypto(currency: widget.cryptoCurrencyRight)
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Container(child: PeriodPicker(), height: 80),
          ),
          CompareRow(
            title: "Price",
            leftValue: Text("\$${widget.cryptoCurrencyLeft.price}",
                style: Theme.of(context).textTheme.headline6),
            rightValue: Text("\$${widget.cryptoCurrencyRight.price}",
                style: Theme.of(context).textTheme.headline6),
          ),
          CompareRow(
            title: "Change",
            leftValue: Text(
              "${changeLeft}",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: widget.cryptoCurrencyLeft.change >= 0
                        ? ColorResources.green
                        : ColorResources.red,
                  ),
            ),
            rightValue: Text(
              "${changeRight}",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: widget.cryptoCurrencyRight.change >= 0
                        ? ColorResources.green
                        : ColorResources.red,
                  ),
            ),
          ),
          CompareRow(
            title: "Volume (USDT)",
            leftValue: Text(
              (widget.cryptoCurrencyLeft.volume.toInt() / pow(10, 9))
                      .toStringAsFixed(2) +
                  "B",
              style: Theme.of(context).textTheme.headline6,
            ),
            rightValue: Text(
              (widget.cryptoCurrencyRight.volume.toInt() / pow(10, 9))
                      .toStringAsFixed(2) +
                  "B",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          FutureBuilder<Map<String, CandleData>>(
              future: NetworkProvider.instance.fetchMultipleDailyChanges(
                cryptoCurrencyList: [
                  widget.cryptoCurrencyLeft,
                  widget.cryptoCurrencyRight,
                ],
                currency: Currency.usd,
              ),
              builder: (context, snapshot) {
                var leftData = snapshot.hasData
                        ? snapshot.data![widget.cryptoCurrencyLeft.symbol]
                        : null,
                    rightData = snapshot.hasData
                        ? snapshot.data![widget.cryptoCurrencyRight.symbol]
                        : null;

                print(leftData);
                return Column(
                  children: [
                    CompareRow(
                      title: "24h High",
                      leftValue: Text(
                        leftData?.high?.toString() ?? "0.00",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      rightValue: Text(
                        rightData?.high?.toString() ?? "0.00",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    CompareRow(
                      title: "24h Low",
                      leftValue: Text(
                        leftData?.low?.toString() ?? "0.00",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      rightValue: Text(
                        rightData?.low?.toString() ?? "0.00",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    CompareRow(
                      title: "24h Average",
                      leftValue: Text(
                        leftData != null
                            ? ((leftData.low! + leftData.high!) / 2)
                                .toStringAsFixed(2)
                            : "0.00",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      rightValue: Text(
                        rightData != null
                            ? ((rightData.low! + rightData.high!) / 2)
                            .toStringAsFixed(2)
                            : "0.00",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                );
              }),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child:
                Text("Exchange", style: Theme.of(context).textTheme.bodyText1),
          ),
          Exchange(
            firstCryptoCurrency: widget.cryptoCurrencyLeft,
            secondCryptoCurrency: widget.cryptoCurrencyRight,
            firstValue: widget.exchangeLeftValue,
            secondValue: widget.exchangeRightValue,
            onFirstValueChanged: (value) {
              setState(() {
                widget.exchangeRightValue = calcExchange(
                  value,
                  widget.cryptoCurrencyLeft.price,
                  widget.cryptoCurrencyRight.price,
                );
              });
            },
            onSecondValueChanged: (value) {
              setState(() {
                widget.exchangeLeftValue = calcExchange(
                  value,
                  widget.cryptoCurrencyRight.price,
                  widget.cryptoCurrencyLeft.price,
                );
              });
            },
          )
        ],
      ),
    );
  }
}
