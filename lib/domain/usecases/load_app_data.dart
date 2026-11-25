import '../entities/app_data.dart';
import '../repositories/app_repository.dart';

class LoadAppData {
  final AppRepository repository;

  const LoadAppData(this.repository);

  Future<AppData> call() => repository.loadAppData();
}