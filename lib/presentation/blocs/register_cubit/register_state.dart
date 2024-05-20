part of 'register_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

class RegisterFormState extends Equatable {
  final String username;
  final String email;
  final String password;
  final FormStatus formStatus;

  const RegisterFormState(
      {this.username = "",
      this.email = "",
      this.password = "",
      this.formStatus = FormStatus.invalid});

  RegisterFormState copyWith(
          {String? username,
          String? email,
          String? password,
          FormStatus? formStatus}) =>
      RegisterFormState(
          username: username ?? this.username,
          email: email ?? this.email,
          password: password ?? this.password,
          formStatus: formStatus ?? this.formStatus);

  @override
  List<Object> get props => [username, email, password, formStatus];
}
