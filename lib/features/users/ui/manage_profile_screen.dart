import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:freetour_tfg/features/app/notifications/notifications.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';

class ManageProfileScreen extends StatefulWidget {
  const ManageProfileScreen({Key? key}) : super(key: key);

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  String _rol = 'Viajero';

  @override
  Widget build(BuildContext context) {
    final userservice = Provider.of<UsersRols>(context);
    final provider = Provider.of<ProfileProvider>(context);
    final user = userservice.loggedInUser;
    provider.name = user.name!;
    provider.email = user.email!;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Datos personales"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: provider.profile,
            child: Column(children: [
              TextFormField(
                initialValue: user.name,
                decoration: decoration('Nombre'),
                onChanged: (value) => provider.name = value,
                validator: (value) => provider.isValidName(value),
              ),
              const SizedBox(height: 15),
              TextFormField(
                initialValue: user.email,
                decoration: decoration('Email'),
                onChanged: (value) => provider.email = value,
                validator: (value) => provider.isValidEmail(value!),
              ),
              const SizedBox(height: 15),
              Text('Tipo de usuario', style: context.bodyMedium),
              const SizedBox(height: 5),
              DropdownButton<String>(
                  value: _rol,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: context.bodyMedium,
                  items: [
                    'Guía',
                    'Viajero',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                        value: value,
                        child: Text(value, style: context.bodyMedium));
                  }).toList(),
                  onChanged: (String? newValue) {
                    _rol = newValue!;
                    setState(() {});
                  }),
              const SizedBox(height: 35),
              ElevatedButton(
                  onPressed: provider.isLoading
                      ? null
                      : () async {
                          if (provider.profile.currentState!.validate()) {
                            final authModel = Provider.of<AuthService>(context,
                                listen: false);

                            FocusScope.of(context).unfocus();

                            if (!provider.isValidForm()) return;

                            provider.isLoading = true;
                            await authModel.editProfile(provider.email,
                                provider.rol = _rol, provider.name, user.userk);

                            NotificationProvider.successAlert(
                                'Se guardaron sus datos');

                            provider.isLoading = false;
                            Navigator.pushReplacementNamed(context, 'checking');
                          }
                        },
                  child: Text('Guardar', style: context.titleSmall)),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, 'deleteUser',
                      arguments: user),
                  child: Text('Eliminar Perfil', style: context.titleSmall)),
            ]),
          ),
        ));
  }

  InputDecoration decoration(String label) {
    return InputDecoration(
        suffixIcon: const Icon(Icons.edit),
        labelText: label,
        labelStyle: context.bodyMedium);
  }
}
