class Doctor {
  final String id, name, specialty, distance, avatarUrl;
  final bool isFavorite;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.distance,
    required this.avatarUrl,
    this.isFavorite = false,
  });

  Doctor copyWith({bool? isFavorite}) => Doctor(
    id: id,
    name: name,
    specialty: specialty,
    distance: distance,
    avatarUrl: avatarUrl,
    isFavorite: isFavorite ?? this.isFavorite,
  );
}