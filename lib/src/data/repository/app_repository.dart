import 'package:stadium_project/src/data/model/stadium_model.dart';

abstract class AppRepository{
  Future<List<StadiumModel>?> getStadiumInfo();
}