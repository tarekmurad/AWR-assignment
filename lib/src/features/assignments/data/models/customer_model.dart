library customer_model;

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entites/customer.dart';

part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel extends Customer {
  CustomerModel({
    super.id,
    super.name,
    super.phone,
    super.email,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
