import 'package:flutter/material.dart';

import '../pages.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;
  const LoginPage(this.presenter, {Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {

          widget.presenter.isLoadingStream.listen((isLoading){

            if (isLoading) {
              showDialog(
                context: context, 
                barrierDismissible: false, 
                builder: (context) {
                 return SimpleDialog(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(), 
                        SizedBox(height: 10 ),
                        Text('Aguarde... ', textAlign: TextAlign.center,)
                      ],
                    )
                  ],
                 );
                }
              );
            }  else {

              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }

            }

          });


          widget.presenter.mainErrorStream.listen((error){
            if (error != null){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red.shade900,
                  content: Text(error, textAlign: TextAlign.center,)
                )
              );
            }
          });
          

          return SingleChildScrollView(
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

                      StreamBuilder<String>(
                        stream: widget.presenter.emailErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: Icon(Icons.email,
                                  color: Theme.of(context).primaryColorLight),
                              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: widget.presenter.validateEmail,
                          );
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: StreamBuilder<String>(
                          stream: widget.presenter.passwordErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              style: TextStyle(color: Theme.of(context).primaryColorLight),
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                icon: Icon(Icons.lock,color: Theme.of(context).primaryColorLight),
                                errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                              ),
                              obscureText: true,
                              onChanged: widget.presenter.validatePassword,
                            );
                          }
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                
                      SizedBox(
                        height: 60,
                        width: 200.0,
                        child: StreamBuilder<bool>(
                          stream: widget.presenter.isFormValidStream,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed: snapshot.data == true ? widget.presenter.auth : null,
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
                            );
                          }
                        ),
                      ),

                      const SizedBox(height: 17),

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
          );
        }
      ),
    );
  }
}
