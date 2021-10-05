import 'package:design/src/config/routes/app_routes.dart';
import 'package:design/src/config/themes/app_themes.dart';
import 'package:design/src/core/utils/constants.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kMaterialAppTitle,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      theme: AppTheme.light,
    );
  }
}
