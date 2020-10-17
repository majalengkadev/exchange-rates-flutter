import 'package:exchangerates/components/item_currency.dart';
import 'package:exchangerates/models/currency.dart';
import 'package:flutter/material.dart';

class SelectCurrency extends StatefulWidget {
  final Currency currency;
  SelectCurrency({this.currency});

  @override
  _SelectCurrencyState createState() => _SelectCurrencyState();
}

class _SelectCurrencyState extends State<SelectCurrency> {
  List<Currency> currencies = getDataCurrency();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Currency",
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black54,
            )),
        actions: <Widget>[
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.close,
                  color: Colors.black54,
                ),
              )),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 54.0),
        child: ListView.builder(
          itemCount: currencies.length,
          itemBuilder: (context, index) {
            final x = currencies[index];
            return InkWell(
              onTap: () {
                setState(() {
                  Navigator.pop(context, x);
                });
              },
              child:
                  ItemCurrency(x, x.key == widget.currency.key ? true : false),
            );
          },
        ),
      ),
    );
  }
}
