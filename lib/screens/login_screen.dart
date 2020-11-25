import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hoşgeldin',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text('Devam etmek için lütfen giriş yap',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xffd0d0d0),
            ),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Password'),
            ),
            Text('Şifremi unuttum'),
            FlatButton(
              onPressed: () {},
              child: Text('Giriş yap'),
            ),
            Text('Diğer Oturum Açma Yöntemleri'),
            Row(
              children: [
                FlatButton(
                  onPressed: () {},
                  child: Text('Facebook'),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('Google'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
