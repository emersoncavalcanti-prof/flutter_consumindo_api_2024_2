// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProdutoModel {
  final String nome;
  final double preco;

  ProdutoModel({required this.nome, required this.preco});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'preco': preco,
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      nome: map['nome'] as String,
      preco: (map['preco'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(String source) =>
      ProdutoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
