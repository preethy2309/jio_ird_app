import 'package:json_annotation/json_annotation.dart';
part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse {
  final String result;

  TokenResponse({required this.result});

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}
