
import 'package:flutter/material.dart';
import 'package:society_app/app_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "http://society.filipeveronezi.dev.br:3000/courts";

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    // TODO: implement createState
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> {
  List _quadras = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(accountName: Text('Nome de Usuário'),),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Início'),
              subtitle: Text('tela de início'),
            ),
            ListTile(
              leading: Icon(Icons.chevron_left),
              title: Text('Sair'),
              subtitle: Text('sair do aplicativo'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[CustomSwitch(),],
      ),
      body: FutureBuilder<List>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    "Carregando Dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default:
                    print(snapshot.data);
                    _quadras = snapshot.data;
                    print(_quadras.length);
                    return  ListView.builder(
                          padding: EdgeInsets.only(top: 10.0),
                          itemCount: snapshot.data.length,
                          itemBuilder: (contextList, index) {
                            return ListTile(
                              title: Text(_quadras[index]['name'], style: TextStyle(color: Colors.amber, fontSize: 25.0),),
                              onTap: () {
                                print('Bom dia');
                              },
                            );
                          },
                    );

                    
                    // for(final teste in snapshot.data) {
                    //   return Container(
                    //   child: Text(teste['name']),
                    // );
                    // }                  
                    // print(snapshot.data["results"]["currencies"]["EUR"]["buy"]);

                    // return Expanded(
                    //   child: ListView.builder(
                    //     padding: EdgeInsets.only(top: 10.0),
                    //     itemCount: snapshot.data.length,
                    //     itemBuilder: (contextList, index) {
                    //       return ListTile(
                    //         title: Text(_quadras[index]),
                    //       );
                    //     }),
                    // );

                    // return SingleChildScrollView(
                    //   padding: EdgeInsets.all(10.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.stretch,
                    //     children: <Widget>[
                    //       Icon(Icons.monetization_on,
                    //           size: 150.0, color: Colors.amber),
                    //       buildTextField(
                    //           "Reais", "R\$", realController, _realChanged),
                    //       Divider(),
                    //       buildTextField("Dólares", "US\$", dolarController,
                    //           _dolarChanged),
                    //       Divider(),
                    //       buildTextField(
                    //           "Euros", "€", euroController, _euroChanged),
                    //     ],
                    //   ),
                    // );
                  
              }
            }
        )
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //           setState(() {
      //             counter++;
      //           });
      //           print(counter);
      //         }
      //   ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Switch(value: AppController.instance.isDartTheme, onChanged: (value) {
          AppController.instance.changeTheme();
    });
  }
}

Future<List> getData() async {
  http.Response response = await http.get(request);
  // print(json.decode(response.body)[0]);
  //{"by":"default","valid_key":false,"results":{"currencies":{"source":"BRL","USD":{"name":"Dollar","buy":5.627,"sell":5.6205,"variation":0.59},"EUR":{"name":"Euro","buy":6.6768,"sell":6.6659,"variation":0.97},"GBP":{"name":"Pound Sterling","buy":7.3442,"sell":null,"variation":0.35},"ARS":{"name":"Argentine Peso","buy":0.0723,"sell":null,"variation":0.43},"BTC":{"name":"Bitcoin","buy":77261.095,"sell":77261.095,"variation":0.435}},"stocks":{"IBOVESPA":{"name":"BM\u0026F BOVESPA","location":"Sao Paulo, Brazil","points":101259.75,"variation":-0.65},"NASDAQ":{"name":"NASDAQ Stock Market","location":"New York City, United States","points":11548.28,"variation":0.37},"CAC":{"name":"CAC 40","location":"Paris, French","variation":1.2},"NIKKEI":{"name":"Nikkei 225","location":"Tokyo, Japan","variation":0.18}},"available_sources":["BRL"],"taxes":[]},"execution_time":0.0,"from_cache":true}
  return json.decode(response.body);
  // return {
  //   "by": "default",
  //   "valid_key": false,
  //   "results": {
  //     "currencies": {
  //       "source": "BRL",
  //       "USD": {
  //         "name": "Dollar",
  //         "buy": 5.627,
  //         "sell": 5.6205,
  //         "variation": 0.59
  //       },
  //       "EUR": {
  //         "name": "Euro",
  //         "buy": 6.6768,
  //         "sell": 6.6659,
  //         "variation": 0.97
  //       },
  //       "GBP": {
  //         "name": "Pound Sterling",
  //         "buy": 7.3442,
  //         "sell": null,
  //         "variation": 0.35
  //       },
  //       "ARS": {
  //         "name": "Argentine Peso",
  //         "buy": 0.0723,
  //         "sell": null,
  //         "variation": 0.43
  //       },
  //       "BTC": {
  //         "name": "Bitcoin",
  //         "buy": 77410.926,
  //         "sell": 77410.926,
  //         "variation": 0.63
  //       }
  //     },
  //     "stocks": {
  //       "IBOVESPA": {
  //         "name": "BM&F BOVESPA",
  //         "location": "Sao Paulo, Brazil",
  //         "points": 101259.75,
  //         "variation": -0.65
  //       },
  //       "NASDAQ": {
  //         "name": "NASDAQ Stock Market",
  //         "location": "New York City, United States",
  //         "points": 11548.28,
  //         "variation": 0.37
  //       },
  //       "CAC": {
  //         "name": "CAC 40",
  //         "location": "Paris, French",
  //         "variation": 1.2
  //       },
  //       "NIKKEI": {
  //         "name": "Nikkei 225",
  //         "location": "Tokyo, Japan",
  //         "variation": 0.18
  //       }
  //     },
  //     "available_sources": [
  //       "BRL"
  //     ],
  //     "taxes": [

  //     ]
  //   },
  //   "execution_time": 0.0,
  //   "from_cache": true
  // };

}