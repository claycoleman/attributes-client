class LoginModel {
  final String jwt;

  LoginModel(this.jwt);

  LoginModel.fromJson(Map<String, dynamic> json) : jwt = json['jwt'];

  Map<String, dynamic> toJson() => {
        'jwt': jwt,
      };
}
