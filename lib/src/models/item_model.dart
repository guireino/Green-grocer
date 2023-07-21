// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

//part vai criar class com comando terminal flutter pub run build_runner watch
part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  String id;

  //jsonkey vai atribuir um outro nome na variavel
  @JsonKey(name: 'title')
  String itemName;

  @JsonKey(name: 'picture')
  String imgUrl;

  String unit;
  String description;
  double price;

  ItemModel({
    this.id = '',
    required this.itemName,
    required this.imgUrl,
    required this.unit,
    required this.description,
    required this.price,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  //toString foi criado para poder dar print ver resultados
  @override
  String toString() {
    return 'ItemModel(id: $id, itemName: $itemName, imgUrl: $imgUrl, unit: $unit, description: $description, price: $price)';
  }
}
