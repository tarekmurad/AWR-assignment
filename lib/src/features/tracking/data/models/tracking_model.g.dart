// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackingModel _$TrackingModelFromJson(Map<String, dynamic> json) =>
    TrackingModel(
      id: (json['id'] as num?)?.toInt(),
      customer:
          CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      vendor: VendorModel.fromJson(json['vendor'] as Map<String, dynamic>),
      car: CarModel.fromJson(json['car'] as Map<String, dynamic>),
      status: json['status'] as String,
      ref: json['ref'] as String,
      type: json['type'] as String,
      sourceLocation: LocationModel.fromJson(
          json['source_location'] as Map<String, dynamic>),
      destinationLocation: LocationModel.fromJson(
          json['destination_location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrackingModelToJson(TrackingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ref': instance.ref,
      'status': instance.status,
      'type': instance.type,
      'customer': instance.customer,
      'vendor': instance.vendor,
      'car': instance.car,
      'source_location': instance.sourceLocation,
      'destination_location': instance.destinationLocation,
    };
