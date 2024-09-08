library location_model;

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entites/location.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel extends Location {
  LocationModel({
    double? lat,
    double? long,
    String? addressNotes,
  }) : super(
          lat: lat,
          long: long,
          addressNotes: addressNotes,
        );

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
