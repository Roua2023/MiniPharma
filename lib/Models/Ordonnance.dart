import 'Medicament.dart';

class Ordonnance {
  int idOrd;
  String nomMedcin;
  DateTime datePrescription; // Utiliser DateTime au lieu de Date
  String phoneMedcin;
  String specialiteOrd;
  String nomPatient;
  String photoOrdonnance;
  List<Medicament> medicaments;

  Ordonnance({
    required this.idOrd,
    required this.nomMedcin,
    required this.datePrescription, // Changer ici
    required this.phoneMedcin,
    required this.specialiteOrd,
    required this.nomPatient,
    required this.photoOrdonnance,
    required this.medicaments,
  });


  factory Ordonnance.fromJson(Map<String, dynamic> json) {
    return Ordonnance(
      idOrd: json['idOrd'], // Utilisez une valeur par défaut appropriée
      nomMedcin: json['nomMedcin'] ?? '',
      datePrescription: DateTime.parse(json['datePrescription'] ?? ''),
      phoneMedcin: json['phoneMedcin'] ?? '',
      specialiteOrd: json['specialiteOrd'] ?? '',
      nomPatient: json['nomPatient'] ?? '',
      photoOrdonnance: json['photoOrdonnance'] ?? '',
      medicaments: (json['medicaments'] as List<dynamic>?)
          ?.map((i) => Medicament.fromJson(i))
          .toList() ??
          [], // Liste vide comme valeur par défaut
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'idOrd': idOrd,
      'nomMedcin': nomMedcin,
      'datePrescription': datePrescription.toIso8601String(), // Changer ici
      'phoneMedcin': phoneMedcin,
      'specialiteOrd': specialiteOrd,
      'nomPatient': nomPatient,
      'photoOrdonnance': photoOrdonnance,
      'medicaments': medicaments.map((med) => med.toJson()).toList(),
    };
  }
}
