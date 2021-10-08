import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_fm_challenge/1_navigation/app_route_configurator.dart';
import 'package:last_fm_challenge/2_state_management/main_scoped_model.dart';
import 'package:last_fm_challenge/screens/splash_screen.dart';
import 'package:last_fm_challenge/utilities/colors.dart';
import 'package:last_fm_challenge/utilities/scoped_model_utils.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // make the status bar transparent and set icons color to light
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(EasyLocalization(
      child: MyApp(),
      useOnlyLangCode: true,
      fallbackLocale: Locale('en'),
      supportedLocales: [
        Locale('en'),
      ],
      path: 'lang',
    ));
  });
}

class MyApp extends StatefulWidget {
  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _appModel = MainModel();

  @override
  Widget build(BuildContext context) {
    ScopedModelUtils().setModel(_appModel);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return ScopedModel<MainModel>(
      model: _appModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
              color: ThemeColors.text.primary.withOpacity(0.5),
            ),
          ),
          textTheme: TextTheme(
            bodyText2: TextStyle(fontWeight: FontWeight.w400),
          ),
          // set top border color around Scaffold's persistentFooterButtons
          dividerTheme: DividerThemeData(color: Colors.transparent),
          // remove button padding in Scaffold's persistentFooterButtons
          buttonBarTheme: ButtonBarThemeData(buttonPadding: EdgeInsets.zero),
        ),
        home: SplashScreen(),
        routes: RouteConfigurator.allAppRoutesList(context),
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        localeResolutionCallback: (locale, supportedLocales) {
          // // Check if the current device locale is supported
          if (locale == null) {
            debugPrint("*language locale is null!!!");
            EasyLocalization.of(context).setLocale(supportedLocales.first);
            Intl.defaultLocale = '${supportedLocales.first}';
            return supportedLocales.first;
          }

          for (Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              debugPrint("*language ok $supportedLocale");
              EasyLocalization.of(context).setLocale(supportedLocale);
              Intl.defaultLocale = '$supportedLocale';
              return supportedLocale;
            }
          }

          debugPrint("*language to fallback ${supportedLocales.first}");
          EasyLocalization.of(context).setLocale(supportedLocales.first);
          Intl.defaultLocale = '${supportedLocales.first}';
          return supportedLocales.first;
        },
      ),
    );
  }
}
