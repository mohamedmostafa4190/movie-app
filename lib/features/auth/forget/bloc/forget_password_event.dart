import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendResetPasswordEvent extends ForgetPasswordEvent {
  final String email;

  const SendResetPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}
