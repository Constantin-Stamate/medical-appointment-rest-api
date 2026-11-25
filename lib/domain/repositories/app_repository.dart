import '../entities/app_data.dart';

abstract class AppRepository {
  Future<AppData> loadAppData();
}