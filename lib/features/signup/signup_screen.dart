import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interactive_diary/bloc/authentication/signup/google_signup_bloc.dart';
import 'package:interactive_diary/constants/dimens.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

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
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Text(
              IDLocalisation.of(context).idWelcome,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const Gap.v12(),
          SizedBox(
            width: double.infinity,
            child: Text(IDLocalisation.of(context).screenSignUpIntroduction),
          ),
          const Gap.v20(),
          const _IDRegisterForm(),
          const Gap.v20(),
          const IDGoogleSignInButton(),
          const Gap.v12(),
          const _IDAppleSignInButton()
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
      text: IDLocalisation.of(context).btnSignInApple, onPressed: () => _signUpByApple(context));
  }

  void _signUpByApple(BuildContext context) =>
      throw UnimplementedError();
}


class IDGoogleSignInButton extends StatelessWidget {
  const IDGoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleSignupBloc, GoogleSignupState>(
      builder: (BuildContext stateContext, GoogleSignupState googleState) {
        return IDButton(
          text: IDLocalisation.of(context).btnSignInGoogle,
          onPressed: () => _signUpByGoogle(stateContext),
          isBusy: googleState.isSigningUp,
        );
      },
      listener: (BuildContext stateContext, GoogleSignupState googleState) {
        if (googleState.isSignedUpSucceed) {
          _navToHomeScreen(stateContext);
        } else if (googleState.isSignedUpFailed) {
          _showSignUpFailedDialog(stateContext, googleState.failedSignUpError);
        }
      },
    );
  }

  void _signUpByGoogle(BuildContext context) =>
      context.read<GoogleSignupBloc>().add(SignUpByGoogleEvent());
}

Future<T?> _navToHomeScreen<T>(BuildContext context) {
  throw UnimplementedError();
}

Future<T?> _showSignUpFailedDialog<T>(BuildContext context, String error) async {
  throw UnimplementedError();
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
            hint: IDLocalisation.of(context).email,
          ),
          const Gap.v20(),
          IDTextField(
            controller: passCtrl,
            hint: IDLocalisation.of(context).password,
          ),
          const Gap.v20(),
          IDButton(text: IDLocalisation.of(context).signup, onPressed: () => throw UnimplementedError())
        ],
    ));
  }
}
