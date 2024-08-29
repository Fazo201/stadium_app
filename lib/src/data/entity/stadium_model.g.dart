// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stadium_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StadiumModel _$StadiumModelFromJson(Map<String, dynamic> json) => StadiumModel(
      name: json['name'] as String?,
      image: json['image'] as String?,
      address: json['address'] as String?,
      pricePerHour: json['pricePerHour'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      workingHours: json['workingHours'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$StadiumModelToJson(StadiumModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'address': instance.address,
      'pricePerHour': instance.pricePerHour,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'workingHours': instance.workingHours,
      'phoneNumber': instance.phoneNumber,
    };
