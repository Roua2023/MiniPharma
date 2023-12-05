class Bilan {
  int? id;
  String? nomMedcin;
  String specialite;
  String image;
  String resultat;

  Bilan({
    required this.id,
    required this.nomMedcin,
    required this.specialite,
    required this.image,
   required this.resultat
  });

  factory Bilan.fromJson(Map<String, dynamic> json) {
    return Bilan(
     id: json['id'],
      nomMedcin: json['nomMedcin'],
      specialite: json['specialite'],
      image: json['image']?? null,
      resultat: json['resultat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
     'id': id,
      'nomMedcin': nomMedcin,
      'specialite': specialite,
      'image': image,
      'resultat': resultat,
    };
  }
}