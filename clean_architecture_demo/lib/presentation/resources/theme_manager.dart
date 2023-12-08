import 'package:clean_architecture_demo/presentation/resources/styles_manager.dart';
import 'package:clean_architecture_demo/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    // ripple color
    splashColor: ColorManager.primaryOpacity70,
    // will be used in case of disabled button for example
    hintColor: ColorManager.grey,

    // App bar theme
    appBarTheme: AppBarTheme(
        centerTitle: false,
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.primaryOpacity70,
        titleTextStyle:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16)),

    // Text theme
    textTheme: TextTheme(
        displayLarge: getSemiBoldStyle(
            color: ColorManager.darkGrey, fontSize: FontSize.s16),
        displayMedium:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
        displaySmall:
            getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s16),
        headlineMedium: getRegularStyle(
            color: ColorManager.primary, fontSize: FontSize.s14),
        titleMedium: getMediumStyle(
            color: ColorManager.lightGrey, fontSize: FontSize.s14),
        titleSmall:
            getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s14),
        bodyMedium: getMediumStyle(color: ColorManager.lightGrey),
        bodySmall: getRegularStyle(color: ColorManager.grey1),
        bodyLarge: getRegularStyle(color: ColorManager.grey)),

    //Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(color: ColorManager.white),
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s120))),
  );
}
