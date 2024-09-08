library list_response;

import 'package:json_annotation/json_annotation.dart';

part 'list_response.g.dart';

@JsonSerializable()
class ListResponse {
  String? code;
  String? message;
  String? action;
  List<Map<String, dynamic>>? data;

  ListResponse({this.code});

  factory ListResponse.fromJson(Map<String, dynamic> json) =>
      _$ListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListResponseToJson(this);
}
