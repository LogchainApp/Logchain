import 'package:logchain/models/PeriodType.dart';

import 'package:meta/meta.dart';

@immutable
class Period {
  final String label;
  final PeriodType periodType;
  final int days;

  Period(this.label, this.periodType, this.days);

  factory Period.from(PeriodType periodType) {
    return Period(
      [
        "Hour",
        "24h",
        "3 days",
        "Week",
        "Month"
      ][PeriodType.values.indexOf(periodType)],
      periodType,
      [1, 1, 7, 7, 30][PeriodType.values.indexOf(periodType)],
    );
  }
}
