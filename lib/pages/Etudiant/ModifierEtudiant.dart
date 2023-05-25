import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class ModifierEtudiant extends StatefulWidget {
  @override
  _ModifierEtudiantState createState() => _ModifierEtudiantState();
}

class _ModifierEtudiantState extends State<ModifierEtudiant> {
  List<String> _items = [
    'Élément 1',
    'Élément 2',
    'Élément 3',
    'Élément 4',
    'Élément 5',
  ]; //TODO : supprimer cette liste et remplacer par un appel à la bd
  //TODO : désactiver le formulaire si la table classe est vide

  String? valueSelectedDropBtn;
  FocusScopeNode focusScopeNode = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();
  DateFormat formatter = DateFormat('dd-MM-yyyy');
  DateTime selectedDate = DateTime.now();

  bool noError = true;
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960, 1),
        lastDate: DateTime(2024));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.value = TextEditingValue(text: formatter.format(picked));
      });
  }


  TextEditingController matriculeController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController classeController = TextEditingController();
  TextEditingController moyMathController = TextEditingController();
  TextEditingController moyInfoController = TextEditingController();
  TextEditingController dateController = new TextEditingController();

  String matricule = '';
  String nom = '';
  String prenom = '';
  String classe = '';
  String anniv = "";
  late double moyMath;
  late double moyInfo;

  void clearChamps() {
    setState(() {
      matriculeController.clear();
      nomController.clear();
      prenomController.clear();
      dateController.value =
          TextEditingValue(text: "Choisir la date d'anniversaire");
      classeController.clear();
      moyMathController.clear();
      moyInfoController.clear();
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold();
  }
}

