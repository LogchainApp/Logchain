import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logchain/models/crypto_currency.dart';

typedef OnValueChangedCallback = void Function(double value);

class Exchange extends StatelessWidget {
  static const FRACTION_DIGITS = 6;
  final CryptoCurrency firstCryptoCurrency;
  final CryptoCurrency secondCryptoCurrency;
  final double firstValue;
  final double secondValue;
  final OnValueChangedCallback? onFirstValueChanged;
  final OnValueChangedCallback? onSecondValueChanged;

  Exchange({
    required CryptoCurrency this.firstCryptoCurrency,
    required CryptoCurrency this.secondCryptoCurrency,
    double this.firstValue = 0,
    double this.secondValue = 0,
    OnValueChangedCallback? this.onFirstValueChanged,
    OnValueChangedCallback? this.onSecondValueChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).primaryColorLight,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          style: Theme.of(context).textTheme.headline6,
                          onChanged: (String value) {
                            double? doubleValue = double.tryParse(value);
                            if (doubleValue != null) {
                              onFirstValueChanged?.call(doubleValue);
                            } else if (value == "") {
                              onFirstValueChanged?.call(1);
                            }
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: InputBorder.none,
                            hintText: "1"
                          ))),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(16), child: Icon(Icons.arrow_right)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(secondValue.toStringAsFixed(FRACTION_DIGITS),
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 1),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    firstValue.toStringAsFixed(FRACTION_DIGITS),
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 1,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(16), child: Icon(Icons.arrow_left)),
              Expanded(
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).primaryColorLight,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                          autofocus: false,
                          style: Theme.of(context).textTheme.headline6,
                          onChanged: (String value) {
                            double? doubleValue = double.tryParse(value);
                            if (doubleValue != null) {
                              onSecondValueChanged?.call(doubleValue);
                            } else if (value == "") {
                              onSecondValueChanged?.call(1);
                            }
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: InputBorder.none,
                            hintText: "1"
                          ))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
