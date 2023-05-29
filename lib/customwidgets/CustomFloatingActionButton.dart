
import 'package:flutter/material.dart';

class CustomFloatingActionButton{

  static void add(BuildContext context,Widget widget) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (height > width) {
      showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 9, bottom: 5),
                //height: 20,
                child: Center(
                    child: Container(
                      width: 70,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )),
              ),
              SizedBox(
                height: height * 0.8,
                child: widget,
              )
            ],
          );
        },
      );
    } else {
      debugPrint('desktop');
    }
  }
}
