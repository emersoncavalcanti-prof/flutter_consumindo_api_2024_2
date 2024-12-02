import 'package:flutter/material.dart';
import 'package:flutter_consumindo_api/data/http/http_client.dart';
import 'package:flutter_consumindo_api/data/local/local_storage.dart';
import 'package:flutter_consumindo_api/data/repositories/produto_repository.dart';
import 'package:flutter_consumindo_api/pages/home/store/produto_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = Provider.of<DioClient>(context);

    final ProdutoStore store =
        ProdutoStore(repository: ProdutoRepository(client: dioClient));

    store.get();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text('John Doe'),
                accountEmail: Text('johndoe@example.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://gravatar.com/avatar/27205e5c51cb03f862138b22bcb5dc20f94a342e744ff6df1b8dc8af3c865109'),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configurações'),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  LocalStorage.removeString('token');
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          ),
        ),
        body: AnimatedBuilder(
            animation: Listenable.merge([
              store.isLoading,
              store.error,
              store.state,
            ]),
            builder: (context, child) {
              if (store.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (store.error.value.isNotEmpty) {
                return Center(child: Text(store.error.value));
              }

              if (store.state.value.isEmpty) {
                return const Center(child: Text('Nenhum produto encontrado'));
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: store.state.value.length,
                  itemBuilder: (_, index) {
                    final item = store.state.value[index];

                    return ListTile(
                      leading: Image.asset(
                        'assets/images/logo.png',
                        width: 50,
                      ),
                      title: Text(item.nome),
                      subtitle: Text('R\$ ${item.preco}'),
                    );
                  },
                );
              }
            }));
  }
}
