import 'package:flutter/material.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/widgets/CompareCrypto.dart';
import 'package:logchain/widgets/CompareRow.dart';
import 'package:logchain/widgets/Exchange.dart';
import 'package:logchain/widgets/ui_components/PeriodPicker.dart';

class _CustomScrollBehavior extends MaterialScrollBehavior {

  ScrollPhysics getScrollPhysics(BuildContext context) {
    return _CustomScrollPhysics(parent: BouncingScrollPhysics());
  }
}

class _CustomScrollPhysics extends ScrollPhysics {
  _CustomScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);
  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    final parent = this.parent;
    if (parent == null)
      return 0.0;

    if (value < position.pixels && position.pixels <= position.minScrollExtent) // underscroll
      return value - position.pixels;
    return parent.applyBoundaryConditions(position, value);
  }
}

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
    return ScrollConfiguration(
      behavior: _CustomScrollBehavior(),
      child: SingleChildScrollView(
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
                title: "24h High",
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
                  Text("todo", style: Theme.of(context).textTheme.headline6)
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text("Exchange cryptos", style: Theme.of(context).textTheme.bodyText1),
            ),
            Exchange(
              firstCryptoCurrency: widget.cryptoCurrencyLeft,
              secondCryptoCurrency: widget.cryptoCurrencyRight,
              firstValue: widget.exchangeLeftValue,
              secondValue: widget.exchangeRightValue,
              onFirstValueChanged: (value) {
                setState(() {
                  // this.exchangeLeftValue = value;
                  widget.exchangeRightValue = calcExchange(value, widget.cryptoCurrencyLeft.price, widget.cryptoCurrencyRight.price);
                });
              },
              onSecondValueChanged: (value) {
                setState(() {
                  widget.exchangeLeftValue = calcExchange(value, widget.cryptoCurrencyRight.price, widget.cryptoCurrencyLeft.price);
                  // this.exchangeRightValue = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
