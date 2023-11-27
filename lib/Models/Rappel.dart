

class MedicamentRappel {
  int id;
  String nom;
	 DateTime heureRappel;
   int dureeTraitementEnJours;
   int color;
    int isCompleted;
   


  MedicamentRappel({
    required this.id,
    required this.nom,
    required this.heureRappel,
     required this.dureeTraitementEnJours,
     required this.color,
     required this.isCompleted
  
     

  });

  factory MedicamentRappel.fromJson(Map<String, dynamic> json) {
    return MedicamentRappel(
      id: json['id'],
      nom: json['nom'],
     heureRappel: parseDate(json['heureRappel']),
       dureeTraitementEnJours: json['dureeTraitementEnJours'],
        color: json['color'],
        isCompleted: json['isCompleted'],
       
    );
  }
  @override
  String toString() {
    return nom; // or any other property you want to display
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
     
      'heureRappel': heureRappel.toUtc().toIso8601String(),
      'dureeTraitementEnJours':dureeTraitementEnJours,
        'color':color,
        'isCompleted':isCompleted
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
