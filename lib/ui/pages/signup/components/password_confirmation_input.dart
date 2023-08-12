import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Theme.of(context).primaryColorLight),
      decoration: InputDecoration(
        labelText: R.strings.confirmpassword,
        icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
      ),
      obscureText: true,
    );
  }
}
