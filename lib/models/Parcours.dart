class Parcours {
  final int id;
  final String libelle;

  Parcours({required this.id, required this.libelle});

  Map<String, dynamic> toMap() {
    return {'libelle': libelle};
  }
}
