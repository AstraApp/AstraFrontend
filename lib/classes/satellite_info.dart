// To parse this JSON data, do
//
//     final satelliteInfo = satelliteInfoFromJson(jsonString);

import 'dart:convert';

SatelliteInfo satelliteInfoFromJson(String str) => SatelliteInfo.fromJson(json.decode(str));

String satelliteInfoToJson(SatelliteInfo data) => json.encode(data.toJson());

class SatelliteInfo {
  SatelliteInfo({
    this.name,
    this.velocity,
    this.image,
    this.resourceId,
    this.resourceName,
    this.description,
  });

  String name;
  String velocity;
  String image;
  String resourceId;
  String resourceName;
  String description;

  factory SatelliteInfo.fromJson(Map<String, dynamic> json) => SatelliteInfo(
    name: json["Name"],
    velocity: json["Velocity"],
    image: json["Image"],
    resourceId: json["ResourceID"],
    resourceName: json["ResourceName"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Velocity": velocity,
    "Image": image,
    "ResourceID": resourceId,
    "ResourceName": resourceName,
    "Description": description,
  };
}
