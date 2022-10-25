import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nartus_ui_package/nartus_ui.dart';

class IDTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final Widget? prefix;
  final bool? autoFocus;
  const IDTextFormField(
      {Key? key,
      this.controller,
      this.hint,
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
      decoration: const BoxDecoration(),
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
  final TextEditingController? controller;
  final String? hint;
  final Widget? prefix;
  final bool? autoFocus;
  const IDTextField(
      {Key? key,
      this.controller,
      this.hint,
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
      decoration: const BoxDecoration(),
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
