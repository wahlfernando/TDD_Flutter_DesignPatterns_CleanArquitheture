import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Curso TDD'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image(image: AssetImage('assets/logo.png')),
            ),
            Text('Login'.toUpperCase()),
            Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    icon: Icon(Icons.lock),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                ElevatedButton(
                    child: Text('Entrar'.toUpperCase()), onPressed: () {}),
                ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      width: 100,
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Canclar'),
                        ],
                      ),
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
