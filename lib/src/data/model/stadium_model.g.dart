// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stadium_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StadiumModel _$StadiumModelFromJson(Map<String, dynamic> json) => StadiumModel(
      name: json['name'] as String?,
      image: json['image'] as String?,
      address: json['address'] as String?,
      pricePerHour: (json['pricePerHour'] as num?)?.toInt(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      isAvailable: json['isAvailable'] as bool?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StadiumModelToJson(StadiumModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'address': instance.address,
      'pricePerHour': instance.pricePerHour,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'isAvailable': instance.isAvailable,
      'id': instance.id,
    };
