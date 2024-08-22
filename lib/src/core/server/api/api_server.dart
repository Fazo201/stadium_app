import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:stadium_project/src/data/model/stadium_model.dart';

part 'api_server.g.dart';

@RestApi(baseUrl: "https://e359ad3eac197df4.mokky.dev/")
abstract class ApiServer {
  factory ApiServer(Dio dio, {String baseUrl}) = _ApiServer;

  @GET("pitches")
  Future<List<StadiumModel>> getStadiumInfo();
}
