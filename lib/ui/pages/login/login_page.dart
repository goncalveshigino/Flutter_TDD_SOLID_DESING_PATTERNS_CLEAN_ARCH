import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../utils/i18n/i18n.dart';
import '../pages.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter, {Key key}) : super(key: key);

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

          if (isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }

        });

        presenter.mainErrorStream.listen((error) {
          if (error != null) {
            showErrorMessage(context, error.description);
          }
        });

        presenter.navigateToStream.listen((page) {
          if (page?.isNotEmpty == true) {
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
                  'Login'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Provider(
                  create: (_) => presenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32,top:32,right: 32),
                    child: Form(
                      child: Column(
                        children: [
                          const EmailInput(),
                          const Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 32),
                            child: PasswordInput(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                         const LoginButton(),
                          const SizedBox(height: 11),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.person,
                              color: Theme.of(context).primaryColorLight,
                            ),
                            label: Text(
                              R.strings.addAccount,
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
