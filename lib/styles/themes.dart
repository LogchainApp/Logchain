import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logchain/styles/ColorResources.dart';

import 'ColorResources.dart';
import 'TextStyles.dart';

final light = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: ColorResources.lightGrey,
    foregroundColor: ColorResources.black,
  ),
  primaryColor: ColorResources.lightGrey,
  backgroundColor: ColorResources.lightGrey,
  fontFamily: TextStyles.fontFamily,
  textTheme: TextTheme(
    headline1: TextStyles.title,
    headline6: TextStyles.bold,
    bodyText1: TextStyles.regular,
    bodyText2: TextStyles.small,
  ),
);
