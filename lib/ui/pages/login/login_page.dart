import 'package:flutter/material.dart';

import '../pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderLogin(),
            Text(
              'Login'.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Form(
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(
                          Icons.email,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only( left: 20, right: 20),
                    child: TextFormField(
                      style:
                          TextStyle(color: Theme.of(context).primaryColorLight),
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        icon: Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  // Container(
                  //   height: 60,
                  //   width: 160,
                  //   decoration: BoxDecoration(
                  //       color: Theme.of(context).primaryColorLight,
                  //       borderRadius: BorderRadius.circular(40)),
                  //   child: Center(
                  //     child: Text(
                  //       'Entrar'.toUpperCase(),
                  //       style: const TextStyle(
                  //           color: Colors.white, fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),

                  SizedBox(
                    height: 60,
                    width: 200.0,
                    child: ElevatedButton(
                      onPressed: null,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          )),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),

                  SizedBox( height: 17 ),

                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    label: Text(
                      'Criar conta',
                      style:
                          TextStyle(color: Theme.of(context).primaryColorLight),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
