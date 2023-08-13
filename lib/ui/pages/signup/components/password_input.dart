import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/pages/signup/signup.dart';

import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart';


class PasswordINput extends StatelessWidget {
  
  const PasswordINput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<UIError>(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          decoration: InputDecoration(
            labelText: R.strings.password,
            icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
            errorText: snapshot.hasData ? snapshot.data.description: null,
          ),
          obscureText: true,
          onChanged: presenter.validatePassword,
        );
      });
  }
}
