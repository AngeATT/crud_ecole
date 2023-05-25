class Eleve {
  final String matricule;
  final String nom;
  final String prenom;
  final String dateAnniv;
  final double moyMath;
  final double moyInfo;
  final int classeId;

  Eleve({
    required this.matricule,
    required this.nom,
    required this.prenom,
    required this.dateAnniv,
    required this.moyMath,
    required this.moyInfo,
    required this.classeId});

  Map<String, dynamic> toMap() {
    return {
      'matricule': matricule,
      'nom': nom,
      'prenom': prenom,
      'dateAnniv': dateAnniv,
      'moyMath': moyMath,
      'moyInfo': moyInfo,
      'classeId': classeId,
    };
  }
}