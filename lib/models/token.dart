class Token {
  String token;
  Token._();
  Token(this.token);

  Token.fromJsonBody(Map json) : token = json['token'];
}
