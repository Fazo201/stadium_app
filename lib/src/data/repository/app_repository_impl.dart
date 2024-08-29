import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stadium_project/src/core/server/firebase/cloud_firestore_database_server.dart';
import 'package:stadium_project/src/data/entity/stadium_model.dart';
import 'package:stadium_project/src/data/repository/app_repository.dart';

class AppRepositoryImpl extends AppRepository {

  @override
  Future<void> postStadiumFirebase({
    required String image,
    required String name,
    required String address,
    required String pricePerHour,
    required double latitude,
    required double longitude,
    required String workingHours,
    required String phoneNumber,
  }) async {
    log("postStadiumFirebase");
    try {
      StadiumModel stadiumModel = StadiumModel(
        image: image,
        name: name,
        address: address,
        pricePerHour: pricePerHour,
        latitude: latitude,
        longitude: longitude,
        workingHours: workingHours,
        phoneNumber: phoneNumber,
      );
      await CloudFirestoreDatabaseServer.createCollection(
        collectionPath: "Stadiums",
        data: stadiumModel.toJson(),
      );
      log("Data posted");
    } catch (e) {
      log("CloudFirestoreDatabaseServer.createCollection error: $e");
    }
  }
  
  @override
  Future<List<StadiumModel>> getStadiumsFirebase() async {
    log("getStadiumsFirebase");
    List<StadiumModel> stadiumList = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> itemList = [];
    itemList = await CloudFirestoreDatabaseServer.readAllData(collectionPath: "Stadiums");
    for (var item in itemList) {
      stadiumList.add(StadiumModel.fromJson(item.data()));
    }
    for (var e in stadiumList) {
      log(e.phoneNumber.toString());
    }
    return stadiumList;
  }
}
