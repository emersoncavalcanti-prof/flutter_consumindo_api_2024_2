import 'package:flutter/material.dart';
import 'package:flutter_consumindo_api/data/http/exceptions.dart';
import 'package:flutter_consumindo_api/data/models/produto_model.dart';
import 'package:flutter_consumindo_api/data/repositories/produto_repository.dart';

class ProdutoStore {
  final ProdutoRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<List<ProdutoModel>> state = ValueNotifier([]);
  final ValueNotifier<ProdutoModel?> produto =
      ValueNotifier<ProdutoModel?>(null);
  final ValueNotifier<String> error = ValueNotifier('');

  ProdutoStore({required this.repository});

  Future get() async {
    isLoading.value = true;
    try {
      final result = await repository.get();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
    return null;
  }
}
