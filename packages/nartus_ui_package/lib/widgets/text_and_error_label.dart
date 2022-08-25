import 'package:flutter/material.dart';

class TextAndErrorLabel extends StatelessWidget {
  final String _label;
  final String? _error;

  const TextAndErrorLabel({Key? key, required String label, String? error})
      : _label = label,
        _error = error,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(23)),
      ),
      color: Theme.of(context).backgroundColor,
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: const BorderRadius.all(Radius.circular(23))),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: const BorderRadius.all(Radius.circular(23))),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Text(_label, style: Theme.of(context).textTheme.headline6),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  _error!,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: Theme.of(context).colorScheme.onError),
                ),
              )
          ],
        ),
      ),
    );
  }
}
