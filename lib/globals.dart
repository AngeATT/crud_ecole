library mylibrary;

import 'package:crud_ecole/Db/DataBaseCrud.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final DataBaseCrud db = DataBaseCrud();

final fToast = FToast();

class globals{

  static void showToast(BuildContext context,String msg){

    return FToast().showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Theme.of(context).primaryColorLight,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check,
                  color: Theme.of(context).colorScheme.inverseSurface),
              const SizedBox(
                width: 12.0,
              ),
              Text(
                msg,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
            ],
          ),
        ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2)
    );
  }

  static void showCenterToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}


