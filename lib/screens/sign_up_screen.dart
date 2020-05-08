import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/screens/sign_up_final.dart';
import 'package:nivaldomotos/widgets/button.dart';
import 'package:nivaldomotos/widgets/text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _cpfController = MaskedTextController(mask: '000.000.000-00');

  _nextPage() async {
    if (_cpfController.text == "" || _cpfController.text.length < 14) {
      _erroAlert(context);
      await new Future.delayed(const Duration(milliseconds: 2350));
      Navigator.pop(context);
    } else {
      _okAlert(context);
      await new Future.delayed(const Duration(milliseconds: 2100));
      Navigator.pop(context);
      var route = new MaterialPageRoute(
        builder: (BuildContext context) => new SignUpFinal(_cpfController.text),
      );
      Navigator.of(context).push(route);
    }
  }

  _okAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        height: 200,
        child: FlareActor(
          "assets/animators/success.flr",
          animation: "Untitled",
          fit: BoxFit.contain,
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _erroAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Erro ao entar com CPF",
            style: TextStyle(
              fontFamily: fontExtraBold,
              fontSize: 20,
              color: Color(backgroundColor),
            ),
          ),
          Container(
            height: 200,
            child: FlareActor(
              "assets/animators/error.flr",
              animation: "Untitled",
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool cpfPreenchido = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 340,
                    margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Color(cpfPreenchido == false
                                ? backgroundColorDark
                                : primaryColor)
                            .withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 10,
                          child: Container(
                            height: MediaQuery.of(context).size.width / 1.8,
                            width: MediaQuery.of(context).size.width,
                            child: FlareActor(
                              "assets/animators/register.flr",
                              animation: "animation",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Entre com seu cpf para continuar o registro em nosso app...",
                            style: signUpSubTitleWhiteStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextInput(
                      onChanged: (text) {
                        text.length >= 14
                            ? setState(() {
                                cpfPreenchido = true;
                              })
                            : setState(() {
                                cpfPreenchido = false;
                              });
                      },
                      controller: _cpfController,
                      hintText: "CPF",
                      border: false,
                      icon: FontAwesomeIcons.idCard,
                      obscure: false,
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      textStyle: inputStyle,
                      validator: null,
                      onSubmited: null,
                    ),
                  ),
                  SizedBox(height: 40),
                  ButtonFunction(function: _nextPage, text: "Continuar"),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
