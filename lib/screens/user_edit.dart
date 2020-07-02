import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/contants.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/models/user_model.dart';
import 'package:nivaldomotos/widgets/button.dart';
import 'package:nivaldomotos/widgets/text_form_field.dart';
import 'package:scoped_model/scoped_model.dart';

class UserEdit extends StatefulWidget {
  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  TextEditingController _controllerEndereco = TextEditingController();
  TextEditingController _controllerEndNumero = TextEditingController();
  TextEditingController _controllerBairro = TextEditingController();
  TextEditingController _controllerCidade = TextEditingController();
  var _controllerCelular = MaskedTextController(mask: '(00) 00000-0000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      appBar: AppBar(
        title: Text(
          "MEUS DADOS",
          style: TextStyle(
              fontFamily: fontExtraBold,
              fontSize: 24,
              color: Color(accentColor)),
        ),
        centerTitle: true,
        backgroundColor: Color(backgroundColorDark),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              var _nome = model.userData['nome'];
              var _sobrenomenome = model.userData['sobrenome'];
              var _cpf = model.userData['cpf'];
              var _email = model.userData['email'];

              _controllerEndereco.text = model.userData['endereco'];
              _controllerCelular.text = model.userData['celular'];
              _controllerEndNumero.text = model.userData['end_numero'];
              _controllerBairro.text = model.userData['bairro'];
              _controllerCidade.text = model.userData['cidade'];
              return Container(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text(
                          model.userData['nome'] +
                              " " +
                              model.userData['sobrenome'],
                          style: userTitleStyle,
                        ),
                        Text(
                          model.userData['email'],
                          style: userSubTitleStyle,
                        ),
                        Text(
                          "CPF: " + model.userData['cpf'],
                          style: userSubTitleStyle,
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: TextInput(
                              controller: _controllerCelular,
                              validator: null,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.words,
                              hintText: "Celular",
                              icon: FontAwesomeIcons.mobile,
                              textStyle: inputStyle,
                              obscure: false,
                              border: false),
                        ),
                        Divider()
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Material(
                        elevation: 7,
                        shadowColor: Color(accentColor).withOpacity(0.22),
                        borderRadius: borderAll,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: borderAll,
                            color: Colors.white,
                          ),
                          child: Form(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 20, top: 20),
                                    child: Text(
                                      "Endereço de entrega",
                                      style: signUpSubTitleStyle,
                                    ),
                                  ),
                                  TextInput(
                                      controller: _controllerEndereco,
                                      validator: null,
                                      keyboardType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      hintText: "Endereço",
                                      icon: FontAwesomeIcons.home,
                                      textStyle: inputStyle,
                                      obscure: false,
                                      border: false),
                                  SizedBox(height: 15),
                                  TextInput(
                                      controller: _controllerEndNumero,
                                      validator: null,
                                      keyboardType: TextInputType.number,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      hintText: "Número",
                                      icon: FontAwesomeIcons.mapMarkedAlt,
                                      textStyle: inputStyle,
                                      obscure: false,
                                      border: false),
                                  SizedBox(height: 15),
                                  TextInput(
                                      controller: _controllerBairro,
                                      validator: null,
                                      keyboardType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      hintText: "Bairro",
                                      icon: FontAwesomeIcons.map,
                                      textStyle: inputStyle,
                                      obscure: false,
                                      border: false),
                                  SizedBox(height: 15),
                                  TextInput(
                                      controller: _controllerCidade,
                                      validator: null,
                                      keyboardType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      hintText: "Cidade",
                                      icon: FontAwesomeIcons.city,
                                      textStyle: inputStyle,
                                      obscure: false,
                                      border: false),
                                  SizedBox(height: 15),
                                  Center(
                                    child: ButtonFunction(
                                        function: () {
                                          model.editUser(
                                              userData: {
                                                "nome": _nome,
                                                "cpf": _cpf,
                                                "sobrenome": _sobrenomenome,
                                                "email": _email,
                                                "celular":
                                                    _controllerCelular.text,
                                                "endereco":
                                                    _controllerEndereco.text,
                                                "end_numero":
                                                    _controllerEndNumero.text,
                                                "bairro":
                                                    _controllerBairro.text,
                                                "cidade":
                                                    _controllerCidade.text,
                                              },
                                              onSucess: _onSuccess,
                                              onFail: _onFail,
                                              context: context);
                                        },
                                        text: "salvar"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onSuccess() {
    Future.delayed(Duration(milliseconds: 1150)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    Future.delayed(Duration(milliseconds: 250)).then((_) {
      Navigator.of(context).pop();
    });
  }
}
