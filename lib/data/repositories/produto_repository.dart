import 'package:flutter_consumindo_api/data/http/endpoints.dart';
import 'package:flutter_consumindo_api/data/http/exceptions.dart';
import 'package:flutter_consumindo_api/data/http/http_client.dart';
import 'package:flutter_consumindo_api/data/local/local_storage.dart';
import 'package:flutter_consumindo_api/data/models/produto_model.dart';

class ProdutoRepository {
  final IHttpClient client;

  ProdutoRepository({required this.client});

  Future<List<ProdutoModel>> get() async {
    final token = await LocalStorage.getString('token');

    final response =
        await client.get(url: '${Endpoints.baseUrl}/produto', headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final List<ProdutoModel> produtos = [];

      final body = response.data;

      body.map((item) {
        final ProdutoModel produto = ProdutoModel.fromMap(item);
        produtos.add(produto);
      }).toList();

      return produtos;
    } else if (response.statusCode == 401) {
      throw Exception('Não autorizado');
    } else if (response.statusCode == 404) {
      throw Exception('Não encontrado');
    } else {
      throw NotFoundException('Não foi possível carregar os dados');
    }
  }
}
