class Ordonnance {
  int idOrd;
  String nomMedcin;
  DateTime datePrescription;
  String phoneMedcin;
  String specialiteOrd;
  String nomPatient;
  String photoOrdonnance;
  List<String> medicaments; // Changed to List<String>

  Ordonnance({
    required this.idOrd,
    required this.nomMedcin,
    required this.datePrescription,
    required this.phoneMedcin,
    required this.specialiteOrd,
    required this.nomPatient,
    required this.photoOrdonnance,
    required this.medicaments,
  });

  factory Ordonnance.fromJson(Map<String, dynamic> json) {
    return Ordonnance(
      idOrd: json['idOrd'] ?? 0,
      nomMedcin: json['nomMedcin'] ?? '',
      datePrescription: DateTime.parse(json['datePrescription'] ?? ''),
      phoneMedcin: json['phoneMedcin'] ?? '',
      specialiteOrd: json['specialiteOrd'] ?? '',
      nomPatient: json['nomPatient'] ?? '',
      photoOrdonnance: json['photoOrdonnance'] ?? '',
      medicaments: List<String>.from(json['medicaments'] ?? []), // Adjusted here
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idOrd': idOrd,
      'nomMedcin': nomMedcin,
      'datePrescription': datePrescription.toIso8601String(),
      'phoneMedcin': phoneMedcin,
      'specialiteOrd': specialiteOrd,
      'nomPatient': nomPatient,
      'photoOrdonnance': photoOrdonnance,
      'medicaments': List<String>.from(medicaments), // Adjusted here
    };
  }
}