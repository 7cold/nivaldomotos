import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/fonts.dart';

class StatusPagamento extends StatefulWidget {
  final String payId;

  const StatusPagamento({Key key, this.payId}) : super(key: key);
  @override
  _StatusPagamentoState createState() => _StatusPagamentoState(payId);
}

class _StatusPagamentoState extends State<StatusPagamento> {
  final String payId;

  String _statusPay = "";
  String _typePay = "";
  String _typeFlag = "";
  String _cpfPayer = "";
  String _namePayer = "";
  String _last4 = "";
  String _dateApproved = "000000000000000000000000000000";
  List _refunds = [];
  String _dateRefunds = "000000000000000000000000000000";
  bool _carregando = true;

  _StatusPagamentoState(this.payId);

  initialMP() async {
    String url = "https://api.mercadopago.com/v1/payments/" +
        payId +
        "?access_token=APP_USR-4618697567453611-051814-a3a76e6bab50fbba6131c817383c1f61-38201203";
    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> res = jsonDecode(response.body);

    if (this.mounted) {
      setState(() {
        _statusPay = res['status'];
        _typePay = res['payment_type_id'];
        _typeFlag = res['payment_method_id'];
        _cpfPayer = res['card']['cardholder']['identification']['number'];
        _namePayer = res['card']['cardholder']['name'];
        _last4 = res['card']['last_four_digits'];
        _dateApproved = res['date_approved'];
        _refunds = res['refunds'];

        _refunds.forEach((result) {
          _dateRefunds = result['date_created'];
        });

        print(_dateRefunds);

        _carregando = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initialMP();

    String formatDia = _dateApproved.substring(8, 10);
    String formatMes = _dateApproved.substring(5, 7);
    String formatAno = _dateApproved.substring(0, 4);
    int formatHora = int.parse(_dateApproved.substring(11, 13));
    String formatMin = _dateApproved.substring(14, 16);
    int formatHoraNew = formatHora + 1;

    String formatDiaRef = _dateRefunds.substring(8, 10);
    String formatMesRef = _dateRefunds.substring(5, 7);
    String formatAnoRef = _dateRefunds.substring(0, 4);
    int formatHoraRef = int.parse(_dateRefunds.substring(11, 13));
    String formatMinRef = _dateRefunds.substring(14, 16);
    int formatHoraNewRef = formatHoraRef + 1;

    return Container(
      height: 350,
      child: Center(
        child: _carregando == true
            ? CupertinoActivityIndicator()
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Status",
                        style: detailTitleStyle,
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Text(
                            "Pagamento: ",
                            style: detailTextSubTitleStyle,
                          ),
                          _buildStatus(_statusPay),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Text(
                            "ID: ",
                            style: detailTextSubTitleStyle,
                          ),
                          Text(payId, style: detailSubTitleStyle),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            "Tipo: ",
                            style: detailTextSubTitleStyle,
                          ),
                          _buildType(_typePay),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            "Bandeira: ",
                            style: detailTextSubTitleStyle,
                          ),
                          _buildFlag(_typeFlag),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            "CPF Pagador: ",
                            style: detailTextSubTitleStyle,
                          ),
                          _buildCpfPayer(_cpfPayer),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            "Nome Cartão: ",
                            style: detailTextSubTitleStyle,
                          ),
                          _buildNamePayer(_namePayer),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            "Últimos 4 dig.: ",
                            style: detailTextSubTitleStyle,
                          ),
                          _buildLast4(_last4),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            "Aprovado em: ",
                            style: detailTextSubTitleStyle,
                          ),
                          _buildDateApproved(formatDia +
                              "/" +
                              formatMes +
                              "/" +
                              formatAno +
                              "-" +
                              formatHoraNew.toString() +
                              ":" +
                              formatMin),
                        ],
                      ),
                      SizedBox(height: 10),
                      _statusPay == "refunded"
                          ? Row(
                              children: <Widget>[
                                Text(
                                  "Devolvido em: ",
                                  style: detailTextSubTitleStyle,
                                ),
                                _buildDateRefunds(formatDiaRef +
                                    "/" +
                                    formatMesRef +
                                    "/" +
                                    formatAnoRef +
                                    "-" +
                                    formatHoraNewRef.toString() +
                                    ":" +
                                    formatMinRef),
                              ],
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  _buildDateRefunds(String dateRefunds) {
    return Text(dateRefunds, style: detailSubTitleStyle);
  }

  _buildDateApproved(String dateApproved) {
    return Text(dateApproved, style: detailSubTitleStyle);
  }

  _buildLast4(String last4) {
    return Text(last4, style: detailSubTitleStyle);
  }

  _buildNamePayer(String namePayer) {
    return Text(namePayer, style: detailSubTitleStyle);
  }

  _buildCpfPayer(String cpfPayer) {
    return Text(cpfPayer, style: detailSubTitleStyle);
  }

  _buildFlag(String typeFlag) {
    return Text(
        typeFlag == "visa"
            ? "Visa"
            : typeFlag == "master"
                ? "Master"
                : typeFlag == "elo" ? "Elo" : "Outro",
        style: detailSubTitleStyle);
  }

  _buildType(String typePay) {
    return Text(
        typePay == "credit_card"
            ? "Cartão de Crédito"
            : typePay == "debit_card"
                ? "Cartão de Débito"
                : typePay == "ticket" ? "Boleto" : "Outro",
        style: detailSubTitleStyle);
  }

  _buildStatus(String statusPay) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
          color: statusPay == "refunded"
              ? Color(payRed)
              : statusPay == "rejected"
                  ? Color(payRed)
                  : statusPay == "cancelled"
                      ? Color(payRed)
                      : statusPay == "pending"
                          ? Color(payYellow)
                          : statusPay == "in_process"
                              ? Color(payYellow)
                              : statusPay == "authorized"
                                  ? Color(payBlue)
                                  : statusPay == "approved"
                                      ? Color(payGreen)
                                      : statusPay == "partially_refunded"
                                          ? Color(payRed)
                                          : statusPay == "charged_back"
                                              ? Color(payRed)
                                              : statusPay == "vacated"
                                                  ? Color(payRed)
                                                  : statusPay ==
                                                          "Payment not found"
                                                      ? Color(payYellow)
                                                      : statusPay == "Not Found"
                                                          ? Color(payYellow)
                                                          : "",
          borderRadius: BorderRadius.circular(6)),
      child: Center(
        child: Text(
          statusPay == "refunded"
              ? "Devolvido"
              : statusPay == "rejected"
                  ? "Rejeitado"
                  : statusPay == "cancelled"
                      ? "Cancelado"
                      : statusPay == "pending"
                          ? "Pendente"
                          : statusPay == "in_process"
                              ? "Em Processo"
                              : statusPay == "authorized"
                                  ? "Autorizado"
                                  : statusPay == "approved"
                                      ? "Aprovado"
                                      : statusPay == "partially_refunded"
                                          ? "Parcialmente Retornado"
                                          : statusPay == "charged_back"
                                              ? "Parcialmente Estornado"
                                              : statusPay == "vacated"
                                                  ? "Erro Inesperado"
                                                  : statusPay ==
                                                          "Payment not found"
                                                      ? "Não Pago"
                                                      : statusPay == "Not Found"
                                                          ? "Não Encontrado"
                                                          : "",
          style: payStatus,
        ),
      ),
    );
  }
}
