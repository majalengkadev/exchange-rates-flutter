class ExchangeRates {
  Map<String, double> rates;
  String base;
  String date;

  ExchangeRates({
    this.rates,
    this.base,
    this.date,
  });

  factory ExchangeRates.fromJson(Map<String, dynamic> json) => ExchangeRates(
        rates: Map.from(json["rates"])
            .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        base: json["base"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "base": base,
        "date": date,
      };
}
