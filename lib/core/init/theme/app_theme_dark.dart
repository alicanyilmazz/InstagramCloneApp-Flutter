import 'package:flutter/material.dart';
import '../../constant/app/app_constant.dart';
import 'app_theme.dart';
import 'dark/dark_theme_interface.dart';

class AppThemeDark extends AppTheme with IDarkTheme {
  static AppThemeDark? _instance;
  static AppThemeDark get instance {
    return _instance ??= AppThemeDark._init();
  }

  AppThemeDark._init();

  // ThemeData get theme => redTheme;
  @override
  ThemeData get theme => ThemeData(
        fontFamily: ApplicationConstants.FONT_FAMILY,
        colorScheme: _appColorScheme,
        textTheme: textTheme(),
        appBarTheme: ThemeData.dark().appBarTheme.copyWith(
              brightness: Brightness.dark,
              color: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Color(0xFF808080), size: 21),
              // backgroundColor: Colors.pink
            ),
        inputDecorationTheme: inputDecorationThemeModern(),
        scaffoldBackgroundColor: colorSchemeDark!.modernDark,
        floatingActionButtonTheme:
            ThemeData.dark().floatingActionButtonTheme.copyWith(),
        buttonTheme: ThemeData.dark().buttonTheme.copyWith(
              colorScheme: ColorScheme.dark(
                onError: Colors.grey,
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
        cardColor: colorSchemeDark!.tgo,
        indicatorColor: Color(0xffC20003), //XX
        hintColor: Color(0x8a000000), //xx
        errorColor: Color(0xffd32f2f),
      );

  InputDecorationTheme inputDecarationTheme() {
    return InputDecorationTheme(
      focusColor: Colors.black45,
      labelStyle: TextStyle(),
      fillColor: Color(0xff676870),
      contentPadding: EdgeInsets.zero,
      filled: true,
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.3)),
      // border: OutlineInputBorder(borderSide: BorderSide(width: 0.3)),
      focusedBorder: OutlineInputBorder(),
    );
  }

  InputDecorationTheme inputDecorationThemeModern() {
    return InputDecorationTheme(
      labelStyle: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      helperStyle: TextStyle(
        color: Colors.brown,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      hintStyle: TextStyle(
        color: Colors.white,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorStyle: TextStyle(
        color: colorSchemeDark!.highRatingRed,
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
      ),
      suffixStyle: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      counterStyle: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      filled: false,
      fillColor: Colors.amberAccent,
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
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
      labelStyle: textThemeDark!.headline5,
      unselectedLabelColor: _appColorScheme.onSecondary.withOpacity(0.2),
      // unselectedLabelStyle: textThemeLight.headline4.copyWith(color: colorSchemeLight.red),
    );
  }

  TextTheme textTheme() {
    return ThemeData.dark().textTheme.copyWith(
        headline1: textThemeDark!.headline1,
        headline2: textThemeDark!.headline2,
        overline: textThemeDark!.headline3);
  }

  ColorScheme get _appColorScheme {
    return ColorScheme(
        primary: colorSchemeDark!.black,
        primaryVariant: Colors.white, //xx
        secondary: Colors.green,
        secondaryVariant: colorSchemeDark!.azure,
        surface: Colors.blue, //xx
        background: Colors.red, //xx
        error: Colors.red[900]!,
        onPrimary: Colors.yellow,
        onSecondary: Colors.black45, //x
        onSurface: Colors.black45,
        onBackground: Colors.black45,
        onError: Color(0xFFF9B916), //xx
        brightness: Brightness.dark);
  }
}
