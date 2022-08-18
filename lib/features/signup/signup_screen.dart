import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interactive_diary/bloc/authentication/signup/google_signup_bloc.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

const double kspEdge = 12.0;

class IDSignUp extends Screen {
  const IDSignUp({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) {
    return BlocProvider<GoogleSignupBloc>(
      create: (_) => GoogleSignupBloc(),
      child: const _IDSignUpBody(),
    );
  }
}

class _IDSignUpBody extends StatelessWidget {
  const _IDSignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kspEdge),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            width: double.infinity,
            child: Text(
              'Welcome to Interactive Dairy',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const Gap.v12(),
          const SizedBox(
            width: double.infinity,
            child: Text("Let's join us to create your journey"),
          ),
          const Gap.v20(),
          _RegisterForm(),
          const Gap.v20(),
          BlocBuilder<GoogleSignupBloc, GoogleSignupState>(
            builder: (_, GoogleSignupState googleState) {
              String text = 'Continue with Google';
              Function() onPressed = () => _signUpByGoogle(context);
              if (googleState is GoogleSigningUp) {
                text = 'Signing Up';
                onPressed = () {};
              }
              return AButton(
                text: text,
                onPressed: onPressed);
            }
          ),
          AButton(
              text: 'Continue with Facebook', onPressed: () => print('Google'))
        ],
      ),
    );
  }
  
  void _signUpByGoogle(BuildContext context) =>
    context.read<GoogleSignupBloc>().add(SignUpByGoogle());

  void _signUpByFacebook(BuildContext context) =>
      context.read<GoogleSignupBloc>().add(SignUpByGoogle());
}

class _RegisterForm extends HookWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailCtrl = useTextEditingController();
    final TextEditingController passCtrl = useTextEditingController();
    return Form(
        child: Column(
      children: <Widget>[
        ATextField(
          controller: emailCtrl,
          hint: 'Email',
        ),
        const Gap.v20(),
        ATextField(
          controller: passCtrl,
          hint: 'Password',
        ),
        const Gap.v20(),
        AButton(text: 'Register', onPressed: () => print('REGISTER'))
      ],
    ));
  }
}

/// ================== Widgets ==================
class Gap extends StatelessWidget {
  final double? vGap;
  final double? hGap;
  const Gap.v20({Key? key}) : vGap = 20.0, hGap = 0.0, super(key: key);
  const Gap.v16({Key? key}) : vGap = 16.0, hGap = 0.0, super(key: key);
  const Gap.v12({Key? key}) : vGap = 12.0, hGap = 0.0, super(key: key);
  const Gap.v08({Key? key}) : vGap = 8.0, hGap = 0.0, super(key: key);
  const Gap.v04({Key? key}) : vGap = 4.0, hGap = 0.0, super(key: key);

  const Gap.h20({Key? key}) : hGap = 20.0, vGap = 0.0, super(key: key);
  const Gap.h16({Key? key}) : hGap = 16.0, vGap = 0.0, super(key: key);
  const Gap.h12({Key? key}) : hGap = 12.0, vGap = 0.0, super(key: key);
  const Gap.h08({Key? key}) : hGap = 8.0, vGap = 0.0, super(key: key);
  const Gap.h04({Key? key}) : hGap = 4.0, vGap = 0.0, super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: vGap, width: hGap,);
  }
}

class AButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const AButton({required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(Icons.abc_outlined),
      onPressed: onPressed,
      label: Text(text),
      style: TextButton.styleFrom(
          primary: Colors.black, backgroundColor: Colors.green),
    );
  }
}

class ATextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefix;
  final bool? autoFocus;
  const ATextFormField({
    Key? key,
    required this.controller,
    required this.hint,
    this.prefix,
    this.autoFocus = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return _buildCupertino();
    }
    return _buildMaterial();
  }

  CupertinoTextFormFieldRow _buildCupertino() {
    return CupertinoTextFormFieldRow(
      controller: controller,
      placeholder: hint,
      autofocus: autoFocus!,
      prefix: prefix,
      decoration: BoxDecoration(),
    );
  }

  TextFormField _buildMaterial() {
    return TextFormField(
      controller: controller,
      autofocus: autoFocus!,
      decoration: InputDecoration(prefix: prefix),
    );
  }
}

class ATextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefix;
  final bool? autoFocus;
  const ATextField(
      {Key? key,
      required this.controller,
      required this.hint,
      this.prefix,
      this.autoFocus = false})
      : super(key: key);
  const ATextField.adaptive(
      {Key? key,
      required this.controller,
      required this.hint,
      this.prefix,
      this.autoFocus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return _buildCupertino();
    }
    return _buildMaterial();
  }

  CupertinoTextField _buildCupertino() {
    return CupertinoTextField(
      controller: controller,
      placeholder: hint,
      autofocus: autoFocus!,
      prefix: prefix,
      decoration: BoxDecoration(),
    );
  }

  TextField _buildMaterial() {
    return TextField(
      controller: controller,
      autofocus: autoFocus!,
      decoration: InputDecoration(prefix: prefix),
    );
  }
}
