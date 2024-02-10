import 'dart:convert';

import 'currency_json.dart';

List<Currency> currencies() => [for (final x in currency_json) Currency.fromJson(x)];
String currencyToJson(List<Currency> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Currency {
  String? symbol;
  String? name;
  String? symbolNative;
  int? decimalDigits;
  double? rounding;
  String? code;
  String? namePlural;

  Currency({
    this.symbol,
    this.name,
    this.symbolNative,
    this.decimalDigits,
    this.rounding,
    this.code,
    this.namePlural,
  });

  factory Currency.fromRawJson(String str) => Currency.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        symbol: json["symbol"],
        name: json["name"],
        symbolNative: json["symbol_native"],
        decimalDigits: json["decimal_digits"],
        rounding: json["rounding"]?.toDouble(),
        code: json["code"],
        namePlural: json["name_plural"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "name": name,
        "symbol_native": symbolNative,
        "decimal_digits": decimalDigits,
        "rounding": rounding,
        "code": code,
        "name_plural": namePlural,
      };
}
