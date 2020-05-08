import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/models/user_model.dart';
import 'package:nivaldomotos/screens/home_screen.dart';
import 'package:nivaldomotos/screens/login_screen.dart';
import 'package:nivaldomotos/widgets/button.dart';
import 'package:nivaldomotos/widgets/loading.dart';
import 'package:nivaldomotos/widgets/text_form_field.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpFinal extends StatefulWidget {
  final cpf;

  SignUpFinal(this.cpf);

  @override
  _SignUpFinalState createState() => _SignUpFinalState();
}

class _SignUpFinalState extends State<SignUpFinal> {
  String cpf;
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _endnumeroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _bairroController = TextEditingController();
  var _celularController = MaskedTextController(mask: '(00) 00000-0000');
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    cpf = widget.cpf;
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      key: _scaffoldKey,
      body: SafeArea(
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading) {
              return Center(
                child: LoadingWidget(),
              );
            }
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 10, top: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Olá ',
                            style: signUpSubTitleStyle,
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${_nomeController.text}, ',
                                  style: signUpTitleStyle),
                              TextSpan(
                                  text:
                                      'seja bem vindx e termine seu cadastro!'),
                            ],
                          ),
                        )),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          TextInput(
                            onChanged: (text) {
                              setState(() {
                                text = _nomeController;
                              });
                            },
                            controller: _nomeController,
                            validator: (text) {
                              if (text.isEmpty) {
                                return "Preencha para continuar";
                              }
                            },
                            keyboardType: TextInputType.text,
                            hintText: "Nome",
                            icon: FontAwesomeIcons.user,
                            textStyle: inputStyle,
                            obscure: false,
                            textCapitalization: TextCapitalization.words,
                            border: false,
                          ),
                          SizedBox(height: 8),
                          TextInput(
                            controller: _sobrenomeController,
                            validator: (text) {
                              if (text.isEmpty) {
                                return "Preencha para continuar";
                              }
                            },
                            keyboardType: TextInputType.text,
                            hintText: "Sobrenome",
                            icon: FontAwesomeIcons.user,
                            textStyle: inputStyle,
                            obscure: false,
                            textCapitalization: TextCapitalization.words,
                            border: false,
                          ),
                          SizedBox(height: 8),
                          TextInput(
                            controller: _celularController,
                            validator: (text) {
                              if (text.isEmpty) {
                                return "Preencha para continuar";
                              }
                            },
                            keyboardType: TextInputType.number,
                            hintText: "Celular",
                            icon: FontAwesomeIcons.mobile,
                            textStyle: inputStyle,
                            obscure: false,
                            textCapitalization: TextCapitalization.words,
                            border: false,
                          ),
                          SizedBox(height: 8),
                          TextInput(
                            controller: _emailController,
                            validator: (text) {
                              if (text.isEmpty || !text.contains("@")) {
                                return "Preencha para continuar";
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Email",
                            icon: FontAwesomeIcons.envelope,
                            textStyle: inputStyle,
                            obscure: false,
                            textCapitalization: TextCapitalization.none,
                            border: false,
                          ),
                          SizedBox(height: 8),
                          TextInput(
                            controller: _passController,
                            validator: (text) {
                              if (text.isEmpty || text.length < 6) {
                                return "Preencha para continuar";
                              }
                            },
                            keyboardType: TextInputType.number,
                            hintText: "Senha",
                            icon: FontAwesomeIcons.lock,
                            textStyle: inputStyle,
                            obscure: true,
                            textCapitalization: TextCapitalization.words,
                            border: false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Color(accentColor).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            child: Text("Dados para entrega",
                                style: signUpSubTitleStyle),
                          ),
                          TextInput(
                            controller: _enderecoController,
                            validator: (text) {
                              if (text.isEmpty) {
                                return "Preencha para continuar";
                              }
                            },
                            keyboardType: TextInputType.text,
                            hintText: "Endereço",
                            icon: FontAwesomeIcons.shippingFast,
                            textStyle: inputStyle,
                            obscure: false,
                            textCapitalization: TextCapitalization.words,
                            border: false,
                          ),
                          SizedBox(height: 8),
                          TextInput(
                            controller: _endnumeroController,
                            validator: (text) {
                              if (text.isEmpty) {
                                return "Preencha para continuar";
                              }
                            },
                            keyboardType: TextInputType.number,
                            hintText: "Número",
                            icon: FontAwesomeIcons.shippingFast,
                            textStyle: inputStyle,
                            obscure: false,
                            textCapitalization: TextCapitalization.words,
                            border: false,
                          ),
                          SizedBox(height: 8),
                          TextInput(
                            controller: _cidadeController,
                            validator: (text) {
                              if (text.isEmpty) {
                                return "Preencha para continuar";
                              }
                            },
                            keyboardType: TextInputType.text,
                            hintText: "Cidade",
                            icon: FontAwesomeIcons.city,
                            textStyle: inputStyle,
                            obscure: false,
                            textCapitalization: TextCapitalization.words,
                            border: false,
                          ),
                          SizedBox(height: 8),
                          TextInput(
                            controller: _bairroController,
                            validator: (text) {
                              if (text.isEmpty) {
                                return "Preencha para continuar";
                              }
                            },
                            keyboardType: TextInputType.text,
                            hintText: "Bairro",
                            icon: FontAwesomeIcons.map,
                            textStyle: inputStyle,
                            obscure: false,
                            textCapitalization: TextCapitalization.words,
                            border: false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ButtonFunction(
                        function: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if (_formKey.currentState.validate()) {
                            Map<String, dynamic> userData = {
                              "cpf": cpf,
                              "nome": _nomeController.text,
                              "sobrenome": _sobrenomeController.text,
                              "celular": _celularController.text,
                              "email": _emailController.text,
                              "endereco": _enderecoController.text,
                              "end_numero": _endnumeroController.text,
                              "cidade": _cidadeController.text,
                              "bairro": _bairroController.text,
                            };

                            model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSucess: _onSuccess,
                              onFail: _onFail,
                            );
                          }
                        },
                        text: "Cadastrar"),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onSuccess() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (contetex) => HomeScreen()));
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha ao criar o usuario"),
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }
}
