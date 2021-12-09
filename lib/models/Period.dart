import 'package:logchain/models/PeriodType.dart';

class Period {
  late final String label;
  late final PeriodType periodType;

  Period(this.label, this.periodType);

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
    );
  }
}
