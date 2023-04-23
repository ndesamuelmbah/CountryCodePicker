import 'country_codes.dart';
import 'iso3_currency_codes_lookup.dart';

String getPaystackIso3CurrencyCode(
    double lat, double lng, String iso2countryCode) {
  iso2countryCode = iso2countryCode.toUpperCase();
  Map<String, String> codesMap = {
    'NG': 'NGN',
    'US': 'USD',
    'GH': 'GHS',
    'ZA': 'ZAR'
  };
  if (codesMap.containsKey(iso2countryCode)) {
    return codesMap[iso2countryCode]!;
  }
  if ('CA MX'.contains(iso2countryCode)) {
    return 'USD';
  }
  for (var code in countryCodes) {
    if (code['iso2CountryCode'] == iso2countryCode) {
      return ["€", r"$"].contains(code['currencySymbol']) ? 'USD' : 'NGN';
    }
  }
  return 'NGN';
}

String getIso3CurrencyCode(String iso2CountryCode) {
  iso2CountryCode = iso2CountryCode.toUpperCase();
  if (iso2countryCodeToIso3CurrencyCodes.containsKey(iso2CountryCode)) {
    return iso2countryCodeToIso3CurrencyCodes[iso2CountryCode]!;
  }
  return 'USD';
}
