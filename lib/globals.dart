library mylibrary;

import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'dart:async';

final StreamController<String> streamController =
    StreamController<String>.broadcast();
final DataBaseCrud db = DataBaseCrud();
