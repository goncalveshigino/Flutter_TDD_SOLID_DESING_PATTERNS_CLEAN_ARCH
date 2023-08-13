import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart';
import '../signup.dart';

class ConfirmPasswordInput extends StatelessWidget {

  const ConfirmPasswordInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<UIError>(
      stream: presenter.confirmPasswordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          decoration: InputDecoration(
            labelText: R.strings.confirmpassword,
            icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
            errorText: snapshot.hasData ? snapshot.data.description: null,
          ),
          obscureText: true,
          onChanged: presenter.validatePasswordConfirmation,
        );
      }
    );
  }
}
