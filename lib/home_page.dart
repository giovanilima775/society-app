
import 'package:flutter/material.dart';
import 'package:society_app/app_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    // TODO: implement createState
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[CustomSwitch(),],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contador: $counter'),
            Container(
              width: double.infinity,
              color: Colors.white,
              height: 30,
            ),
            CustomSwitch(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width:50,
                  height: 50,
                  color: Colors.black,
                ),
                Container(
                  width:50,
                  height: 50,
                  color: Colors.black,
                ),
                Container(
                  width:50,
                  height: 50,
                  color: Colors.black,
                ),

              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
                setState(() {
                  counter++;
                });
                print(counter);
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