import '../../domain/entities/app_data.dart';
import 'doctor_model.dart';

class AppDataModel extends AppData {
  const AppDataModel({
    required super.home,
    required super.details,
    required super.doctors,
    required super.services,
  });

  factory AppDataModel.fromJson(
    Map<String, dynamic> home,
    Map<String, dynamic> details,
  ) {
    for (final key in ['user', 'notifications', 'search', 'appointment']) {
      home[key] as Map<String, dynamic>;
    }
    for (final key in [
      'doctor',
      'payment',
      'details',
      'workingHours',
      'date',
      'actions',
    ]) {
      details[key] as Map<String, dynamic>;
    }
    for (final key in ['workingHours', 'date']) {
      for (final slot in details[key]['slots'] as List) {
        slot['label'] as String;
      }
    }
    return AppDataModel(
      home: home,
      details: details,
      doctors: (home['nearbyDoctors'] as List)
          .map((e) => DoctorModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      services: (home['healthServices'] as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {'feed': home, 'details': details};
}