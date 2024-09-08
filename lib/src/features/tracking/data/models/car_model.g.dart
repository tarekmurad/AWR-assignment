// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
      make: json['make'] as String?,
      model: json['model'] as String?,
      color: json['color'] as String?,
      licensePlate: json['license_plate'] as String?,
      vinNumber: json['vin_number'] as String?,
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'make': instance.make,
      'model': instance.model,
      'color': instance.color,
      'license_plate': instance.licensePlate,
      'vin_number': instance.vinNumber,
    };
