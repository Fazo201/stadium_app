import 'package:json_annotation/json_annotation.dart';
part 'stadium_model.g.dart';

@JsonSerializable()
class StadiumModel {
    final String? name;
    final String? image;
    final String? address;
    final String? pricePerHour;
    final double? latitude;
    final double? longitude;
    final String? workingHours;
    final String? phoneNumber;

    StadiumModel({
        this.name,
        this.image,
        this.address,
        this.pricePerHour,
        this.latitude,
        this.longitude,
        this.workingHours,
        this.phoneNumber,
    });

    factory StadiumModel.fromJson(Map<String, dynamic> json) => _$StadiumModelFromJson(json);

    Map<String, dynamic> toJson() => _$StadiumModelToJson(this);
}
