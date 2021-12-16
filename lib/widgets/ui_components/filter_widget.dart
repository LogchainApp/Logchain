import 'package:flutter/material.dart';
import 'package:logchain/models/filter_type.dart';
import 'package:logchain/styles/text_styles.dart';

typedef OnFilterChangedCallback = void Function(FilterType filterType);

class FilterWidget extends StatelessWidget {
  final OnFilterChangedCallback? onFilterChangedCallback;
  final FilterType filterType;
  final FilterOrder filterOrder;

  FilterWidget({
    this.onFilterChangedCallback,
    this.filterType = FilterType.None,
    this.filterOrder = FilterOrder.Increasing,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rowGroup(context, "Name", FilterType.Name),
              rowGroup(context, "Vol", FilterType.Vol),
              rowGroup(context, "Price", FilterType.Price),
              rowGroup(context, "Chg", FilterType.Chg),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(
                  Icons.view_agenda_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowGroup(
    BuildContext context,
    String label,
    FilterType filterType,
  ) {
    return GestureDetector(
      onTap: () => onFilterChangedCallback?.call(filterType),
      child: Row(children: [
        Icon(
          filterOrder == FilterOrder.Increasing
              ? Icons.arrow_drop_up
              : Icons.arrow_drop_down,
          color: filterType == this.filterType
              ? Theme.of(context).primaryColorDark
              : Theme.of(context).primaryColorLight,
        ),
        SizedBox(width: 2),
        Text(
          label,
          style: TextStyles.regular
              .copyWith(
                color: filterType == this.filterType
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).primaryColor,
              )
              .copyWith(
                fontWeight: filterType == this.filterType
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
        ),
      ]),
    );
  }
}
