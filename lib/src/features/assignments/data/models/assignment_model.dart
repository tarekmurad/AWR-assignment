library assignment_model;

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entites/assignment.dart';
import 'car_model.dart';
import 'customer_model.dart';
import 'location_model.dart';

part 'assignment_model.g.dart';

@JsonSerializable()
class AssignmentModel extends Assignment {
  AssignmentModel({
    super.id,
    required CustomerModel customer,
    required CarModel car,
    required String status,
    required String ref,
    required String type,
    required LocationModel sourceLocation,
    required LocationModel destinationLocation,
  }) : super(
          customer: customer,
          car: car,
          status: status,
          ref: ref,
          type: type,
          sourceLocation: sourceLocation,
          destinationLocation: destinationLocation,
        );

  // Custom fromJson and toJson methods for customer, car, and location
  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$AssignmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentModelToJson(this);

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
