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

  const CreateAccountEvent({required this.email, required this.password, required this.name});

  @override
  List<Object> get props => [email, password, name];
}
