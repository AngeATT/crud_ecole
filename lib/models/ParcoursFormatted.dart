import 'package:crud_ecole/models/Parcours.dart';

class ParcoursFormatted {
  final int id;
  final String libelle;
  final int effectif;

  ParcoursFormatted(
      {required this.id, required this.libelle, required this.effectif});

  Parcours getParcours() {
    return Parcours(id: id, libelle: libelle);
  }
}
