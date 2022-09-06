import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/app/notifications/notifications.dart';

import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:provider/provider.dart';

import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
              const SizedBox(height: 10),
              Text(
                'Crear cuenta',
                style: context.titleLarge,
              ),
              const SizedBox(height: 30),
              const _RegisterForm(),
            ]),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿Ya tienes una cuenta?', style: context.titleSmall),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    )));
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

var options = [
  'Viajero',
  'Guía',
];
var _currentItemSelected = "Viajero";
var _rol = "Guía";

class _RegisterFormState extends State<_RegisterForm> {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<RegisterFormProvider>(context);

    return Form(
        key: loginForm.registerForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: true,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              onChanged: (value) => loginForm.name = value,
              validator: (value) => loginForm.isValidName(value!),
              decoration: InputDecoration(
                  hintText: 'Juan Perez', hintStyle: context.bodySmall),
              style: context.bodyMedium,
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => loginForm.email = value,
              validator: (value) => loginForm.isValidEmail(value!),
              decoration: InputDecoration(
                  hintText: 'juan@email.com', hintStyle: context.bodySmall),
              style: context.bodyMedium,
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'password', hintStyle: context.bodySmall),
              style: context.bodyMedium,
              textInputAction: TextInputAction.next,
              onChanged: (value) => loginForm.password = value,
              validator: (value) => loginForm.isValidPassword(value!),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: ' repite password', hintStyle: context.bodySmall),
              style: context.bodyMedium,
              textInputAction: TextInputAction.done,
              validator: (value) => loginForm.isValidPassword(value!),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Tipo de usuario : ",
                  style: context.bodyMedium,
                ),
                DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: context.colors.background.withOpacity(0.8),
                  isDense: true,
                  isExpanded: false,
                  iconEnabledColor: context.colors.primary,
                  items: options.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(
                        dropDownStringItem,
                        style: context.bodyMedium,
                      ),
                    );
                  }).toList(),
                  onChanged: (newValueSelected) {
                    setState(() {
                      _currentItemSelected = newValueSelected!;
                      _rol = newValueSelected;
                    });
                  },
                  value: _currentItemSelected,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loginForm.isLoading ? 'Espere' : 'Crear cuenta',
                      style: context.titleSmall,
                    ),
                  ],
                ),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        if (loginForm.registerForm.currentState!.validate()) {
                          final authModel =
                              Provider.of<AuthService>(context, listen: false);
                          FocusScope.of(context).unfocus();
                          if (!loginForm.isValidRegisterForm()) return;

                          loginForm.isLoading = true;

                          final String? resp = await authModel.createUser(
                              loginForm.email,
                              loginForm.password,
                              _rol,
                              loginForm.name);
                          if (resp == null) {
                            //registro correcto
                            Navigator.pushReplacementNamed(context, 'login');
                          } else {
                            NotificationProvider.warningAlert(resp);
                          }
                          loginForm.isLoading = false;
                        }
                      })
          ],
        ));
  }
}
