import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'my_sport_court_page.dart';
import 'dart:convert';



// ignore: must_be_immutable
class EditSportsCourtPage extends StatefulWidget {
  String nome;
  String token;
  int id;
  int court;

  EditSportsCourtPage(this.nome, this.token, this.id, this.court);
  @override
  _EditSportsCourtPageState createState() => _EditSportsCourtPageState();
}

class _EditSportsCourtPageState extends State<EditSportsCourtPage> {
  TextEditingController _local = TextEditingController();
  TextEditingController _contato = TextEditingController();
  TextEditingController _valorHora = TextEditingController();


  TextEditingController _rua = TextEditingController();
  TextEditingController _numero = TextEditingController();
  TextEditingController _bairro = TextEditingController();
  TextEditingController _cidade = TextEditingController();
  TextEditingController _uf = TextEditingController();

  String local = '';
  String contato = '';
  double valorHora;

  String rua = '';
  int numero;
  String bairro = '';
  String cidade = '';
  String uf = '';

  

  Future<String> registerCourts(local, contato, valorHora, courtId) async {

    String validate = 'http://society.filipeveronezi.dev.br:3333/validate';
    String authorization = 'Bearer ${widget.token}';
    final responseValidate = await http.post(validate,
        headers: {"Authorization": authorization},
    );

    // print('local ${local}');
    // print(contato);
    // print(valorHora);
    // print(courtId);

    String urlCourts = 'http://society.filipeveronezi.dev.br:3000/courts/${courtId}';
    
    String data = json.encode({
                      'name': local,
                      'hour_value': valorHora,
                      'phone': contato,
                    });
    print(urlCourts);
    print(data);
    final response = await http.put(urlCourts,
      body: data
    );
    int  id = json.decode(response.body)['id'];

    Map<String, dynamic> jsonResponse = json.decode(response.body);
                      
    if(jsonResponse.containsKey("error")) {
      print('erro');
      print(json.decode(response.body)['error']);
    }else {
       print(json.decode(response.body));
      registerAddress(this.rua, this.numero, this.bairro, this.cidade, this.uf, courtId);
    }
    return response.body;
  }

  Future<String> registerAddress(rua, numero, bairro, cidade, uf, id) async {
    print('AAA');
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
 
    final response = await http.put(urlAdderss,
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
      body: FutureBuilder<Map>(
            future: getData(widget.court, widget.token, widget.id),
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
                  if(snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                        child: Text(
                      "Erro ao Carregar Dados :(",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    print('Map aaaaaaaaaaaaaaaaaaaaaaaaa');
                    print(snapshot.data);
                    _local = TextEditingController(text: snapshot.data['name']);
                    _valorHora = TextEditingController(text: snapshot.data['hour_value']);
                    _contato = TextEditingController(text: snapshot.data['phone']);

                    _rua = TextEditingController(text: snapshot.data['address']['street']);
                    _numero = TextEditingController(text: '${snapshot.data['address']['number']}');
                    _bairro = TextEditingController(text: snapshot.data['address']['district']);
                    _cidade = TextEditingController(text: snapshot.data['address']['city']);
                    _uf = TextEditingController(text: snapshot.data['address']['state']);


                    local   = snapshot.data['name'];
                    contato = snapshot.data['phone'];
                    valorHora = double.parse(snapshot.data['hour_value']);

                    rua     = snapshot.data['address']['street'];
                    numero  = snapshot.data['address']['number'];
                    bairro  = snapshot.data['address']['district'];
                    cidade  = snapshot.data['address']['city'];
                    uf      = snapshot.data['address']['state'];

                    return SingleChildScrollView(
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
                                    controller: _local,
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
                                    controller: _contato,
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
                                    controller: _valorHora,
                                    decoration: InputDecoration(
                                      labelText: 'Valor/h',
                                        border: OutlineInputBorder(),
                                        prefixText: "R\$ "),
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    onChanged: (text) {
                                      valorHora = double.parse(text);
                                    },
                                  ),Container(
                                    child: Text('Endereço', style: 
                                      TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 32.0,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    controller: _rua,
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
                                    controller: _numero,
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
                                    controller: _bairro,
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
                                    controller: _cidade,
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
                                    controller: _uf,
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
                                      registerCourts(local, contato, valorHora, snapshot.data['id']);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    );
                  }
              }
            }
      ),
    );
  }
}

Future<Map> getData(court, token, user) async {
  // print('Quadra ${e}');
  // print(a);
  String request = "http://society.filipeveronezi.dev.br:3000/courts/report/${court}/8";
  String validate = 'http://society.filipeveronezi.dev.br:3333/validate';
  String authorization = 'Bearer ${token}';
  final responseValidate = await http.post(validate,
      headers: {"Authorization": authorization},
    );
  // print(responseValidate.body);
  // print(authorization);
  http.Response response = await http.get(request);
  // print('Dados da quadra');
  // print(response.body);
  return json.decode(response.body);
}