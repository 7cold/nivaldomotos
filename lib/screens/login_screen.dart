import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/models/user_model.dart';
import 'package:nivaldomotos/screens/home_screen.dart';
import 'package:nivaldomotos/screens/sign_up_screen.dart';
import 'package:nivaldomotos/widgets/button.dart';
import 'package:nivaldomotos/widgets/loading.dart';
import 'package:nivaldomotos/widgets/text_form_field.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Timer _timer;

  showAlertDialog(BuildContext c) {
    showDialog(
        context: c,
        builder: (c) {
          Future.delayed(Duration(milliseconds: 400), () {
            Navigator.of(c).pop(true);
          });
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Center(
              child: LoadingWidget(),
            ),
          );
        });
  }

  _LoginScreenState() {
    _timer = new Timer(const Duration(milliseconds: 0), () {
      setState(() {
        Future.delayed(Duration.zero, () => showAlertDialog(context));
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(backgroundColor),
        key: _scaffoldKey,
        body: SafeArea(
          child: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              if (model.isLoading)
                return Center(
                  child: LoadingWidget(),
                );
              return Form(
                key: _formKey,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(left: 25, right: 25),
                  children: <Widget>[
                    SizedBox(height: 20),
                    Image.asset(
                      "assets/images/logo_sign.png",
                      scale: 3.5,
                    ),
                    SizedBox(height: 20),
                    TextInput(
                      textCapitalization: TextCapitalization.none,
                      border: false,
                      obscure: false,
                      textStyle: inputStyle,
                      controller: _emailController,
                      validator: (text) {
                        if (text.isEmpty || !text.contains("@"))
                          return "E-mail inválido!";
                      },
                      hintText: "Email",
                      icon: FontAwesomeIcons.envelope,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                    TextInput(
                      textCapitalization: TextCapitalization.none,
                      border: false,
                      obscure: true,
                      controller: _passController,
                      textStyle: inputStyle,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6)
                          return "Senha inválida!";
                      },
                      hintText: "Senha",
                      icon: FontAwesomeIcons.lock,
                      keyboardType: TextInputType.number,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          if (_emailController.text.isEmpty)
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content:
                                  Text("Insira seu e-mail para recuperação!"),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 2),
                            ));
                          else {
                            model.recoverPass(_emailController.text);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Confira seu e-mail!"),
                              backgroundColor: Theme.of(context).primaryColor,
                              duration: Duration(seconds: 2),
                            ));
                          }
                        },
                        child: Text(
                          "Esqueci minha senha!",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: fontReg,
                              color: Color(backgroundColorDark),
                              fontSize: 14),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    SizedBox(height: 20),
                    ButtonFunction(
                        text: "Login",
                        function: () {
                          if (_formKey.currentState.validate()) {}
                          model.signIn(
                            email: _emailController.text,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail,
                          );
                        }),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Se ainda não é cliente, ',
                            style: TextStyle(
                              fontFamily: fontMedium,
                              color: Color(backgroundColorDark),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'CLIQUE AQUI!',
                                style: TextStyle(
                                  fontFamily: fontBold,
                                  color: Color(secondaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }

  void _onSuccess() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao Entrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
