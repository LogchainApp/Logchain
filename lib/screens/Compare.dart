import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logchain/models/crypto_currency.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/widgets/CompareCrypto.dart';
import 'package:logchain/widgets/CompareRow.dart';
import 'package:logchain/widgets/PeriodPicker.dart';

class _CustomScrollBehavior extends MaterialScrollBehavior {

  ScrollPhysics getScrollPhysics(BuildContext context) {
    return _CustomScrollPhysics(parent: super.getScrollPhysics(context));
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

class Compare extends StatelessWidget {
  final CryptoCurrency cryptoCurrencyLeft;
  final CryptoCurrency cryptoCurrencyRight;

  const Compare(
      {required this.cryptoCurrencyLeft,
      required this.cryptoCurrencyRight,
      Key? key})
      : super(key: key);

  String calcChange(CryptoCurrency currency) {
    return (currency.change > 0 ? "\$" : "-\$") +
        currency.change.abs().toStringAsFixed(2) +
        " (${(currency.change / currency.price).toStringAsFixed(2)}%)";
  }

  @override
  Widget build(BuildContext context) {
    var changeLeft = calcChange(cryptoCurrencyLeft);
    var changeRight = calcChange(cryptoCurrencyRight);
    print(changeLeft);
    return ScrollConfiguration(
      behavior: _CustomScrollBehavior(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24),
            Row(
              children: [
                CompareCrypto(currency: cryptoCurrencyLeft),
                CompareCrypto(currency: cryptoCurrencyRight)
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Container(child: PeriodPicker(), height: 80),
            ),
            CompareRow(
                title: "Price",
                leftValue: Text("\$${cryptoCurrencyLeft.price}",
                    style: Theme.of(context).textTheme.headline6),
                rightValue: Text("\$${cryptoCurrencyRight.price}",
                    style: Theme.of(context).textTheme.headline6)),
            CompareRow(
                title: "Change",
                leftValue: Text("${changeLeft}",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: cryptoCurrencyLeft.change >= 0
                              ? ColorResources.green
                              : ColorResources.red,
                        )),
                rightValue: Text("${changeRight}",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: cryptoCurrencyRight.change >= 0
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
                  Text("todo", style: Theme.of(context).textTheme.headline6),
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}
