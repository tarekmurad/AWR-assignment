library tracking_model;

import 'package:aw_rostamani/src/features/tracking/data/models/vendor_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entites/tracking.dart';
import 'car_model.dart';
import 'customer_model.dart';
import 'location_model.dart';

part 'tracking_model.g.dart';

@JsonSerializable()
class TrackingModel extends Tracking {
  TrackingModel({
    super.id,
    required CustomerModel customer,
    required VendorModel vendor,
    required CarModel car,
    required String status,
    required String ref,
    required String type,
    required LocationModel sourceLocation,
    required LocationModel destinationLocation,
  }) : super(
          customer: customer,
          vendor: vendor,
          car: car,
          status: status,
          ref: ref,
          type: type,
          sourceLocation: sourceLocation,
          destinationLocation: destinationLocation,
        );

  // Custom fromJson and toJson methods for customer, car, and location
  factory TrackingModel.fromJson(Map<String, dynamic> json) =>
      _$TrackingModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrackingModelToJson(this);

// @override
// @JsonKey(fromJson: CustomerModel.fromJson, toJson: CustomerModel.toJson)
// final CustomerModel customer;
//
// @override
// @JsonKey(fromJson: CarModel.fromJson, toJson: CarModel.toJson)
// final CarModel car;
//
// @override
// @JsonKey(fromJson: LocationModel.fromJson, toJson: LocationModel.toJson)
// final LocationModel sourceLocation;
//
// @override
// @JsonKey(fromJson: LocationModel.fromJson, toJson: LocationModel.toJson)
// final LocationModel destinationLocation;
}
