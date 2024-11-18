// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProdutoModel {
  final String produto;
  final double preco;

  ProdutoModel({required this.produto, required this.preco});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'produto': produto,
      'preco': preco,
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      produto: map['produto'] as String,
      preco: map['preco'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(String source) =>
      ProdutoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
