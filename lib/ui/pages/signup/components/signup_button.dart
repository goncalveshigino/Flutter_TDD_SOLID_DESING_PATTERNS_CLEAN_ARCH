import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/pages/signup/signup.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart';


class SignUpButton extends StatelessWidget {
  const SignUpButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<bool>(
        stream: presenter.isFormValidStream,
        builder: (context, snapshot) {
          return ElevatedButton(
            onPressed: snapshot.data == true ? presenter.signUp : null,
            style: ButtonStyle(
              backgroundColor: snapshot.data == true
                  ? MaterialStateProperty.all(Theme.of(context).primaryColor)
                  : null,
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            child: Text(
              R.strings.addAccount,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          );
        });
  }
}
