class BaseModel {
  int statusCode;
  String errorMessage;

  BaseModel(this.statusCode, this.errorMessage);

  BaseModel.fromJson(Map json) : errorMessage = json['message'];
}
