class Diagnostic {
  int idDiagnostic;
   String name;
   String description;
   DateTime dateDiagnostic;
   String medecin;
   String statut;
   String commentaires;
   String category;

  Diagnostic({
    required this.idDiagnostic,
    required this.name,
    required this.description,
    required this.dateDiagnostic,
    required this.medecin,
    required this.statut,
    required this.commentaires,
    required this.category,

  });


   factory Diagnostic.fromJson(Map<String, dynamic> json) {
    return Diagnostic(
      idDiagnostic: json['idDiagnostic'], // Utilisez une valeur par défaut appropriée
      name: json['name'] ?? '',
      dateDiagnostic: DateTime.parse(json['dateDiagnostic'] ?? ''),
      description: json['description'] ,
      medecin: json['medecin'] ,
      statut: json['statut'] ,
      commentaires: json['commentaires'] ,
      category: json['category'] ,
     
    );
  }
Map<String, dynamic> toJson() {
    return {
      'idDiagnostic': idDiagnostic,
      'name': name,
      'dateDiagnostic': dateDiagnostic.toIso8601String(), // Changer ici
      'description': description,
      'medecin': medecin,
      'commentaires': commentaires,
      'statut': statut,
      'category':category
    };
  }

  




}


