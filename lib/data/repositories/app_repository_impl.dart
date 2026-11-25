import '../../domain/entities/app_data.dart';
import '../../domain/repositories/app_repository.dart';
import '../datasources/app_remote_data_source.dart';
import '../models/app_data_model.dart';

class AppRepositoryImpl implements AppRepository {
  final AppRemoteDataSource remote;

  const AppRepositoryImpl(this.remote);

  @override
  Future<AppData> loadAppData() async {
    final results = await Future.wait([
      remote.fetchFeed(),
      remote.fetchDetails(),
    ]);
    return AppDataModel.fromJson(results[0], results[1]);
  }
}