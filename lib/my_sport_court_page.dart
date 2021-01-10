
import 'package:flutter/material.dart';
import 'package:society_app/app_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import  'edit_sports_court_page.dart';

class MySportCourt extends StatefulWidget {
  String nome;
  String token;
  int id;
  MySportCourt(this.nome, this.token, this.id);
  @override
  State<MySportCourt> createState() {
    // TODO: implement createState
    return MySportCourtState();
  }

}

class MySportCourtState extends State<MySportCourt> {
  List _quadras = [];
  

  Future<String> removeCourt(idCourt) async {
    String url = 'http://society.filipeveronezi.dev.br:3000/courts/';
    String stringId = idCourt.toString();
    url = url + stringId;
    var response = await http.delete(url,
      headers: {"content-type": "application/json"},
    );
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Quadras'),
        actions: <Widget>[CustomSwitch(),],
      ),
      body: FutureBuilder<List>(
            future: getData(widget.id),
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
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Expanded(flex: 4, child: MaterialButton(
                                                          color: Colors.green,
                                                          child: Text('Editar'),
                                                          onPressed: (){
                                                            print(widget.token);
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditSportsCourtPage(widget.nome, widget.token, widget.id, _quadras[index]['id'])));
                                                        })),
                                                        Expanded(flex: 2, child: Container(
                                                        )),
                                                        Expanded(flex: 4, child: MaterialButton(
                                                          color: Colors.red,
                                                          child: Text('Excluir'),
                                                          onPressed: (){
                                                          print('Excluir');
                                                          print(_quadras[index]['id']);
                                                          print(removeCourt(_quadras[index]['id']));
                                                          setState(() {

                                                          });
                                                        })),
                                                      ]
                                                    )
                                                  )
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

Future<List> getData(userId) async {

  String request = "http://society.filipeveronezi.dev.br:3000/courts/report/"+userId.toString();
  http.Response response = await http.get(request);
  return json.decode(response.body);

}