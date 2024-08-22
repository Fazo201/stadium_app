import 'package:json_annotation/json_annotation.dart';
part 'stadium_model.g.dart';

@JsonSerializable()
class StadiumModel {
    final String? name;
    final String? image;
    final String? address;
    final int? pricePerHour;
    final double? longitude;
    final double? latitude;
    final bool? isAvailable;
    final int? id;

    StadiumModel({
        this.name,
        this.image,
        this.address,
        this.pricePerHour,
        this.longitude,
        this.latitude,
        this.isAvailable,
        this.id,
    });

    factory StadiumModel.fromJson(Map<String, dynamic> json) => _$StadiumModelFromJson(json);

    Map<String, dynamic> toJson() => _$StadiumModelToJson(this);
}
