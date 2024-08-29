import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stadium_project/src/data/entity/stadium_model.dart';
import 'package:stadium_project/src/data/repository/app_repository_impl.dart';

final stadiumsVm = FutureProvider<List<StadiumModel>>((ref) async {
  return await AppRepositoryImpl().getStadiumsFirebase();
});
