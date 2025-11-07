import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forget_password_bloc.dart';
import 'forget_password_event.dart';
import 'forget_password_state.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filledButtonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
      backgroundColor: AppColors.yellowColor,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );

    return BlocProvider(
      create: (context) => ForgetPasswordBloc(),
      child: Builder(
        builder: (context) {
          final locale = AppLocalizations.of(context)!;

          return Scaffold(
            backgroundColor: AppColors.darkBackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                locale.forgetPasswordTitle,
                style: const TextStyle(color: AppColors.yellowColor, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(child: CircularProgressIndicator()),
                  );
                } else if (state is ForgetPasswordSuccess) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Password reset link sent! Check your email.'),
                    ),
                  );
                  Navigator.pop(context);
                } else if (state is ForgetPasswordError) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(backgroundColor: Colors.red, content: Text(state.errorMessage)),
                  );
                }
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset('assets/icon/Forgot password.png', height: 250),
                          const SizedBox(height: 50),
                          CustomTextFormField(
                            controller: _emailController,
                            hintText: locale.email,
                            prefixIcon: Icons.email_outlined,
                            validator: (value) {
                              if (value == null || value.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            style: filledButtonStyle,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<ForgetPasswordBloc>().add(
                                  SendResetPasswordEvent(email: _emailController.text.trim()),
                                );
                              }
                            },
                            child: Text(locale.verifyEmail),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
