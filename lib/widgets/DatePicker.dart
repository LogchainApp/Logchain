import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logchain/models/Period.dart';
import 'package:logchain/models/PeriodType.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/styles/TextStyles.dart';

typedef DatePickerOnChangeCallback = void Function(Period priod);

class DatePicker extends StatefulWidget {
  final DatePickerOnChangeCallback? onChanged;

  DatePicker({this.onChanged});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: PeriodType.values.length,
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            label: Text(
              Period.from(PeriodType.values[index]).label,
              style: TextStyles.regular.copyWith(
                color: _value == index
                    ? ColorResources.white
                    : ColorResources.darkGrey,
              ),
            ),
            selectedColor: ColorResources.black,
            backgroundColor: ColorResources.white,
            selected: _value == index,
            elevation: 1,
            pressElevation: 4,
            onSelected: (bool selected) {
              if (_value == index) {
                return;
              }
              setState(() {
                widget.onChanged?.call(Period.from(PeriodType.values[index]));
                _value = index;
              });
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 8,
          );
        },
      ),
    );
  }
}
