import 'package:flutter/material.dart';
import 'package:stadium_project/src/core/server/api/api.dart';
import 'package:stadium_project/src/data/model/stadium_model.dart';
import 'package:stadium_project/src/data/repository/app_repository.dart';

@immutable
final class AppRepositoryImpl implements AppRepository{
  @override
  Future<List<StadiumModel>?> getStadiumInfo()async {
    String? str = await Api.get(Api.apiGetStadium, Api.emptyParams());
    try {
      if (str!=null) {
        List<StadiumModel> model = stadiumModelFromJson(str);
        return model;
      }else{
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  
}