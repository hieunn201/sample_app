import 'package:data/data.dart';
import 'package:flutter/material.dart';
import '../../resources/resources.dart';
import '../../extensions/extension.dart';
import '../../app_localizations/app_localizations.dart';
import '../widgets.dart';

class ExtraWidget extends StatelessWidget {
  final Extra model;
  final Function(Extra, List<ExtraItem>) onChanged;
  const ExtraWidget({
    Key key,
    this.model,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    return Column(
      children: [
        Container(
          color: theme.dividerColor,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size20, vertical: Dimens.size26),
          child: RichText(
            text: TextSpan(style: theme.textTheme.subtitle1.regular, children: [
              TextSpan(text: '${model?.name?.toUpperCase() ?? ''} '),
              if (model.min > 0)
                TextSpan(
                    text: localizations.text(UI.required).toUpperCase().closureFormat(),
                    style: theme.textTheme.subtitle1),
            ]),
          ),
        ),
        if (model.min > 0)
          Container(
            color: theme.primaryColorLight.withOpacity(0.3),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.size20, vertical: Dimens.size16),
            child: Text(
              localizations.text(UI.select_option, args: [model.min]),
              style: theme.textTheme.subtitle2,
            ),
          ),
        MultipleSelection<ExtraItem>(
          padding: const EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size20),
          items: model?.items ?? [],
          valueShow: (item) => item.name,
          onChanged: (items) => onChanged?.call(model, items),
          compare: (i1, i2) => i1?.id == i2?.id,
          maxSelectedItem: model?.max,
        ),
      ],
    );
  }
}
