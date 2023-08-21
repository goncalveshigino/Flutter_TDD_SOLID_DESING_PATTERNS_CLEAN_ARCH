import 'package:flutter/material.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/helpers/helpers.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/pages/signup/signup.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../pages.dart';

class SignUpPage extends StatelessWidget {
  
  final SignUpPresenter presenter;

   const SignUpPage(this.presenter, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void _hadeKeyBorde() {
      final currecntFocus = FocusScope.of(context);
      if (!currecntFocus.hasPrimaryFocus) {
        currecntFocus.unfocus();
      }
    }

    return Scaffold(
      body: Builder(builder: (context) {


        presenter.isLoadingStream.listen((isLoading) {
            if ( isLoading == true ) {
              showLoading(context);
            }else{
              hideLoading(context);
            }
        });

        presenter.mainErrorStream.listen((error){
          if ( error != null ) {
            showErrorMessage(context, error.description);
          }
        });

        presenter.navigateToStream.listen((page){
          if ( page?.isNotEmpty == true ) {
            Get.offAllNamed(page);
          }

        });

        return GestureDetector(
          onTap: _hadeKeyBorde,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const HeaderLogin(),
                Text(
                  'SignUp'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Provider(
                    create: (_) => presenter,
                    child: Form(
                      child: Column(
                        children: [
                          const NameInput(),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: EmailINput()),
                          const PasswordINput(),
                          const Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 32),
                            child: ConfirmPasswordInput(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SignUpButton(),
                          const SizedBox(height: 11),
                          TextButton.icon(
                            onPressed: presenter.goToLogin,
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Theme.of(context).primaryColorLight,
                            ),
                            label: Text(
                              R.strings.login,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
