abstract class AppRepository {
 
  Future<void> postStadiumFirebase({
    required String image,
    required String name,
    required String address,
    required String pricePerHour,
    required double latitude,
    required double longitude,
    required String workingHours,
    required String phoneNumber,
  });

  Future<void> getStadiumsFirebase();
}
