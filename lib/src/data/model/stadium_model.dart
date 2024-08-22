import 'dart:convert';

List<StadiumModel> stadiumModelFromJson(String str) => List<StadiumModel>.from(json.decode(str).map((x) => StadiumModel.fromJson(x)));

String stadiumModelToJson(List<StadiumModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

    factory StadiumModel.fromJson(Map<String, dynamic> json) => StadiumModel(
        name: json["name"],
        image: json["image"],
        address: json["address"],
        pricePerHour: json["pricePerHour"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        isAvailable: json["isAvailable"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "address": address,
        "pricePerHour": pricePerHour,
        "longitude": longitude,
        "latitude": latitude,
        "isAvailable": isAvailable,
        "id": id,
    };
}
