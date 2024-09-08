library vendor_model;

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entites/vendor.dart';

part 'vendor_model.g.dart';

@JsonSerializable()
class VendorModel extends Vendor {
  VendorModel({
    super.id,
    super.name,
    super.phone,
    super.email,
    super.company,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) =>
      _$VendorModelFromJson(json);

  Map<String, dynamic> toJson() => _$VendorModelToJson(this);
}
