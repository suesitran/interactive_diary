import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interactive_diary/bloc/authentication/signup/google_signup_bloc.dart';
import 'package:interactive_diary/constants/dimens.dart';
import 'package:interactive_diary/features/home/home_screen.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: Dimension.screenEdgeSpacing),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          SizedBox(
            width: double.infinity,
            child: Text(
              'Welcome to Interactive Dairy',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Gap.v12(),
          SizedBox(
            width: double.infinity,
            child: Text("Let's join us to create your journey"),
          ),
          Gap.v20(),
          _IDRegisterForm(),
          Gap.v20(),
          IDGoogleSignInButton(),
          Gap.v12(),
          _IDAppleSignInButton()
        ],
      ),
    );
  }
}

class _IDAppleSignInButton extends StatelessWidget {
  const _IDAppleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IDButton(
        text: 'Continue with AppleId', onPressed: () => print('apple id'));
  }

  void _signUpByFacebook(BuildContext context) =>
      context.read<GoogleSignupBloc>().add(SignUpByGoogleEvent());
}


class IDGoogleSignInButton extends StatelessWidget {
  const IDGoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleSignupBloc, GoogleSignupState>(
      builder: (BuildContext stateContext, GoogleSignupState googleState) {
        return IDButton(
          text: 'Continue with Google',
          onPressed: () => _signUpByGoogle(stateContext),
          isBusy: googleState.isSigningUp,
        );
      },
      listener: (BuildContext stateContext, GoogleSignupState googleState) {
        if (googleState.isSignedSucceed) {
          _navToHomeScreen(stateContext);
        } else if (googleState.isSignedFailed) {
          _showSignUpFailedDialog(stateContext, googleState.failedError);
        }
      },
    );
  }

  void _signUpByGoogle(BuildContext context) =>
      context.read<GoogleSignupBloc>().add(SignUpByGoogleEvent());
}

Future<T?> _navToHomeScreen<T>(BuildContext context) {
  return Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (_) => const IDHome()));
}

Future<T?> _showSignUpFailedDialog<T>(BuildContext context, String error) async {
  return showDialog(context: context, builder: (_) {
    return
      AlertDialog(
        title: const Text('Signup not succeed'),
        content: Text(error),
        actions: [
          IDButton(text: 'I understand', onPressed: () => Navigator.of(context).pop()),
        ],
      );
  });
}


class _IDRegisterForm extends HookWidget {
  const _IDRegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailCtrl = useTextEditingController();
    final TextEditingController passCtrl = useTextEditingController();
    return Form(
      child: Column(
        children: <Widget>[
          IDTextField(
            controller: emailCtrl,
            hint: 'Email',
          ),
          const Gap.v20(),
          IDTextField(
            controller: passCtrl,
            hint: 'Password',
          ),
          const Gap.v20(),
          IDButton(text: 'Register', onPressed: () => print('REGISTER'))
        ],
    ));
  }
}

/// ================== Widgets ==================
class Gap extends StatelessWidget {
  final double? vGap;
  final double? hGap;
  const Gap.v20({Key? key})
      : vGap = 20.0,
        hGap = 0.0,
        super(key: key);
  const Gap.v16({Key? key})
      : vGap = 16.0,
        hGap = 0.0,
        super(key: key);
  const Gap.v12({Key? key})
      : vGap = 12.0,
        hGap = 0.0,
        super(key: key);
  const Gap.v08({Key? key})
      : vGap = 8.0,
        hGap = 0.0,
        super(key: key);
  const Gap.v04({Key? key})
      : vGap = 4.0,
        hGap = 0.0,
        super(key: key);

  const Gap.h20({Key? key})
      : hGap = 20.0,
        vGap = 0.0,
        super(key: key);
  const Gap.h16({Key? key})
      : hGap = 16.0,
        vGap = 0.0,
        super(key: key);
  const Gap.h12({Key? key})
      : hGap = 12.0,
        vGap = 0.0,
        super(key: key);
  const Gap.h08({Key? key})
      : hGap = 8.0,
        vGap = 0.0,
        super(key: key);
  const Gap.h04({Key? key})
      : hGap = 4.0,
        vGap = 0.0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: vGap,
      width: hGap,
    );
  }
}

class IDButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool? isBusy;
  const IDButton({required this.text, required this.onPressed, Key? key, this.isBusy = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const SizedBox(),
      onPressed: onPressed,
      label: isBusy! ? const CircularProgressIndicator() : Text(text),
      style: TextButton.styleFrom(
        maximumSize: const Size(double.infinity, 46),
        minimumSize: const Size(200, 46),
        elevation: 1,
        primary: Colors.black),
    );
  }
}

class IDTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefix;
  final bool? autoFocus;
  const IDTextFormField(
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

class IDTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefix;
  final bool? autoFocus;
  const IDTextField(
      {Key? key,
      required this.controller,
      required this.hint,
      this.prefix,
      this.autoFocus = false})
      : super(key: key);
  const IDTextField.adaptive(
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
