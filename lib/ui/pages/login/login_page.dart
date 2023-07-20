import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
               showLoading(context);             
            }  else {
             hideLoading(context);
            }

          });


          widget.presenter.mainErrorStream.listen((error){
            if (error != null){
             showErrorMessage(context, error);
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
                Provider(
                  create: (_) => widget.presenter,
                  child: Form(
                    child: Column(
                      children: [
                
                        EmailInput(),
                
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: PasswordInput(),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                
                  
                        SizedBox(
                          height: 60,
                          width: 200.0,
                          child: LoginButton(),
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

