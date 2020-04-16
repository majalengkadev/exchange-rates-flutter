import 'dart:convert';

List<Currency> currencyFromJson(String str) =>
    List<Currency>.from(json.decode(str).map((x) => Currency.fromJson(x)));

String currencyToJson(List<Currency> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Currency {
  String text;
  String key;
  String value;
  String flag;
  String symbol;

  Currency({
    this.text,
    this.key,
    this.value,
    this.flag,
    this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        text: json["text"],
        key: json["key"],
        value: json["value"],
        flag: json["flag"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "key": key,
        "value": value,
        "flag": flag,
        "symbol": symbol,
      };
}

List<Currency> getDataCurrency() {
  var json = [
    {
      "text": "EUR - Euro",
      "key": "eu",
      "value": "EUR",
      "flag": "eu",
      "symbol": "€"
    },
    {
      "text": "GBP - British Pound Sterling",
      "key": "gb",
      "value": "GBP",
      "flag": "gb",
      "symbol": "£"
    },
    {
      "text": "AUD - Australian Dollar",
      "key": "au",
      "value": "AUD",
      "flag": "au",
      "symbol": "\$"
    },
    {
      "text": "NZD - New Zealand Dollar",
      "key": "nz",
      "value": "NZD",
      "flag": "nz",
      "symbol": "\$"
    },
    {
      "text": "USD - United States Dollar",
      "key": "us",
      "value": "USD",
      "flag": "us",
      "symbol": "\$"
    },
    {
      "text": "CAD - Canadian Dollar",
      "key": "ca",
      "value": "CAD",
      "flag": "ca",
      "symbol": "\$"
    },
    {
      "text": "CHF - Swiss Franc",
      "key": "ch",
      "value": "CHF",
      "flag": "ch",
      "symbol": "₣"
    },
    {
      "text": "JPY - Japanese Yen",
      "key": "jp",
      "value": "JPY",
      "flag": "jp",
      "symbol": "¥"
    },
    {
      "text": "BGN - Bulgarian Lev",
      "key": "bg",
      "value": "BGN",
      "flag": "bg",
      "symbol": "лв"
    },
    {
      "text": "ILS - Israeli New Sheqel",
      "key": "il",
      "value": "ILS",
      "flag": "il",
      "symbol": "₪"
    },
    {
      "text": "RUB - Russian Ruble",
      "key": "ru",
      "value": "RUB",
      "flag": "ru",
      "symbol": "₽"
    },
    {
      "text": "PHP - Philippine Peso",
      "key": "ph",
      "value": "PHP",
      "flag": "ph",
      "symbol": "₱"
    },
    {
      "text": "ZAR - South African Rand",
      "key": "za",
      "value": "ZAR",
      "flag": "za",
      "symbol": "R"
    },
    {
      "text": "TRY - Turkish Lira",
      "key": "tr",
      "value": "TRY",
      "flag": "tr",
      "symbol": "₤"
    },
    {
      "text": "HKD - Hong Kong Dollar",
      "key": "hk",
      "value": "HKD",
      "flag": "hk",
      "symbol": "\$"
    },
    {
      "text": "MYR - Malaysian Ringgit",
      "key": "my",
      "value": "MYR",
      "flag": "my",
      "symbol": "RM"
    },
    {
      "text": "THB - Thai Baht",
      "key": "th",
      "value": "THB",
      "flag": "th",
      "symbol": "฿"
    },
    {
      "text": "HRK - Croatian Kuna",
      "key": "hr",
      "value": "HRK",
      "flag": "hr",
      "symbol": "Kn"
    },
    {
      "text": "NOK - Norwegian Krone",
      "key": "no",
      "value": "NOK",
      "flag": "no",
      "symbol": "kr"
    },
    {
      "text": "IDR - Indonesian Rupiah",
      "key": "id",
      "value": "IDR",
      "flag": "id",
      "symbol": "Rp"
    },
    {
      "text": "DKK - Danish Krone",
      "key": "dk",
      "value": "DKK",
      "flag": "dk",
      "symbol": "kr"
    },
    {
      "text": "CZK - Czech Republic Koruna",
      "key": "cz",
      "value": "CZK",
      "flag": "cz",
      "symbol": "Kč"
    },
    {
      "text": "HUF - Hungarian Forint",
      "key": "hu",
      "value": "HUF",
      "flag": "hu",
      "symbol": "Ft"
    },
    {
      "text": "MXN - Mexican Peso",
      "key": "mx",
      "value": "MXN",
      "flag": "mx",
      "symbol": "\$"
    },
    {
      "text": "KRW - South Korean Won",
      "key": "kr",
      "value": "KRW",
      "flag": "kr",
      "symbol": "₩"
    },
    {
      "text": "ISK - Icelandic Kr\u00f3na",
      "key": "is",
      "value": "ISK",
      "flag": "is",
      "symbol": "Kr"
    },
    {
      "text": "SGD - Singapore Dollar",
      "key": "sg",
      "value": "SGD",
      "flag": "sg",
      "symbol": "\$"
    },
    {
      "text": "BRL - Brazilian Real",
      "key": "br",
      "value": "BRL",
      "flag": "br",
      "symbol": "R\$"
    },
    {
      "text": "PLN - Polish Zloty",
      "key": "pl",
      "value": "PLN",
      "flag": "pl",
      "symbol": "zł"
    },
    {
      "text": "INR - Indian Rupee",
      "key": "in",
      "value": "INR",
      "flag": "in",
      "symbol": "₹"
    },
    {
      "text": "RON - Romanian Leu",
      "key": "ro",
      "value": "RON",
      "flag": "ro",
      "symbol": "L"
    },
    {
      "text": "CNY - Chinese Yuan",
      "key": "cn",
      "value": "CNY",
      "flag": "cn",
      "symbol": "¥"
    },
    {
      "text": "SEK - Swedish Krona",
      "key": "se",
      "value": "SEK",
      "flag": "se",
      "symbol": "kr"
    }
  ];
  return currencyFromJson(jsonEncode(json));
}
