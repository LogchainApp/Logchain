import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logchain/models/period.dart';
import 'package:logchain/models/PeriodType.dart';
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
    return Container(
        decoration: BoxDecoration(color: Theme
            .of(context)
            .backgroundColor,),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: PeriodType.values.length,
          itemBuilder: (BuildContext context, int index) {
            return ChoiceChip(
              label: Container(
                child: Text(
                  Period
                      .from(PeriodType.values[index])
                      .label,
                  style: TextStyles.regular.copyWith(
                    color: this.periodType.index == index
                        ? Theme
                        .of(context)
                        .canvasColor
                        : Theme
                        .of(context)
                        .primaryColor,
                  ),
                ),
              ),
              selectedColor: Theme
                  .of(context)
                  .primaryColorDark,
              backgroundColor: Theme
                  .of(context)
                  .canvasColor,
              selected: this.periodType.index == index,
              elevation: 4,
              shadowColor: Theme
                  .of(context)
                  .shadowColor
                  .withOpacity(0.2),
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
        ));
  }
}
