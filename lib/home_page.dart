
import 'package:flutter/material.dart';
import 'package:society_app/app_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'my_sport_court_page.dart';
import 'edit_sports_court_page.dart';
import 'register_sports_court_page.dart';

const request = "http://society.filipeveronezi.dev.br:3000/courts";

class HomePage extends StatefulWidget {
  String nome;
  String token;
  int id;
  HomePage(this.nome, this.token, this.id);
  @override
  State<HomePage> createState() {
    // TODO: implement createState
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> {
  List _quadras = [];
  void whatsapp(numero, mensagem) async {
    String whatsappUrl = 'whatsapp://send?phone=$numero&text=$mensagem';
    await canLaunch(whatsappUrl) ? launch(whatsappUrl) : print("Não foi possível abrir o Whatsapp");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(accountName: Text('Nome ${widget.nome} - Id: ${widget.id}'),),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Início'),
              subtitle: Text('tela de início'),
              onTap: () {
                print(widget.token);
              }
            ),
            ListTile(
              leading: Icon(Icons.crop_square),
              title: Text('Minhas Quadras'),
              subtitle: Text('tela de início'),
              onTap: () {
                // Navigator.of(context).pushNamed('/sports_court');
                Navigator.push(context, MaterialPageRoute(builder: (context) => MySportCourt(widget.nome, widget.token, widget.id)));
              }
            ),
            ListTile(
              leading: Icon(Icons.control_point),
              title: Text('Nova Quadra'),
              subtitle: Text('tela de início'),
              onTap: () {
                print(widget.id);
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterSportsCourtPage(widget.nome, widget.token, widget.id)));
                // Navigator.of(context).pushNamed('/sports_court');
              }
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
            future: getData(widget.nome),
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
                              // title: Text(_quadras[index]['name'], style: TextStyle(color: Colors.black, fontSize: 25.0),textAlign: TextAlign.center,),
                              subtitle: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          Card(
                                            color: Color.fromRGBO(235, 235, 235, 0.4), 
                                            child: Container(
                                              padding: EdgeInsets.all(12.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(_quadras[index]['name'], style: TextStyle(color: Colors.black, fontSize: 25.0),textAlign: TextAlign.center,),
                                                  Divider(),
                                                  Image.network(
                              "https://st4.depositphotos.com/17828278/24401/v/600/depositphotos_244011872-stock-illustration-image-vector-symbol-missing-available.jpg"),
                                                  Divider(),
                                                  Text('Flutter - 2019'),
                                                  Text(_quadras[index]['hour_value']),
                                                  Text(_quadras[index]['phone']),
                                                  MaterialButton(
                                                    color: Colors.green,
                                                    child: Text('WHATsAPP'),
                                                    onPressed: (){
                                                    whatsapp(55019997731314, 'Bom dia!');
                                                  },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                              ),
                              onTap: () {
                                print('Bom dia!');
                              },
                            );
                          },
                    );
                  
              }
            }
      ),
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

Future<List> getData(e) async {
  print(e);
  http.Response response = await http.get(request);
  return json.decode(response.body);
}