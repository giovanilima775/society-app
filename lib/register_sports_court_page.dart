import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'my_sport_court_page.dart';
import 'dart:convert';

// ignore: must_be_immutable
class RegisterSportsCourtPage extends StatefulWidget {
  String nome;
  String token;
  int id;

  RegisterSportsCourtPage(this.nome, this.token, this.id);
  @override
  _RegisterSportsCourtPageState createState() => _RegisterSportsCourtPageState();
}

class _RegisterSportsCourtPageState extends State<RegisterSportsCourtPage> {
  String local = '';
  String contato = '';
  double valorHora;

  String rua = '';
  int numero;
  String bairro = '';
  String cidade = '';
  String uf = '';

  String urlCourts = 'http://society.filipeveronezi.dev.br:3000/courts';
  

  Future<String> registerCourts(local, contato, valorHora) async {
    String data = json.encode({
                      'name': local,
                      'hour_value': valorHora,
                      'phone': contato,
                      'user_id': widget.id, 
                    });
    final response = await http.post(this.urlCourts,
      headers: {"content-type": "application/json"},
      body: data
    );
    int  id = json.decode(response.body)['id'];

    Map<String, dynamic> jsonResponse = json.decode(response.body);
                      
    if(jsonResponse.containsKey("error")) {
      print(json.decode(response.body)['error']);
    }else {
      registerAddress(this.rua, this.numero, this.bairro, this.cidade, this.uf, id);
    }
    return response.body;
  }

  Future<String> registerAddress(rua, numero, bairro, cidade, uf, id) async {
    int court = id;
    String urlAdderss = 'http://society.filipeveronezi.dev.br:3000/courts/${court}/addresses';

      print(urlAdderss);
    String data = json.encode({
                      'street': rua,
                      'number': numero,
                      'district': bairro,
                      'city': cidade, 
                      'state': uf,
                    });
 
    final response = await http.post(urlAdderss,
      headers: {"content-type": "application/json"},
      body: data
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);
                      
    if(jsonResponse.containsKey("error")) {
      print(json.decode(response.body)['error']);
    }else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MySportCourt(widget.nome, widget.token, widget.id)));
    }
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 180,
                      height: 180,
                      child: Image.network(
                        'https://cdn4.iconfinder.com/data/icons/sports-outline-24-px/24/Ball_court_game_sport_tennis_game-512.png'
                      ),
                    ),
                    Container(
                      child: Text('Nova Quadra', style: 
                        TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 32.0,
                        ),
                      ),
                    ),
                    TextField(
                      onChanged: (text) {
                        local = text;
                      },
                      decoration: InputDecoration(
                        labelText: 'Nome do local',
                        border: OutlineInputBorder()
                      ),
                    ),
                    Container(                  
                      height: 10,
                    ),
                    TextField(
                      onChanged: (text) {
                        contato = text;
                      },
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Whatsapp (xx) xxxxxxxxxx',
                        border: OutlineInputBorder()
                      ),
                    ),
                    Container(                  
                      height: 10,
                    ),TextField(
                      decoration: InputDecoration(
                        labelText: 'Valor/h',
                          border: OutlineInputBorder(),
                          prefixText: "R\$ "),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onChanged: (text) {
                        valorHora = double.parse(text);
                      },
                    ),
                    Container(
                      child: Text('Endereço', style: 
                        TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 32.0,
                        ),
                      ),
                    ),
                    TextField(
                      onChanged: (text) {
                        rua = text;
                      },
                      decoration: InputDecoration(
                        labelText: 'Rua',
                        border: OutlineInputBorder()
                      ),
                    ),
                    Container(                  
                      height: 10,
                    ),
                    
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        numero = int.parse(text);
                      },
                      decoration: InputDecoration(
                        labelText: 'Nº',
                        border: OutlineInputBorder()
                      ),
                    ),
                    Container(                  
                      height: 10,
                    ),
                    TextField(
                      onChanged: (text) {
                        bairro = text;
                      },
                      decoration: InputDecoration(
                        labelText: 'Bairro',
                        border: OutlineInputBorder()
                      ),
                    ),
                    Container(                  
                      height: 10,
                    ),
                    TextField(
                      onChanged: (text) {
                        cidade = text;
                      },
                      decoration: InputDecoration(
                        labelText: 'Cidade',
                        border: OutlineInputBorder()
                      ),
                    ),
                    Container(                  
                      height: 10,
                    ),
                    TextField(
                      textCapitalization: TextCapitalization.characters,
                      maxLength: 2,
                      onChanged: (text) {
                        uf = text.toLowerCase();
                      },
                      decoration: InputDecoration(
                        labelText: 'UF',
                        border: OutlineInputBorder()
                      ),
                    ),
                    Container(                  
                      height: 10,
                    ),         
                    RaisedButton(
                      child: Text('Enviar'),
                      onPressed: () {
                        registerCourts(local, contato, valorHora);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}