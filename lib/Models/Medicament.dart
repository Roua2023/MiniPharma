
class Medicament {
  int id;
  String nomMed;
  String? photo;
   int quantite;
	 double prix;
	 String forme;
   String posologie;
	 String type;
	 DateTime dateDebut;
	 DateTime dateExp;
   String dureeTraitement;
   String noteMed;
   


  Medicament({
    required this.id,
    required this.nomMed,
    required this.photo,
  required this.quantite,
	  required this.prix,
	 required this.forme,
    required this.posologie,
	 required this.type,
	  required this.dateDebut,
	  required this.dateExp,
     required this.dureeTraitement,
      required this.noteMed,
     

  });

  factory Medicament.fromJson(Map<String, dynamic> json) {
    return Medicament(
      id: json['id'],
      nomMed: json['nomMed'],
      photo: json['photo'] ?? null,
       quantite: json['quantite'],
        prix: json['prix'],
         forme: json['forme'],
        posologie: json['posologie'], 
        type: json['type'],
        dateDebut: parseDate(json['dateDebut']),
         dateExp: parseDate(json['dateExp']),
         dureeTraitement: json['dureeTraitement'],
          noteMed: json['noteMed'],
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
      'quantite':quantite,
        'prix':prix,
         'forme': forme,
        'posologie': posologie, 
        'type': type,
        'dateDebut': dateDebut.toIso8601String(),
        'dateExp':dateExp.toIso8601String(),
        'dureeTraitement': dureeTraitement,
          'noteMed':noteMed,
    };
  }
   static DateTime parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print('Erreur lors de la conversion de la date: $e');
      return DateTime.now();
    }
  }
}
