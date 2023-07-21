// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

import 'package:greengrocer/src/models/item_model.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  String id, title;

  //defaultValue vai atribuir um valor variavel na list vazia
  @JsonKey(defaultValue: [])
  List<ItemModel> items;

  // o valor inicial vai ser 0 porque ela vai indicar pagina inicial do app
  @JsonKey(defaultValue: 0)
  int pagination;

  CategoryModel({
    required this.title,
    required this.id,
    required this.items,
    required this.pagination,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  String toString() =>
      'CategoryModel(title: $title, items: $items, pagination: $pagination)';
}
