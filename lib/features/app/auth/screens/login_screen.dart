import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:freetour_tfg/features/app/notifications/notifications.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/screens.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:freetour_tfg/features/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoginBackgound(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 250,
          ),
          CardContainer(
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Text('Bienvenido', style: context.titleLarge),
              const SizedBox(
                height: 30,
              ),
              const _LoginForm()
            ]),
          ),
          const SizedBox(
            height: 60,
          ),
          Text("¿No tienes cuenta?", style: context.titleSmall),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'register'),
                child: Text('Crear cuenta', style: context.titleSmall)),
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
        key: loginForm.lForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              cursorColor: context.colors.surface,
              decoration: InputDecoration(
                  hintText: 'juan@email.com', hintStyle: context.bodySmall),
              style: context.bodyMedium,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => loginForm.email = value,
              validator: (value) => loginForm.isValidEmail(value!),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'password', hintStyle: context.bodySmall),
              style: context.bodyMedium,
              textInputAction: TextInputAction.done,
              onChanged: (value) => loginForm.password = value,
              validator: (value) => loginForm.isValidPassword(value!),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ForgotPassScreen();
                      }));
                    },
                    child: Text("¿Contraseña olvidada?",
                        style: context.bodyMedium)),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Ingresar',
                  style: context.titleSmall,
                ),
                onPressed: () async {
                  final authModel =
                      Provider.of<AuthService>(context, listen: false);
                  if (loginForm.lForm.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    loginForm.isLoading = true;
                    final String? resp = await authModel.login(
                        loginForm.email, loginForm.password);
                    if (resp == null) {
                      loginForm.isLoading = false;
                      Navigator.pushReplacementNamed(context, 'checking');
                    } else {
                      loginForm.isLoading = false;
                      NotificationProvider.warningAlert(resp);
                    }
                  } else {
                    loginForm.isLoading = false;
                  }
                })
          ],
        ));
  }
}
