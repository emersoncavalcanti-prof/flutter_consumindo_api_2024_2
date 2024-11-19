import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_consumindo_api/pages/splash_screen.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return MultiProvider(providers: [
      Provider<Dio>.value(value: dio),
    ]);
  }
}
