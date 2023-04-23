import 'package:country_code_picker/src/iso3_currency_codes_lookup.dart';
import 'package:flutter/material.dart';

import 'country_codes.dart';
import 'country_localizations.dart';

mixin ToAlias {}

/// Country element. This is the element that contains all the information
class CountryCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String? flagUri;

  /// the country code (IT,AF..)
  final String iso2CountryCode;

  /// the international dial code (+39,+93, +237, ..)
  final String dialCode;

  /// the regex to validate the local phone number of the country
  /// if not provided, defaults to "0?[1-9][0-9]{6,15]"
  final String? mobileRegex;

  /// This is the  currency symbol eg $, ₦
  final String? currencySymbol;

  /// This is the iso3 currency code eg USD, XAF, NGN
  final String? iso3CurrencyCode;

  CountryCode(
      {required this.name,
      this.flagUri,
      required this.iso2CountryCode,
      required this.dialCode,
      this.mobileRegex = "0?[1-9][0-9]{6,15]",
      this.iso3CurrencyCode,
      this.currencySymbol});

  factory CountryCode.fromCountryCode(String countryCode) {
    countryCode = countryCode.trim().toUpperCase();
    final Map<String, String> jsonCode = countryCodes.firstWhere(
      (code) => code['iso2CountryCode'] == countryCode,
    );
    return CountryCode.fromJson(jsonCode);
  }

  factory CountryCode.fromDialCode(String dialCode) {
    final Map<String, String> jsonCode = countryCodes.firstWhere(
      (code) => code['dialCode'] == dialCode,
    );
    return CountryCode.fromJson(jsonCode);
  }

  CountryCode localize(BuildContext context) {
    return this
      ..name =
          CountryLocalizations.of(context)?.translate(iso2CountryCode) ?? name;
  }

  factory CountryCode.fromJson(Map<String, dynamic> json) {
    return CountryCode(
        name: json['name'],
        iso2CountryCode: json['iso2CountryCode'],
        dialCode: json['dialCode'],
        flagUri: "assets/flags/${json['iso2CountryCode']}.png".toLowerCase(),
        mobileRegex: json['mobileRegex'] ?? "0?[1-9][0-9]{6,15}",
        iso3CurrencyCode: json['iso3CurrencyCode'] ??
            iso2countryCodeToIso3CurrencyCodes[json['iso2CountryCode']],
        currencySymbol: json['currencySymbol'] ?? r"$");
  }

  @override
  String toString() =>
      "$name($iso2CountryCode, $currencySymbol, $dialCode, $flagUri, $mobileRegex)";

  String toLongString() => "$dialCode ${toCountryStringOnly()}";

  String toCountryStringOnly() {
    return '$_cleanName';
  }

  String? get _cleanName {
    return name.replaceAll(RegExp(r'[[\]]'), '').split(',').first;
  }
}
