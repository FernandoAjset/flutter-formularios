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
  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final email = registerCubit.state.email;
    final password = registerCubit.state.password;

    return Form(
      child: Column(
        children: [
          CustomTextFormField(
              label: 'Nombre de usuario',
              prefixIcon: const Icon(Icons.person),
              onChanged: registerCubit.usernameChanged,
              errorMessage: username.errorMessage),
          const SizedBox(
            height: 35,
          ),
          CustomTextFormField(
            label: 'Correo electrónico',
            prefixIcon: const Icon(
              Icons.email,
            ),
            onChanged: registerCubit.emailChanged,
            errorMessage: email.errorMessage,
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
              onChanged: registerCubit.passwordChanged,
              errorMessage: password.errorMessage),
          const SizedBox(
            height: 20,
          ),
          FilledButton.tonalIcon(
              onPressed: () {
                registerCubit.onSubmit();
              },
              icon: const Icon(Icons.save),
              label: const Text('Crear usuario')),
        ],
      ),
    );
  }
}
