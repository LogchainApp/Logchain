import 'package:flutter/material.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/styles/color_resources.dart';
import 'package:logchain/widgets/compare_crypto.dart';
import 'package:logchain/widgets/compare_row.dart';
import 'package:logchain/widgets/cxchange.dart';
import 'package:logchain/widgets/ui_components/period_picker.dart';

class Compare extends StatefulWidget {
  final CryptoCurrency cryptoCurrencyLeft;
  final CryptoCurrency cryptoCurrencyRight;

  Compare(
      {required this.cryptoCurrencyLeft,
      required this.cryptoCurrencyRight,
      Key? key})
      : super(key: key);

  @override
  State<Compare> createState() => _CompareState();
}

class _CompareState extends State<Compare> {
  late double exchangeLeftValue;
  late double exchangeRightValue;

  @override
  void initState() {
    super.initState();
    exchangeLeftValue = widget.cryptoCurrencyRight.price;
    exchangeRightValue = widget.cryptoCurrencyLeft.price;
  }


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
                  style: Theme.of(context).textTheme.headline6)),
          CompareRow(
              title: "Change",
              leftValue: Text("${changeLeft}",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: widget.cryptoCurrencyLeft.change >= 0
                            ? ColorResources.green
                            : ColorResources.red,
                      )),
              rightValue: Text("${changeRight}",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: widget.cryptoCurrencyRight.change >= 0
                            ? ColorResources.green
                            : ColorResources.red,
                      ))),
          CompareRow(
              title: "Volume (USDT)",
              leftValue:
                  Text("todo", style: Theme.of(context).textTheme.headline6),
              rightValue:
                  Text("todo", style: Theme.of(context).textTheme.headline6)),
          CompareRow(
              title: "24h High",
              leftValue:
                  Text("todo", style: Theme.of(context).textTheme.headline6),
              rightValue:
                  Text("todo", style: Theme.of(context).textTheme.headline6)),
          CompareRow(
              title: "24h Low",
              leftValue:
                  Text("todo", style: Theme.of(context).textTheme.headline6),
              rightValue:
                  Text("todo", style: Theme.of(context).textTheme.headline6)),
          CompareRow(
              title: "24h Average",
              leftValue:
                  Text("todo", style: Theme.of(context).textTheme.headline6),
              rightValue:
                  Text("todo", style: Theme.of(context).textTheme.headline6)),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child:
                Text("Exchange", style: Theme.of(context).textTheme.bodyText1),
          ),
          Exchange(
            firstCryptoCurrency: widget.cryptoCurrencyLeft,
            secondCryptoCurrency: widget.cryptoCurrencyRight,
            firstValue: exchangeLeftValue,
            secondValue: exchangeRightValue,
            onFirstValueChanged: (value) {
              setState(() {
                exchangeRightValue = calcExchange(
                  value,
                  widget.cryptoCurrencyLeft.price,
                  widget.cryptoCurrencyRight.price,
                );
              });
            },
            onSecondValueChanged: (value) {
              setState(() {
                exchangeLeftValue = calcExchange(
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
