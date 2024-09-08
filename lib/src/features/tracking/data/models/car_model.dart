library car_model;

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entites/car.dart';

part 'car_model.g.dart';

@JsonSerializable()
class CarModel extends Car {
  CarModel({
    String? make,
    String? model,
    String? color,
    String? licensePlate,
    String? vinNumber,
  }) : super(
          make: make,
          model: model,
          color: color,
          licensePlate: licensePlate,
          vinNumber: vinNumber,
        );

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}
