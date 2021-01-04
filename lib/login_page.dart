import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  String name = '';
  int id = 0;
  String token;
  String jwt = '';
  String url = 'http://society.filipeveronezi.dev.br:3333/auth';

  Future<String> registerUser(email, password) async {
    String data = json.encode({
                      'email': email,
                      'password': password,
                    });

    final response = await http.post(this.url,
      headers: {"content-type": "application/json"},
      body: data
    );
    print(data);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 232,
                  height: 232,
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
                    email = text;
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
                    labelText: 'Password',
                    border: OutlineInputBorder()
                  ),
                ),
                RaisedButton(
                  child: Text('Entrar'),
                  onPressed: () {
                    registerUser(email, password).then((response) {
                      print('Boa Noite!');
                      Map<String, dynamic> jsonResponse = json.decode(response);
                      
                      if(jsonResponse.containsKey("error")) {
                        print(json.decode(response)['error']);
                      }else {
                        print(json.decode(response)['user']['name']);
                        name = json.decode(response)['user']['name'];
                        token = json.decode(response)['user']['token'];
                        id = json.decode(response)['user']['id'];
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(name, token, id)));
                        // Navigator.of(context).pushReplacementNamed('/home');
                      }
                    });
                    //Chamar o a api passando os dados digitados
                    // if(email == 'teste' && password == '123') {
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage('Abc')));
                    //   // Navigator.of(context).pushReplacementNamed('/home');
                    // }else {
                    //   print('errado');
                    // }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: FlatButton(
                    onPressed: () {
                      //Chamar o a api passando os dados digitados
                      Navigator.of(context).pushNamed('/register');
                    },
                    child: Text('+ Novo Usuário'),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}