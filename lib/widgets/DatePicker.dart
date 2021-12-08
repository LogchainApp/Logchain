import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logchain/models/Period.dart';
import 'package:logchain/styles/ColorResources.dart';

typedef DatePickerOnChangeCallback = void Function(Period priod);

class DatePicker extends StatefulWidget {
  late final List<Period> periods;
  late final DatePickerOnChangeCallback? onChanged;

  DatePicker(
    List<Period> periods, {
    Key? key,
    DatePickerOnChangeCallback? onChanged,
  }) {
    this.periods = periods;
    this.onChanged = onChanged;
  }

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: widget.periods
          .asMap()
          .map((index, element) => MapEntry(
              index,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChoiceChip(
                    label: Text(element.label),
                    selectedColor: ColorResources.black,
                    backgroundColor: ColorResources.white,
                    selected: _value == index,
                    elevation: 1,
                    pressElevation: 1,
                    onSelected: (bool selected) {
                      setState(() {
                        if (_value != index) {
                          widget.onChanged?.call(element);
                        }
                        _value = index;
                      });
                    }),
              )))
          .values
          .toList(),
    );
  }
}
