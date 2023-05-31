import 'package:crud_ecole/models/Etudiant.dart';

class EtudiantFormatted {
  final String matricule;
  final String nom;
  final String prenom;
  final String dateAnniv;
  final int classeId;
  final double moyMath;
  final double moyInfo;
  final String classe;

  EtudiantFormatted(
      {required this.matricule,
      required this.nom,
      required this.prenom,
      required this.dateAnniv,
      required this.classeId,
      required this.moyMath,
      required this.moyInfo,
      required this.classe});

  Etudiant getEtudiant() {
    return Etudiant(
        matricule: matricule,
        nom: nom,
        prenom: prenom,
        dateAnniv: dateAnniv,
        classeId: classeId,
        moyMath: moyMath,
        moyInfo: moyInfo);
  }
}
