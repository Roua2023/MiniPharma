class Medicament {
  int? id;
  String nomMed;
  String? photo;

  Medicament({
    required this.id,
    required this.nomMed,
    this.photo,
  });

  factory Medicament.fromJson(Map<String, dynamic> json) {
    return Medicament(
      id: json['id']?? null,
      nomMed: json['nomMed'],
      photo: json['photo'] ?? null, // Handle null value for 'photo'
    );
  }
  @override
  String toString() {
    return nomMed; // or any other property you want to display
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomMed': nomMed,
      'photo': photo,
    };
  }
}
