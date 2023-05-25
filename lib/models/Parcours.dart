class Parcours {
  final int id;
  final String libelleParcour;

  Parcours({required this.id, required this.libelleParcour});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'libelleParcour': libelleParcour
    };
  }
}