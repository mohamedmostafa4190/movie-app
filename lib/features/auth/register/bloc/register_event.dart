import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class CreateAccountEvent extends RegisterEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String confirmPassword;
  final int avaterId;

  const CreateAccountEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.confirmPassword,
    required this.avaterId,
  });

  @override
  List<Object> get props => [email, password, name];
}
