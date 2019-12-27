import 'package:flutter/material.dart';

import 'loading.widget.dart';

class Success extends StatelessWidget {
  var result = "";
  Function func;

  Success({
    @required this.result,
    @required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Text(
            result,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 40,
              fontFamily: "Big Shoulders Display",
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          LoadingButton(
            busy: false,
            func: func,
            invert: true,
            text: "Calcular Novamente",
          ),
        ],
      ),
    );
  }
}
