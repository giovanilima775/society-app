import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_page.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = '';
  String password = '';
  String name = '';
  Map map = {};
  String url = 'http://society.filipeveronezi.dev.br:3333/register';

  Future<String> registerUser(name, email, password) async {
    String data = json.encode({
                      'name': name,
                      'email': email,
                      'password': password,
                    });
    // print(data);
    final response = await http.post(this.url,
      headers: {"content-type": "application/json"},
      body: data
    );
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                  child: Text('Login', style: 
                    TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 32.0,
                    ),
                  ),
                ),
                TextField(
                  onChanged: (text) {
                    name = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder()
                  ),
                ),
                Container(                  
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    password = text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder()
                  ),
                ),
                Container(                  
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder()
                  ),
                ),
                Container(                  
                  height: 10,
                ),               
                RaisedButton(
                  child: Text('Enviar'),
                  onPressed: () {
                    //Chamar o a api passando os dados digitados
                    print(name);
                    print(email);
                    print(password);
                    registerUser(name, email, password).then((response) {
                      print('Boa tarde!');
                      Map<String, dynamic> jsonResponse = json.decode(response);
                      
                      if(jsonResponse.containsKey("error")) {
                        print(json.decode(response)['error']);
                      }else {
                        print(response);
                        String data = json.encode({
                          'email': email,
                          'password': password,
                        });

                        final responseLogin = http.post('http://society.filipeveronezi.dev.br:3333/auth',
                          headers: {"content-type": "application/json"},
                          body: data
                        );
                        // json.decode(responseLogin)['token'];
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(name, json.decode(response)['token'], json.decode(response)['id'])));
                        // Navigator.of(context).pushReplacementNamed('/home');
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}