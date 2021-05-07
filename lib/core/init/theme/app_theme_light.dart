import 'package:flutter/material.dart';
import 'package:flutter_sample/core/constant/app/app_constant.dart';
import 'app_theme.dart';
import 'light/light_theme_interface.dart';

class AppThemeLight extends AppTheme with ILightTheme {
  static AppThemeLight _instance;
  static AppThemeLight get instance {
    return _instance ??= AppThemeLight._init();
  }

  AppThemeLight._init();

  // ThemeData get theme => redTheme;
  @override
  ThemeData get theme => ThemeData(
        fontFamily: ApplicationConstants.FONT_FAMILY,
        colorScheme: _appColorScheme,
        textTheme: textTheme(),
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
              brightness: Brightness.light,
              color: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black87, size: 21),
            ),
        inputDecorationTheme: inputDecorationThemeModern(),
        scaffoldBackgroundColor: Color(0xfffec051),
        floatingActionButtonTheme:
            ThemeData.light().floatingActionButtonTheme.copyWith(),
        //Button Theme
        buttonTheme: ThemeData.light().buttonTheme.copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xfff44336),
                primaryVariant: Color(0xffd32f2f),
                secondary: Color(0xffC20003), //xx
                secondaryVariant: Color(0xffd32f2f),
                surface: Color(0xffffffff),
                background: Color(0xffef9a9a),
                error: Color(0xffd32f2f),
                onPrimary: Color(0xffffffff), //xx
                onSecondary: Color(0xff000000),
                onSurface: Color(0xff000000),
                onBackground: Color(0xffffffff),
                onError: Color(0xffffffff),
                brightness: Brightness.light,
              ),
              buttonColor: Color(0xffe0e0e0),
              disabledColor: Color(0x61000000),
              highlightColor: Color(0x29000000),
              splashColor: Color(0x1f000000),
              hoverColor: Color(0x0a000000),
              focusColor: Color(0x1f000000),
              //new features
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(0xff000000),
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
              ),
            ),
        tabBarTheme: tabBarTheme,

        dividerColor: Color(0xffffffff),
        highlightColor: Color(0x66bcbcbc),
        splashColor: Color(0xffE8E8E8),
        selectedRowColor: Color(0xfff5f5f5),
        unselectedWidgetColor: Color(0x8a000000),
        disabledColor: Color(0x61000000),
        buttonColor: Color(0xffe0e0e0),
        toggleableActiveColor: Color(0xffe53935),
        secondaryHeaderColor: Color(0xffffebee),
        toggleButtonsTheme: ToggleButtonsThemeData(
            fillColor: Color(0xffC20003),
            textStyle: TextStyle(color: Colors.white),
            selectedColor: Colors.white),

        dialogBackgroundColor: Color(0xffffffff),
        cardColor: Color(0xfff0aa17),
        indicatorColor: Color(0xffC20003), //XX
        hintColor: Color(0x8a000000), //xx
        errorColor: Color(0xffd32f2f),
      );

  InputDecorationTheme inputDecarationTheme() {
    return InputDecorationTheme(
      focusColor: Colors.amber,
      labelStyle: TextStyle(),
      fillColor: Colors.deepOrange.shade200,
      contentPadding: EdgeInsets.zero,
      filled: true,
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.3)),
      border: OutlineInputBorder(borderSide: BorderSide(width: 0.3)),
      focusedBorder: OutlineInputBorder(),
    );
  }

  InputDecorationTheme inputDecorationThemeModern() {
    return InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.red,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      helperStyle: TextStyle(
        color: Colors.green,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      hintStyle: TextStyle(
        color: colorSchemeLight.inputHintColor,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorStyle: TextStyle(
        color: colorSchemeLight.inputErrorTextColor,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorMaxLines: null,
      isDense: false,
      contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
      isCollapsed: false,
      prefixStyle: TextStyle(
          color: Colors.black,
          fontSize: null,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          decorationColor: Colors.amber),
      suffixStyle: TextStyle(
        color: Colors.black,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      counterStyle: TextStyle(
        color: Colors.black,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      filled: false,
      fillColor: Color(0x00000000),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorSchemeLight.inputErrorColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorSchemeLight.inputFocusedColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorSchemeLight.inputFocusedErrorColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      //UnderLine Start
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorSchemeLight.inputDefaultColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
  }

  TabBarTheme get tabBarTheme {
    return TabBarTheme(
      labelPadding: insets.lowPaddingAll,
      labelColor: _appColorScheme.onSecondary,
      labelStyle: textThemeLight.headline5,
      unselectedLabelColor: _appColorScheme.onSecondary.withOpacity(0.2),
      // unselectedLabelStyle: textThemeLight.headline4.copyWith(color: colorSchemeLight.red),
    );
  }

  TextTheme textTheme() {
    return ThemeData.light().textTheme.copyWith(
        headline1: textThemeLight.headline1,
        headline2: textThemeLight.headline2,
        overline: textThemeLight.headline3);
  }

  ColorScheme get _appColorScheme {
    return ColorScheme(
        primary: colorSchemeLight
            .white, //At the same time cursor color.,button color
        primaryVariant: Colors.white, //xx
        secondary: Colors.red,
        secondaryVariant: colorSchemeLight.azure,
        surface: Colors.grey, //xx
        background: Color(0xfff6f9fc), //xx
        error: Colors.red[900],
        onPrimary: Colors.grey,
        onSecondary: Colors.black, //x
        onSurface: Colors.white30,
        onBackground: Colors.black12,
        onError: Color(0xFFF9B916), //xx
        brightness: Brightness.light);
  }
}
