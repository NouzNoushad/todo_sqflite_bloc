import 'package:flutter/material.dart';

import 'colors.dart';

InputBorder kTextOutlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: BorderSide(color: kGreyColor, width: 1.2),
);

InputBorder kTextOutlineErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(color: kDeleteColor, width: 1.2),
);
