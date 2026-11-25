import '../../domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  const DoctorModel({
    required super.id,
    required super.name,
    required super.specialty,
    required super.distance,
    required super.avatarUrl,
    super.isFavorite,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    id: json['id'] as String,
    name: json['name'] as String,
    specialty: json['specialty'] as String,
    distance: json['distance'] as String,
    avatarUrl: json['avatarUrl'] as String,
    isFavorite: json['isFavorite'] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'specialty': specialty,
    'distance': distance,
    'avatarUrl': avatarUrl,
    'isFavorite': isFavorite,
  };
}