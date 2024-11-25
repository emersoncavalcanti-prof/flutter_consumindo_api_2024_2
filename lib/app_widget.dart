import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_consumindo_api/data/http/http_client.dart';
import 'package:flutter_consumindo_api/pages/home/home_page.dart';
import 'package:flutter_consumindo_api/pages/login/login_page.dart';
import 'package:flutter_consumindo_api/pages/splash_screen.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return MultiProvider(
      providers: [
        Provider<Dio>.value(value: dio),
        ProxyProvider<Dio, DioClient>(
          update: (context, dio, dioClient) {
            return DioClient(dio);
          },
        )
      ],
      child: MaterialApp(
        title: 'Consumindo API',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
