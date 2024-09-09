class Authentication {
  String? token;
  String? type;
  String? refreshToken;
  int? id;
  String? username;
  String? email;
  Iterable<String>? roles;

  Authentication(
      {this.type,
      this.refreshToken,
      this.id,
      this.username,
      this.email,
      this.roles,
      this.token});

  @override
  List<Object?> get props => [token];
}
