import 'package:flutter/material.dart';
import 'package:logchain/models/FilterType.dart';
import 'package:logchain/styles/ColorResources.dart';
import 'package:logchain/styles/TextStyles.dart';

typedef OnFilterChangedCallback = void Function(FilterType filterType);

class FilterWidget extends StatelessWidget {
  final OnFilterChangedCallback? onFilterChangedCallback;
  final FilterType filterType;

  FilterWidget({
    this.onFilterChangedCallback,
    this.filterType = FilterType.None,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: ColorResources.grey),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rowGroup(context, Icons.arrow_drop_up, "Name", FilterType.Name),
              rowGroup(context, Icons.arrow_drop_down, "Vol", FilterType.Vol),
              rowGroup(
                  context, Icons.arrow_drop_down, "Price", FilterType.Price),
              rowGroup(context, Icons.arrow_drop_up, "Chg", FilterType.Chg),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(
                  Icons.view_agenda_outlined,
                  color: ColorResources.darkGrey,
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
    IconData iconData,
    String label,
    FilterType filterType,
  ) {
    return GestureDetector(
      onTap: () => onFilterChangedCallback?.call(filterType),
      child: Row(children: [
        Icon(
          iconData,
          color: filterType == this.filterType
              ? ColorResources.black
              : ColorResources.grey,
        ),
        SizedBox(width: 2),
        Text(
          label,
          style: TextStyles.regular.copyWith(
            color: filterType == this.filterType
                ? ColorResources.black
                : ColorResources.darkGrey,
          ),
        ),
      ]),
    );
  }
}
