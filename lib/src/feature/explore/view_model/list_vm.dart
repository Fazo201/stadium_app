import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stadium_project/src/core/server/api/api_server.dart';
import 'package:stadium_project/src/data/model/stadium_model.dart';

final apiServerVm = Provider<ApiServer>((ref) {
  return ApiServer(Dio());
});

final stadiumsVm = FutureProvider<List<StadiumModel>>((ref) async {
  final apiServer = ref.read(apiServerVm);
  return await apiServer.getStadiumInfo();
});
