// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResponse _$ListResponseFromJson(Map<String, dynamic> json) => ListResponse(
      code: json['code'] as String?,
    )
      ..message = json['message'] as String?
      ..action = json['action'] as String?
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList();

Map<String, dynamic> _$ListResponseToJson(ListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'action': instance.action,
      'data': instance.data,
    };
