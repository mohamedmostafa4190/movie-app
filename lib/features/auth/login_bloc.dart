import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '96197216860-fudtpis5u8sdd50nl283fc2sprfh49bp.apps.googleusercontent.com',
  );

  LoginBloc() : super(LoginInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        await _auth.signInWithEmailAndPassword(email: event.email, password: event.password);
        emit(LoginSuccess());
      } on FirebaseAuthException catch (e) {
        emit(LoginError(e.message ?? 'An unknown error occurred.'));
      }
    });

    on<SignInWithGoogleEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          emit(LoginInitial());
          return;
        }
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });
  }
}
