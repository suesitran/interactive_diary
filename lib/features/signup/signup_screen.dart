import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/features/signup/bloc/google_signup_bloc.dart';
import 'package:interactive_diary/constants/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class IDSignUp extends StatelessWidget {
  const IDSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GoogleSignupBloc>(
      create: (_) => GoogleSignupBloc(),
      child: const IDSignUpBody(),
    );
  }
}

class IDSignUpBody extends StatelessWidget {
  const IDSignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimension.spacing12),
      width: double.infinity,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
    return NartusButton.primary(
        label: 'Continue with Apple', onPressed: () => _signUpByApple(context));
  }

  void _signUpByApple(BuildContext context) => () {};
}

class IDGoogleSignInButton extends StatelessWidget {
  const IDGoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleSignupBloc, GoogleSignupState>(
      builder: (BuildContext stateContext, GoogleSignupState googleState) {
        return NartusButton.primary(
          label: 'Continue with Google',
          onPressed: () => _signUpByGoogle(stateContext),
        );
      },
      listener: (BuildContext stateContext, GoogleSignupState googleState) {
        if (googleState.isSignedUpSucceed) {
          // TODO navigate to home screen
        } else if (googleState.isSignedUpFailed) {
          // TODO show sign up failed dialog
        }
      },
    );
  }

  void _signUpByGoogle(BuildContext context) =>
      context.read<GoogleSignupBloc>().signUpGoogle();
}

class _IDRegisterForm extends StatelessWidget {
  const _IDRegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: <Widget>[
        const IDTextField(
          hint: 'Email',
        ),
        const Gap.v20(),
        const IDTextField(
          hint: 'Password',
        ),
        const Gap.v20(),
        NartusButton.primary(label: 'Register', onPressed: () => _register())
      ],
    ));
  }

  void _register() {}
}
