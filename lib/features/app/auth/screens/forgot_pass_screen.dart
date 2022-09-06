import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:freetour_tfg/features/app/notifications/notifications.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  String email = '';
  bool _buttonActive = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Recuperar contraseña'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Image.asset(
              'assets/forgetPass.png',
              width: 150,
            ),
          ),
          Text('Ingrese su correo:', style: context.bodyMedium),
          const SizedBox(height: 25),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Form(
                key: provider.fogetForm,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  style: context.bodyMedium,
                  decoration: InputDecoration(
                      hintText: 'Ingrese su correo aquí',
                      hintStyle: context.bodyMedium),
                  onSaved: (value) => provider.emailForget = value!,
                  validator: (value) => provider.isValidEmailForget(value!),
                  onChanged: (value) {
                    if (provider.fogetForm.currentState!.validate()) {
                      setState(() {
                        provider.fogetForm.currentState!.save();
                        _buttonActive = true;
                      });
                    } else {
                      setState(() {
                        _buttonActive = false;
                      });
                    }
                  },
                ),
              )),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed:
                _buttonActive ? (() => passwordReset(provider, context)) : null,
            child: Text("Recuperar contraseña", style: context.titleSmall),
          ),
        ]),
      ),
    );
  }

  Future passwordReset(LoginFormProvider provider, context) async {
    FocusScope.of(context).unfocus();
    final service = Provider.of<AuthService>(context, listen: false);
    final res = await service.passwordReset(provider.emailForget);
    NotificationProvider.warningAlert(res.toString());
  }
}
