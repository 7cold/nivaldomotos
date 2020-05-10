import 'package:flutter/material.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/contants.dart';
import 'package:nivaldomotos/constants/fonts.dart';
import 'package:nivaldomotos/models/user_model.dart';
import 'package:nivaldomotos/screens/atendimento_screen.dart';
import 'package:nivaldomotos/screens/index_screen.dart';
import 'package:nivaldomotos/screens/my_orders.dart';
import 'package:nivaldomotos/screens/user_edit.dart';
import 'package:nivaldomotos/widgets/button.dart';
import 'package:nivaldomotos/widgets/cart_icon.dart';
import 'package:nivaldomotos/widgets/loading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'cart_screen.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                child: CartIconWhite(),
              ),
            ),
          )
        ],
        title: Text(
          "MEU PERFIL",
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
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            return model.userData['nome'] == null
                ? Center(
                    child: LoadingWidget(),
                  )
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Olá, " +
                                model.userData['nome'].toString().toUpperCase(),
                            style: userTitleStyle,
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserEdit()));
                            },
                            child: Material(
                              elevation: 7,
                              borderRadius: borderAll,
                              shadowColor: Color(accentColor).withOpacity(0.22),
                              child: Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(primaryColor),
                                      Color(accentColor),
                                    ],
                                  ),
                                  borderRadius: borderAll,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, top: 20),
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: Image.asset(
                                            "assets/icons/user_info.png"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 20),
                                      child: Text(
                                        "Informações pessoais e endereço de entrega >",
                                        style: signUpSubTitleWhiteStyle,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyOrders()));
                            },
                            child: Material(
                              elevation: 7,
                              borderRadius: borderAll,
                              shadowColor: Color(accentColor).withOpacity(0.22),
                              child: Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(primaryColor),
                                      Color(accentColor),
                                    ],
                                  ),
                                  borderRadius: borderAll,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, top: 20),
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(11.0),
                                        child:
                                            Image.asset("assets/icons/box.png"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 20),
                                      child: Text(
                                        "Acompanhar meus Pedidos >",
                                        style: signUpSubTitleWhiteStyle,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AtendimentoScreen()));
                            },
                            child: Material(
                              elevation: 7,
                              borderRadius: borderAll,
                              shadowColor: Color(accentColor).withOpacity(0.22),
                              child: Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color(backgroundColorDark)
                                      .withOpacity(0.6),
                                  borderRadius: borderAll,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, top: 20),
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: Image.asset(
                                            "assets/icons/chat.png"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 20),
                                      child: Text(
                                        "Problemas? Não se preocupe, entre em contato conosco... >",
                                        style: signUpSubTitleWhiteStyle,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          ButtonFunction(
                              function: () async {
                                await model.signOut();

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => IndexScreen()));
                              },
                              text: "logout")
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
