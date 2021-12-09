import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logchain/models/Period.dart';
import 'package:logchain/models/PeriodType.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/styles/TextStyles.dart';

typedef PeriodPickerOnChangeCallback = Function(Period priod);

class PeriodPicker extends StatelessWidget {
  final PeriodPickerOnChangeCallback? onPeriodChanged;
  final PeriodType periodType;

  PeriodPicker({
    this.onPeriodChanged,
    this.periodType = PeriodType.Hours24,
  });

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
                color: this.periodType.index == index
                    ? ColorResources.white
                    : ColorResources.darkGrey,
              ),
            ),
            selectedColor: ColorResources.black,
            backgroundColor: ColorResources.white,
            selected: this.periodType.index == index,
            elevation: 4,
            shadowColor: ColorResources.black.withOpacity(0.2),
            pressElevation: 4,
            onSelected: (bool selected) {
              if (this.periodType.index != index) {
                onPeriodChanged?.call(Period.from(PeriodType.values[index]));
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: 8),
      ),
    );
  }
}
