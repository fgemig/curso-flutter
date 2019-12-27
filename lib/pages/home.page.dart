import 'package:etanol_gasolina/widgets/input.widget.dart';
import 'package:etanol_gasolina/widgets/loading.widget.dart';
import 'package:etanol_gasolina/widgets/logo.widget.dart';
import 'package:etanol_gasolina/widgets/success.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = Colors.deepPurple;

  var _gasCtrl = new MoneyMaskedTextController();
  var _etaCtrl = new MoneyMaskedTextController();
  var _busy = false;
  var _completed = false;
  var _resultText = "Compensa utilizar Etanol";

  Future calculate() {
    double etanol =
        double.parse(_etaCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;
    double gasoline =
        double.parse(_gasCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;

    double res = etanol / gasoline;

    setState(() {
      _color = Colors.purpleAccent;
      _completed = false;
      _busy = true;
    });

    return new Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (res >= 0.7) {
          _resultText = "Compensa utilizar Gasolina!";
        } else {
          _resultText = "Compensa utilizar Etanol!";
        }

        _busy = false;
        _completed = true;
      });
    });
  }

  reset() {
    setState(() {
      _gasCtrl.text = "0.00";
      _etaCtrl.text = "0.00";
      _busy = false;
      _completed = false;
      _resultText = "";
      _color = Colors.deepPurple;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AnimatedContainer(
          duration: Duration(
            milliseconds: 1200,
          ),
          color: _color,
          child: ListView(
            children: <Widget>[
              Logo(),
              Visibility(
                visible: _completed,
                child: Success(
                  result: _resultText,
                  func: reset,
                ),
              ),
              Visibility(
                visible: !_completed,
                child: Column(
                  children: <Widget>[
                    Input(
                      ctrl: _gasCtrl,
                      label: "Gasolina",
                    ),
                    Input(
                      ctrl: _etaCtrl,
                      label: "Etanol",
                    ),
                    LoadingButton(
                      busy: _busy,
                      func: calculate,
                      invert: false,
                      text: "Calcular",
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
