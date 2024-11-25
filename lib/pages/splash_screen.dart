import 'package:flutter/material.dart';
import 'package:flutter_consumindo_api/data/local/local_storage.dart';
import 'package:flutter_consumindo_api/pages/home/home_page.dart';
import 'package:flutter_consumindo_api/pages/login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double width = 0.0;
  double height = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        width = 250.0;
        height = 250.0;
      });

      final token = await LocalStorage.getString('token');

      await Future.delayed(const Duration(seconds: 3));

      final nav = Navigator.of(context);

      if (token != null && token.isNotEmpty) {
        nav.pushReplacement(PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomePage(),
          settings: const RouteSettings(name: '/home'),
        ));
      } else {
        nav.pushReplacement(PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginPage(),
          settings: const RouteSettings(name: '/login'),
        ));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 3),
                curve: Curves.elasticInOut,
                width: width,
                height: height,
                child: Hero(
                  tag: 'ete',
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
