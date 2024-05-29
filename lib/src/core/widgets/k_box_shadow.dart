import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class KBoxShadow {
  static BoxShadow top({
    Color? color,
    double blurRadius = 4.0,
    double spreadRadius = 0.0,
    double offsetY = -2.0,
  }) {
    return BoxShadow(
      offset: Offset(0.0, offsetY),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color ?? kItemShadowColor,
    );
  }

  static BoxShadow bottom({
    Color? color,
    double blurRadius = 4.0,
    double spreadRadius = 0.0,
    double offsetY = 2.0,
  }) {
    return BoxShadow(
      offset: Offset(0.0, offsetY),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color ?? kItemShadowColor,
    );
  }

  static BoxShadow left({
    Color? color,
    double blurRadius = 4.0,
    double spreadRadius = 0.0,
    double offsetX = -2.0,
  }) {
    return BoxShadow(
      offset: Offset(offsetX, 0.0),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color ?? kItemShadowColor,
    );
  }

  static BoxShadow right({
    Color? color,
    double blurRadius = 4.0,
    double spreadRadius = 0.0,
    double offsetX = 2.0,
  }) {
    return BoxShadow(
      offset: Offset(offsetX, 0.0),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color ?? kItemShadowColor,
    );
  }

  static BoxShadow vertical({
    Color? color,
    double blurRadius = 4.0,
    double spreadRadius = 0.0,
    double offsetY = 2.0,
  }) {
    return BoxShadow(
      offset: Offset(0.0, offsetY),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color ?? kItemShadowColor,
    );
  }

  static BoxShadow horizontal({
    Color? color,
    double blurRadius = 4.0,
    double spreadRadius = 0.0,
    double offsetX = 2.0,
  }) {
    return BoxShadow(
      offset: Offset(offsetX, 0.0),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color ?? kItemShadowColor,
    );
  }

  static BoxShadow allSides({
    Color? color,
    double blurRadius = 4.0,
    double spreadRadius = 0.0,
    double offset = 2.0,
  }) {
    return BoxShadow(
      offset: Offset(offset, offset),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color ?? kItemShadowColor,
    );
  }

  static BoxShadow item({
    Color? color,
    double blurRadius = 4.0,
    double spreadRadius = 0.0,
  }) {
    return BoxShadow(
      offset: const Offset(0.0, 2.0),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color ?? kItemShadowColor,
    );
  }
}
