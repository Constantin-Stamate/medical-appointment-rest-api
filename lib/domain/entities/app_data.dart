import 'doctor.dart';

class AppData {
  final Map<String, dynamic> home;
  final Map<String, dynamic> details;
  final List<Doctor> doctors;
  final List<Map<String, dynamic>> services;

  const AppData({
    required this.home,
    required this.details,
    required this.doctors,
    required this.services,
  });

  AppData copyWithDoctors(List<Doctor> value) =>
      AppData(home: home, details: details, doctors: value, services: services);
}