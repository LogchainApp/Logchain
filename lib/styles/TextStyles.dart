import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logchain/styles/ColorResources.dart';

class TextStyles {
  static const fontFamily = 'Inter';

  static late final title = GoogleFonts.getFont(
    fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: ColorResources.black,
  );

  static late final regular = GoogleFonts.getFont(
    fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorResources.darkGrey,
  );

  static late final bold = title.copyWith(fontSize: 18);

  static late final small = regular.copyWith(fontSize: 13);
}
