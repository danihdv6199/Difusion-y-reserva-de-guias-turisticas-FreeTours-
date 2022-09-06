import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:freetour_tfg/features/app/notifications/notifications.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:freetour_tfg/features/services.dart';

class DeleteUserScreen extends StatefulWidget {
  const DeleteUserScreen({Key? key}) : super(key: key);

  @override
  State<DeleteUserScreen> createState() => _DeleteUserScreenState();
}

class _DeleteUserScreenState extends State<DeleteUserScreen> {
  String pass = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as UserModel;
    GlobalKey<FormState> formDelete = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(title: const Text('Eliminar Perfil'), centerTitle: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Form(
              key: formDelete,
              child: Column(children: [
                const SizedBox(height: 25),
                const Center(
                  child: Image(
                      image: AssetImage('assets/triste.png'),
                      width: 150,
                      height: 150),
                ),
                const SizedBox(height: 25),
                Text(
                  'Para eliminar tu perfil es necesario ingresa tu contraseña.',
                  style: context.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                TextFormField(
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        hintStyle: context.bodySmall, hintText: 'Contraseña'),
                    onChanged: (value) => pass = value,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Ingrese su contraseña';
                      } else {
                        return null;
                      }
                    },
                    style: context.bodyLarge),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () {
                      if (formDelete.currentState!.validate()) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return DeletePerfil(
                                  email: arg.email!, pass: pass);
                            });
                      }
                    },
                    child: Text('Eliminar Perfil', style: context.titleSmall)),
              ]),
            ),
          ),
        ));
  }
}

class DeletePerfil extends StatelessWidget {
  const DeletePerfil({
    Key? key,
    required this.pass,
    required this.email,
  }) : super(key: key);
  final String pass;
  final String email;
  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context, listen: false);
    return AlertDialog(
      title: Text(
        'Eliminar Perfil',
        style: context.bodyMedium,
      ),
      content: Text(
          'Si presiona "Eliminar Perfil" se borran su usuario e información de forma permanente',
          style: context.bodyMedium),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () async {
              final resp = await authservice.deleteAcount(email, pass);
              if (resp == 'success') {
                Navigator.pushReplacementNamed(context, 'login');
              } else {
                NotificationProvider.warningAlert(resp);
              }
            },
            child: const Text(
              'Eliminar Perfil',
            ))
      ],
    );
  }
}
