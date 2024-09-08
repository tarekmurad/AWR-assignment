// library authentication;
//
// import 'package:json_annotation/json_annotation.dart';
//
// import '../../domain/entites/get_tracking.dart';
//
// part 'authentication_model.g.dart';
//
// @JsonSerializable()
// class AuthenticationModel extends Authentication {
//   AuthenticationModel({
//     String? token,
//     String? type,
//     String? refreshToken,
//     int? id,
//     String? username,
//     String? email,
//     Iterable<String>? roles,
//   }) : super(
//           token: token,
//           type: type,
//           refreshToken: refreshToken,
//           id: id,
//           username: username,
//           email: email,
//           roles: roles,
//         );
//
//   factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
//       _$AuthenticationFromJson(json);
//
//   Map<String, dynamic> toJson() => _$AuthenticationToJson(this);
// }
