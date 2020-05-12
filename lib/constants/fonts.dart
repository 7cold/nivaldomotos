//Font
import 'package:flutter/material.dart';
import 'package:nivaldomotos/constants/colors.dart';

const String fontExtraBold = "PoppinsExtraBold"; //titulos
const String fontBold = "PoppinsBold"; //botoes
const String fontSemiBold = "PoppinsSemiBold";
const String fontMedium = "PoppinsMedium";
const String fontReg = "PoppinsRegular"; //textos
const String fontLight = "PoppinsLight";

// ---------------------------System-----------------------------------------
// --------------------------------------------------------------------------
TextStyle buttonStyle =
    TextStyle(fontFamily: fontBold, color: Colors.white, fontSize: 16);

TextStyle circleProductsLenghtStyle = TextStyle(
    fontFamily: fontBold, color: Color(backgroundColorDark), fontSize: 14);

TextStyle buttonSecondStyle =
    TextStyle(fontFamily: fontBold, color: Color(primaryColor), fontSize: 16);

TextStyle inputStyle = TextStyle(
    fontFamily: fontSemiBold,
    color: Color(backgroundColorDark).withAlpha(210),
    fontSize: 16);

// ---------------------------Category-----------------------------------------
// --------------------------------------------------------------------------
TextStyle categoryStyle = TextStyle(
    fontFamily: fontSemiBold, color: Color(backgroundColorDark), fontSize: 12);

TextStyle categorySubStyle = TextStyle(
    fontFamily: fontMedium, color: Color(secondaryColor), fontSize: 14);

// ---------------------------Card-----------------------------------------
// --------------------------------------------------------------------------
TextStyle cardTextStyle = TextStyle(
    fontFamily: fontSemiBold, color: Color(backgroundColorDark), fontSize: 15);

TextStyle cardPriceStyle = TextStyle(
    fontFamily: fontExtraBold, color: Color(backgroundColorDark), fontSize: 16);

TextStyle cardPricePromoStyle = TextStyle(
    fontFamily: fontExtraBold, color: Color(primaryColor), fontSize: 16);

// ---------------------------Detail-----------------------------------------
// --------------------------------------------------------------------------
TextStyle detailTitleStyle = TextStyle(
    fontFamily: fontBold, color: Color(backgroundColorDark), fontSize: 20);

TextStyle detailPriceStyle = TextStyle(
    fontFamily: fontExtraBold, color: Color(secondaryColor), fontSize: 20);

TextStyle detailSubTitleStyle = TextStyle(
    fontFamily: fontBold, color: Color(backgroundColorDark), fontSize: 16);

TextStyle detailTextSubTitleStyle = TextStyle(
    fontFamily: fontLight, color: Color(backgroundColorDark), fontSize: 16);

// ---------------------------Detail-----------------------------------------
// --------------------------------------------------------------------------

TextStyle cartTitleStyle = TextStyle(
    fontFamily: fontBold, color: Color(backgroundColorDark), fontSize: 16);

TextStyle cartSubTitleStyle = TextStyle(
    fontFamily: fontLight, color: Color(backgroundColorDark), fontSize: 16);

// ---------------------------perfil-----------------------------------------
// --------------------------------------------------------------------------

TextStyle userTitleStyle = TextStyle(
    fontFamily: fontExtraBold, color: Color(backgroundColorDark), fontSize: 26);

TextStyle userSubTitleStyle = TextStyle(
    fontFamily: fontLight, color: Color(backgroundColorDark), fontSize: 18);

TextStyle userStyle = TextStyle(
    fontFamily: fontMedium, color: Color(backgroundColorDark), fontSize: 18);

TextStyle userSubMenuStyle = TextStyle(
    fontFamily: fontExtraBold, color: Color(backgroundColorDark), fontSize: 18);

// ---------------------------Home-----------------------------------------
// --------------------------------------------------------------------------

TextStyle titleHomeStyle = TextStyle(
    fontFamily: fontExtraBold, color: Color(backgroundColorDark), fontSize: 22);
// ---------------------------Category-----------------------------------------
// --------------------------------------------------------------------------

TextStyle categoryTitleStyle = TextStyle(
    fontFamily: fontReg, color: Color(backgroundColorDark), fontSize: 18);

// ---------------------------Orders-----------------------------------------
// --------------------------------------------------------------------------

TextStyle orderTitleStyle = TextStyle(
    fontFamily: fontExtraBold, color: Color(backgroundColorDark), fontSize: 14);

TextStyle orderTitle2Style = TextStyle(
    fontFamily: fontExtraBold, color: Color(backgroundColorDark), fontSize: 18);

TextStyle ordersubTitleStyle = TextStyle(
    fontFamily: fontMedium, color: Color(backgroundColorDark), fontSize: 14);

TextStyle orderTextStyle = TextStyle(
    fontFamily: fontLight, color: Color(backgroundColorDark), fontSize: 14);

TextStyle orderText2Style = TextStyle(
    fontFamily: fontReg, color: Color(backgroundColorDark), fontSize: 16);

TextStyle orderNumberCircleStyle = TextStyle(
    fontFamily: fontExtraBold, color: Color(backgroundColor), fontSize: 14);

TextStyle orderSuccessStyle = TextStyle(
    fontFamily: fontExtraBold, color: Color(successColor), fontSize: 18);

// ---------------------------signup-----------------------------------------
// --------------------------------------------------------------------------

TextStyle signUpSubTitleStyle = TextStyle(
    fontFamily: fontExtraBold, color: Color(backgroundColorDark), fontSize: 20);

TextStyle signUpSubTitleWhiteStyle =
    TextStyle(fontFamily: fontExtraBold, color: Colors.white, fontSize: 20);

TextStyle signUpTitleStyle = TextStyle(
    fontFamily: fontExtraBold, color: Color(secondaryColor), fontSize: 24);

TextStyle signUpErrorStyle =
    TextStyle(fontFamily: fontSemiBold, color: Color(failColor), fontSize: 12);

// ---------------------------atendimento-----------------------------------------
// --------------------------------------------------------------------------

TextStyle textAtendimento = TextStyle(
    fontFamily: fontExtraBold, color: Color(backgroundColorDark), fontSize: 24);

TextStyle subTextAtendimento = TextStyle(
    fontFamily: fontReg,
    color: Color(backgroundColorDark).withOpacity(0.65),
    fontSize: 20);
TextStyle subText2Atendimento = TextStyle(
    fontFamily: fontReg,
    color: Color(backgroundColorDark).withOpacity(0.65),
    fontSize: 16);
