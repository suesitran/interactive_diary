import 'package:flutter/material.dart';
import 'package:nartus_ui_package/widgets/text_and_error_label.dart';

class TextAndErrorLabelScreen extends StatelessWidget {
  TextAndErrorLabelScreen({Key? key}) : super(key: key);

  final ValueNotifier<String?> error = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text and Error Label demo'),
      ),
      body: Column(
        children: [
          const TextAndErrorLabel(label: '22 August 2022'),
          const SizedBox(height: 8.0,),
          const TextAndErrorLabel(label: '22 August 2022', error: 'No Internet connection',),
          const SizedBox(height: 8.0,),
          ValueListenableBuilder<String?>(valueListenable: error, builder: (context, error, widget) => TextAndErrorLabel(label: '22 August 2022', error: error,),),
          TextButton(onPressed: () {
            if (error.value == null) {
              error.value = 'No Internet connection';
            } else {
              error.value = null;
            }
          }, child: const Text('show/hide error'))
        ],
      ),
    );
  }
}
