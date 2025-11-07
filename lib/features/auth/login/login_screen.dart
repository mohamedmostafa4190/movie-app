import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/provider/app_provider.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/app_routes.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final appProvider = Provider.of<AppProvider>(context);

    final filledButtonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
      backgroundColor: AppColors.yellowColor,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );

    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.darkBackgroundColor,
            body: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                } else if (state is LoginSuccess) {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
                } else if (state is LoginError) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(state.errorMessage),
                    ),
                  );
                }
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 40.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            'assets/icon/316662-P9J1RJ-122 1.png',
                            height: 100,
                          ),
                          const SizedBox(height: 50),
                          CustomTextFormField(
                            controller: _emailController,
                            hintText: locale.email,
                            prefixIcon: Icons.email_outlined,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: _passwordController,
                            hintText: locale.password,
                            prefixIcon: Icons.lock_outline,
                            obscureText: !_isPasswordVisible,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.lightTextColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.forgetPasswordRoute,
                                );
                              },
                              child: Text(
                                locale.forgetPassword,
                                style: const TextStyle(
                                  color: AppColors.lightTextColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: filledButtonStyle,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                  SignInEvent(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                            child: Text(locale.login),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                locale.dontHaveAccount,
                                style: const TextStyle(
                                  color: AppColors.lightTextColor,
                                  fontSize: 14,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.registerRoute,
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  locale.createOne,
                                  style: const TextStyle(
                                    color: AppColors.yellowColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppColors.textFieldColor,
                                  thickness: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Text(
                                  locale.or,
                                  style: const TextStyle(
                                    color: AppColors.lightTextColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColors.textFieldColor,
                                  thickness: 2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            style: filledButtonStyle,
                            onPressed: () {
                              context.read<LoginBloc>().add(
                                const SignInWithGoogleEvent(),
                              );
                            },
                            icon: SvgPicture.asset(
                              'assets/icon/icon_google.svg',
                              width: 20,
                              height: 20,
                            ),
                            label: Text(locale.loginWithGoogle),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: AnimatedToggleSwitch<String>.rolling(
                              current: appProvider.currentLocale.languageCode,
                              values: const ['en', 'ar'],
                              iconList: [
                                _buildFlagCircle('assets/icon/LR.png'),
                                _buildFlagCircle('assets/icon/EG.png'),
                              ],
                              onChanged: (value) {
                                appProvider.changeLanguage(value);
                              },
                              spacing: 8.0,
                              style: const ToggleStyle(
                                backgroundColor: Colors.transparent,
                                borderColor: AppColors.yellowColor,
                                indicatorColor: AppColors.yellowColor,
                              ),
                              height: 40,
                              indicatorSize: const Size(36, 36),
                            ),
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

  Widget _buildFlagCircle(String imagePath) {
    return ClipOval(
      child: Image.asset(imagePath, width: 32, height: 32, fit: BoxFit.cover),
    );
  }
}
