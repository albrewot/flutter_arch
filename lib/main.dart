import 'package:design/src/config/routes/app_routes.dart';
import 'package:design/src/config/themes/app_themes.dart';
import 'package:design/src/core/utils/constants.dart';
import 'package:design/src/injector.dart';
import 'package:design/src/presentation/blocs/remote_articles/remote_articles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
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
    return MultiBlocProvider(
        providers: [
          BlocProvider<RemoteArticlesBloc>(
            create: (_) => injector()..add(const GetRemoteArticles()),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: kMaterialAppTitle,
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          theme: AppTheme.light,
        ));
  }
}
