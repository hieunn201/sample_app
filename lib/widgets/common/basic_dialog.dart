import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/app_localizations/localizations.dart';

import '../../resources/resources.dart';
import '../../extensions/extension.dart';

class BasicDialogButton<T> {
  final String label;
  final Function action;

  BasicDialogButton(this.label, {this.action});
}

class BasicDialog extends StatelessWidget {
  final String title;
  final String message;
  final BasicDialogButton positiveButton;
  final BasicDialogButton negativeButton;
  final Color backgroundColor;
  static bool _isOpen;

  static bool get isOpen => _isOpen ?? false;

  BasicDialog._internal({
    this.title,
    this.message,
    this.positiveButton,
    this.negativeButton,
    this.backgroundColor,
  });

  static Future<bool> show(
    BuildContext context, {
    String title,
    String message,
    @required BasicDialogButton positiveButton,
    BasicDialogButton negativeButton,
    Color backgroundColor,
  }) async {
    if (isOpen) return null;

    _isOpen = true;

    final result = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      useRootNavigator: true,
      pageBuilder: (context, anim1, anim2) => Container(),
      barrierColor: Colors.black.withOpacity(0.7),
      barrierLabel: '',
      transitionBuilder: (context, anim1, anim2, child) => Transform.scale(
        scale: anim1.value,
        child: Opacity(
          opacity: anim1.value,
          child: BasicDialog._internal(
            title: title,
            message: message,
            positiveButton: positiveButton,
            negativeButton: negativeButton,
            backgroundColor: backgroundColor,
          ),
        ),
      ),
    );

    _isOpen = false;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final List<Widget> actions = [];
    if (negativeButton != null) {
      actions.addAll([
        Expanded(
          child: _buildNegativeButton(
            context,
            label: negativeButton?.label,
            onPressed: negativeButton?.action,
          ),
        ),
        const SizedBox(
          width: Dimens.size8,
        ),
        Expanded(
          child: _buildPositiveButton(
            context,
            label: positiveButton?.label,
            onPressed: positiveButton?.action,
          ),
        ),
      ]);
    } else {
      actions.add(const Expanded(child: SizedBox()));
      actions.add(Expanded(
        flex: 2,
        child: _buildPositiveButton(
          context,
          label: positiveButton?.label,
          onPressed: positiveButton?.action,
        ),
      ));
      actions.add(const Expanded(child: SizedBox()));
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        elevation: 10,
        titleTextStyle: theme.textTheme.bodyText1.size16.bold,
        title: Text(
          title ?? '',
          textAlign: TextAlign.center,
        ),
        titlePadding: const EdgeInsets.all(Dimens.size16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
              constraints: BoxConstraints(
                maxHeight: screenSize.height / 3 * 2,
              ),
              child: Text(
                message ?? '',
                style: theme.textTheme.caption.size14,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: Dimens.size4,
            ),
            Container(
              padding: const EdgeInsets.all(Dimens.size16),
              child: Row(children: actions, mainAxisAlignment: MainAxisAlignment.center),
            ),
          ],
        ),
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.size10)),
        backgroundColor: backgroundColor,
      ),
    );
  }

  Widget _buildPositiveButton(BuildContext context, {String label, Function onPressed}) {
    return _buildButton(
      context,
      label ?? 'OK',
      () {
        Navigator.pop(context, true);
        onPressed?.call();
        _isOpen = false;
      },
    );
  }

  Widget _buildNegativeButton(BuildContext context, {String label, VoidCallback onPressed}) {
    return _buildButton(
      context,
      label ?? 'Cancel',
      () {
        Navigator.pop(context, false);
        onPressed?.call();
        _isOpen = false;
      },
    );
  }

  Widget _buildButton(BuildContext context, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.size6),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.size12,
            vertical: Dimens.size12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyText2.medium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
