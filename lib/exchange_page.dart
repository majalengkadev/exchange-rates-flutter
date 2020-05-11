import 'package:dio/dio.dart';
import 'package:exchangerates/components/error_message.dart';
import 'package:exchangerates/components/info_dialog.dart';
import 'package:exchangerates/components/last_update.dart';
import 'package:exchangerates/components/swap_button.dart';
import 'package:exchangerates/models/exchange_rates.dart';
import 'package:exchangerates/select_currency.dart';
import 'package:exchangerates/utils/constant.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'models/currency.dart';

class ExchangePage extends StatefulWidget {
  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  final Dio dio = Dio();
  bool isLoading = true;
  TextEditingController _controller;
  Currency origin = Currency(
      text: "USD - United States Dollar",
      key: "us",
      value: "USD",
      flag: "us",
      symbol: "\$");
  Currency destination = Currency(
      text: "IDR - Indonesian Rupiah",
      key: "id",
      value: "IDR",
      flag: "id",
      symbol: "Rp");

  int current = 1;

  Future<ExchangeRates> future;
  bool isBase = true;
  double resultConvert = 0;

  //ads
  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: 'ca-app-pub-9619934169053673/5625207799',
      size: AdSize.banner,
      targetingInfo: MobileAdTargetingInfo(
        keywords: <String>['finance', 'money'],
        contentUrl: 'https://exchangeratesapi.io',
        childDirected: false,
      ),
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-9619934169053673~5402966071');
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    _controller = TextEditingController(text: '1');
    getData();
  }

  getData() {
    setState(() {
      future = dio
          .get("https://api.exchangeratesapi.io/latest?base=${origin.value}")
          .then((resp) => ExchangeRates.fromJson(resp.data));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Kurs Mata Uang",
            style: kTitleTextStyle,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                  onTap: () {
                    showInfo();
                  },
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.lightBlueAccent,
                  )),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 54),
          child: FutureBuilder<ExchangeRates>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return showData(snapshot.data);
                } else if (snapshot.hasError) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ErrorMessage(
                      msg: snapshot.error.toString(),
                      onPressed: () {
                        getData();
                      },
                    ),
                  ));
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ));
                }
              }),
        ));
  }

  Widget showData(ExchangeRates data) {
    convertAction();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                            height: 35,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                child: Flags.getFullFlag(
                                    '${origin.flag}', 30, 40)),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                onTap: () async {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SelectCurrency(
                                                currency: origin,
                                              )));

                                  if (result != null) {
                                    setState(() {
                                      origin = result;
                                      isBase = true;
                                    });
                                    await getData();
                                    convertAction();
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${origin.text.split("-")[0]}',
                                          style: kCountryTextStyle,
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xff3b3f47),
                                          size: 28,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        '${origin.text.split("-")[1].trim()}',
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 4, right: 16, top: 12, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w300),
                                keyboardType: TextInputType.number,
                                controller: _controller,
                                onChanged: (value) {
                                  convertAction();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xfff6f6f6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16, top: 2),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 35,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    child: Flags.getFullFlag(
                                        '${destination.flag}', 30, 40)),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "=",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 32,
                                    color: Colors.black38),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                onTap: () async {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SelectCurrency(
                                                currency: destination,
                                              )));

                                  if (result != null) {
                                    setState(() {
                                      destination = result;
                                    });
                                    convertAction();
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${destination.text.split("-")[0]}',
                                          style: TextStyle(
                                              color: Color(0xff3b3f47),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xff3b3f47),
                                          size: 28,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        '${destination.text.split("-")[1].trim()}',
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, left: 4),
                                child: Text(
                                  FlutterMoneyFormatter(
                                          amount: resultConvert,
                                          settings: MoneyFormatterSettings(
                                              thousandSeparator: ".",
                                              decimalSeparator: ","))
                                      .output
                                      .nonSymbol,
                                  style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 140,
                right: 32,
                child: SwapButton(
                  onTap: () {
                    Currency temp = origin;
                    setState(() {
                      origin = destination;
                      destination = temp;
                      isBase = !isBase;
                    });
                    convertAction();
                  },
                ),
              ),
            ],
          ),
          LastUpdate(date: data.date)
        ],
      ),
    );
  }

  void convertAction() {
    future.then((v) {
      setState(() {
        try {
          if (_controller.text.isNotEmpty) {
            if (int.parse(_controller.text) > 0) {
              if (isBase) {
                resultConvert =
                    v.rates[destination.value] * int.parse(_controller.text);
              } else {
                resultConvert =
                    int.parse(_controller.text) / v.rates[origin.value];
              }
            } else {
              resultConvert = 0;
            }
          } else {
            resultConvert = 0;
          }
        } catch (e) {
          print("errors ${e.toString()}");
          resultConvert = 0;
        }
      });
    });
  }

  Future<void> showInfo() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return InfoDialog();
      },
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
