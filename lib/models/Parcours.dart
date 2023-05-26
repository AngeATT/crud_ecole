class Parcours {
  final int id;
  final String libelle;

  Parcours({required this.id, required this.libelle});

  Map<String, dynamic> toMap() {
    return {'id': id, 'libelle': libelle};
  }

  Map<String, dynamic> toLibelleMap() {
    return {'libelle': libelle};
  }
}
