import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RegisterBloc() : super(RegisterInitial()) {
    on<CreateAccountEvent>((event, emit) async {
      emit(RegisterLoading());

      try {
        await _auth.createUserWithEmailAndPassword(email: event.email, password: event.password);
        emit(RegisterSuccess());
      } on FirebaseAuthException catch (e) {
        emit(RegisterError(e.message ?? 'An unknown error occurred.'));
      }
    });
  }
}
