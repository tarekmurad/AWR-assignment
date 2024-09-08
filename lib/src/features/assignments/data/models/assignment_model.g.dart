// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentModel _$AssignmentModelFromJson(Map<String, dynamic> json) =>
    AssignmentModel(
      id: (json['id'] as num?)?.toInt(),
      customer:
          CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      car: CarModel.fromJson(json['car'] as Map<String, dynamic>),
      status: json['status'] as String,
      ref: json['ref'] as String,
      type: json['type'] as String,
      sourceLocation: LocationModel.fromJson(
          json['source_location'] as Map<String, dynamic>),
      destinationLocation: LocationModel.fromJson(
          json['destination_location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssignmentModelToJson(AssignmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ref': instance.ref,
      'status': instance.status,
      'type': instance.type,
      'customer': instance.customer,
      'car': instance.car,
      'source_location': instance.sourceLocation,
      'destination_location': instance.destinationLocation,
    };
