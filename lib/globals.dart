library mylibrary;

import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'dart:async';

import 'package:crud_ecole/StreamMessage.dart';

final StreamController<StreamMessage> streamController =
    StreamController<StreamMessage>.broadcast();
final DataBaseCrud db = DataBaseCrud();
