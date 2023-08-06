import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart';
import '../../pages.dart';

class PasswordInput extends StatelessWidget {
  
  const PasswordInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<UIError>(
        stream: presenter.passwordErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            decoration: InputDecoration(
              labelText: 'Senha',
              icon:
                  Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
              errorText: snapshot.hasData ? snapshot.data.description: null,
            ),
            obscureText: true,
            onChanged: presenter.validatePassword,
          );
        });
  }
}
