import 'package:flutter/material.dart';
import 'package:flutter_consumindo_api/data/http/http_client.dart';
import 'package:flutter_consumindo_api/data/repositories/user_repository.dart';
import 'package:flutter_consumindo_api/pages/login/store/user_store.dart';
import 'package:flutter_consumindo_api/widget/custom_edit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  bool clicou = false;

  @override
  Widget build(BuildContext context) {
    final dioClient = Provider.of<DioClient>(context);

    UserStore store = UserStore(
      repository: UserRepository(client: dioClient),
    );

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Hero(
                tag: 'ete',
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 30,
                ),
              ),
              const SizedBox(width: 10),
              const Text('Bem vindo'),
            ],
          ),
          backgroundColor: const Color(0xFF204353),
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Lottie.asset('assets/animacoes/welcome.json'),
                CustomEdit(
                  controller: controllerEmail,
                  label: 'Digite seu Email',
                  icone: const Icon(Icons.email),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Digite seu Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomEdit(
                  controller: controllerPassword,
                  label: 'Digite sua Senha',
                  icone: const Icon(Icons.lock),
                  isObscure: true,
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return 'Digite sua Senha';
                    }

                    if (password.length < 4) {
                      return 'Sua senha deve ter no mínimo 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        clicou = !clicou;
                      });

                      await store.login(
                        email: controllerEmail.text,
                        password: controllerPassword.text,
                      );

                      setState(() {
                        clicou = !clicou;
                      });

                      if (store.error.value.isNotEmpty) {
                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              //'Login ou senha inválidos',
                              store.error.value,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      } else {
                        if (!mounted) return;

                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    }
                  },
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: clicou == true ? 40 : width,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFF204353),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: clicou == true
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Logar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
