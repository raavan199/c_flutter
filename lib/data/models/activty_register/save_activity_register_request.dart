import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';

part 'save_activity_register_request.g.dart';

@JsonSerializable()
class SaveActivityRegisterRequest {
  List<ActivityRegisteredItem>? data;

  SaveActivityRegisterRequest({this.data});

  factory SaveActivityRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$SaveActivityRegisterRequestFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }


}