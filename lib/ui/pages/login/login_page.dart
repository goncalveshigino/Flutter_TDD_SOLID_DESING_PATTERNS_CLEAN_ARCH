import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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
            showErrorMessage(context, error);
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
                const SizedBox(height: 70),
                Text(
                  'Login'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Provider(
                  create: (_) => presenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 32, top: 32, right: 32),
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
                              'Criar conta',
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
