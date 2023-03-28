class SignInResponse {
  late String accessToken;
  late int expiresIn;
  late String tokenType;
  late String refreshToken;
  late String idToken;

  SignInResponse(this.accessToken, this.expiresIn, this.tokenType,
      this.refreshToken, this.idToken);

  SignInResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['AccessToken'];
    expiresIn = json['ExpiresIn'];
    tokenType = json['TokenType'];
    refreshToken = json['RefreshToken'];
    idToken = json['IdToken'];
  }
  // : accessToken = json['AccessToken'],
  //   expiresIn = json['ExpiresIn'];

  void setAccessToken(String accessToken) {
    this.accessToken = accessToken;
  }

  void setExpiresIn(int expiresIn) {
    this.expiresIn = expiresIn;
  }
}
