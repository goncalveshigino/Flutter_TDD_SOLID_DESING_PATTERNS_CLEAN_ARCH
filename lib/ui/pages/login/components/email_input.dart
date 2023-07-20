import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import '../../pages.dart';

class EmailInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String>(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          decoration: InputDecoration(
            labelText: 'Senha',
            icon: Icon(Icons.lock,color: Theme.of(context).primaryColorLight),
            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
          ),
          obscureText: true,
          onChanged: presenter.validatePassword,
        );
      }
    );
  }
}
