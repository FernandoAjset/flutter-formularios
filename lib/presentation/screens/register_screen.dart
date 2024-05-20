import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Nuevo usuario'),
          ),
          body: const _RegisterView()),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlutterLogo(
                size: 50,
              ),
              SizedBox(height: 20),
              _RegisterForm(),
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre de usuario',
            prefixIcon: const Icon(Icons.person),
            onChanged: (value) {
              registerCubit.usernameChanged(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().isEmpty) {
                return 'El nombre de usuario es requerido';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 35,
          ),
          CustomTextFormField(
            label: 'Correo electrónico',
            prefixIcon: const Icon(
              Icons.email,
            ),
            onChanged: (value) {
              registerCubit.emailChanged(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().isEmpty) {
                return 'El correo es requerido';
              }

              final emailRegExp = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              );

              if (!emailRegExp.hasMatch(value)) {
                return 'El correo no es válido';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 35,
          ),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            prefixIcon: const Icon(
              Icons.security,
            ),
            onChanged: (value) {
              registerCubit.passwordChanged(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().isEmpty) {
                return 'La contraseña es requerido';
              }

              if (value.length < 8 || value.trim().length < 8) {
                return 'La contraseña debe tener al menos 8 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          FilledButton.tonalIcon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  registerCubit.onSubmit();
                }
                return;
              },
              icon: const Icon(Icons.save),
              label: const Text('Crear usuario')),
        ],
      ),
    );
  }
}
