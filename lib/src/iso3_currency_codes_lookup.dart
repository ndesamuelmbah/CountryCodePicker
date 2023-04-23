const iso2countryCodeToIso3CurrencyCodes = {
  "AF": "USD",
  "AX": "EUR",
  "AL": "EUR",
  "DZ": "DZD",
  "AS": "USD",
  "AD": "EUR",
  "AO": "AOA",
  "AI": "XCD",
  "AG": "XCD",
  "AR": "ARS",
  "AM": "AMD",
  "AW": "AWG",
  "AU": "AUD",
  "AT": "EUR",
  "AZ": "AZM",
  "PT": "EUR",
  "BS": "BSD",
  "BH": "BHD",
  "BD": "BDT",
  "BB": "BBD",
  "BY": "BYR",
  "BE": "EUR",
  "BZ": "BZD",
  "BJ": "XOF",
  "BM": "BMD",
  "BT": "BTN",
  "BO": "BOB",
  "BQ": "ANG",
  "BA": "BAM",
  "BW": "BWP",
  "BR": "BRL",
  "VG": "USD",
  "BN": "BND",
  "BG": "EUR",
  "BF": "XOF",
  "BI": "BIF",
  "KH": "KHR",
  "CM": "XAF",
  "CA": "CAD",
  "ES": "EUR",
  "CV": "CVE",
  "KY": "KYD",
  "CF": "XAF",
  "XC": "EUR",
  "TD": "XAF",
  "CL": "CLP",
  "CN": "RMB",
  "CO": "COP",
  "KM": "USD",
  "CG": "XAF",
  "CD": "CDF",
  "CK": "NZD",
  "CR": "CRC",
  "HR": "EUR",
  "CU": "CU",
  "CW": "USD",
  "CY": "EUR",
  "CZ": "CZK",
  "DK": "DKK",
  "DJ": "DJF",
  "DM": "XCD",
  "DO": "DOP",
  "TL": "USD",
  "EC": "USD",
  "EG": "EGP",
  "SV": "USD",
  "GB": "GBP",
  "GQ": "XAF",
  "ER": "ERN",
  "EE": "EUR",
  "ET": "ETB",
  "EP": "EUR",
  "FO": "DKK",
  "FJ": "FJD",
  "FI": "EUR",
  "FR": "EUR",
  "GF": "EUR",
  "PF": "XPF",
  "GA": "XAF",
  "GM": "GMD",
  "GE": "GEL",
  "DE": "EUR",
  "GH": "GHS",
  "GI": "GIP",
  "GR": "EUR",
  "GL": "DKK",
  "GD": "XCD",
  "GP": "EUR",
  "GU": "USD",
  "GT": "GTQ",
  "GG": "GBP",
  "GN": "GNF",
  "GW": "XOF",
  "GY": "GYD",
  "HT": "HTG",
  "NL": "EUR",
  "HN": "HNL",
  "HK": "HKD",
  "HU": "HUF",
  "IS": "ISK",
  "IN": "INR",
  "ID": "IDR",
  "IQ": "NID",
  "IE": "EUR",
  "IL": "ILS",
  "IT": "EUR",
  "CI": "XOF",
  "JM": "JMD",
  "JP": "JPY",
  "JE": "GBP",
  "JO": "JOD",
  "KZ": "KZT",
  "KE": "KES",
  "KI": "AUD",
  "KR": "KRW",
  "KV": "EUR",
  "FM": "USD",
  "KW": "KWD",
  "KG": "KGS",
  "LA": "LAK",
  "LV": "EUR",
  "LB": "LBP",
  "LS": "LSL",
  "LR": "LRD",
  "LY": "LYD",
  "LI": "CHF",
  "LT": "EUR",
  "LU": "EUR",
  "MO": "MOP",
  "MK": "EUR",
  "MG": "MGA",
  "MW": "MWK",
  "MY": "MYR",
  "MV": "MVR",
  "ML": "XOF",
  "MT": "EUR",
  "MH": "USD",
  "MQ": "EUR",
  "MR": "MRO",
  "MU": "MUR",
  "YT": "EUR",
  "XL": "EUR",
  "MX": "MXN",
  "MD": "MDL",
  "MC": "EUR",
  "MN": "MNT",
  "ME": "EUR",
  "MS": "XCD",
  "MA": "MAD",
  "MZ": "MZM",
  "NA": "NAD",
  "NP": "NPR",
  "NC": "XPF",
  "NZ": "NZD",
  "NI": "NIO",
  "NE": "XOF",
  "NG": "NGN",
  "NF": "AUD",
  "MP": "USD",
  "NO": "NOK",
  "OM": "OMR",
  "PK": "PKR",
  "PW": "USD",
  "PA": "PAB",
  "PG": "PGK",
  "PY": "PYG",
  "PE": "PEN",
  "PH": "PHP",
  "PL": "PLN",
  "PR": "USD",
  "QA": "QAR",
  "RE": "EUR",
  "RO": "ROL",
  "RU": "RUB",
  "RW": "RWF",
  "WS": "WST",
  "SM": "EUR",
  "ST": "STD",
  "SA": "SAR",
  "SN": "XOF",
  "RS": "EUR",
  "SC": "SCR",
  "SL": "SLL",
  "SG": "SGD",
  "SK": "EUR",
  "SI": "EUR",
  "SB": "SBD",
  "ZA": "ZAR",
  "LK": "LKR",
  "BL": "EUR",
  "KN": "XCD",
  "VI": "USD",
  "LC": "XCD",
  "SX": "USD",
  "VC": "XCD",
  "SR": "SRG",
  "SZ": "SZL",
  "SE": "SEK",
  "CH": "CHF",
  "TW": "TWD",
  "TJ": "TJS",
  "TZ": "TZS",
  "TH": "THB",
  "TG": "XOF",
  "TO": "TOP",
  "TT": "TTD",
  "TN": "TND",
  "TR": "TRY",
  "TM": "TMT",
  "TC": "USD",
  "TV": "AUD",
  "UG": "UGX",
  "UA": "UAH",
  "AE": "AED",
  "US": "USD",
  "UY": "UYU",
  "UZ": "UZS",
  "VU": "VUV",
  "VA": "EUR",
  "VE": "VEB",
  "VN": "VND",
  "WF": "XPF",
  "YE": "YER",
  "ZM": "ZMK",
  "ZW": "ZWD"
};
