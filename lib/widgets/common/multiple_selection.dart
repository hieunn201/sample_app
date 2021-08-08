import 'package:flutter/material.dart';
import 'package:sample_app/app_localizations/app_localizations.dart';
import 'basic_dialog.dart';
import '../../resources/resources.dart';
import 'divider.dart';

class MultipleSelection<T> extends StatefulWidget {
  final List<T> items;
  final List<T> initialValue;
  final String Function(T) valueShow;
  final ValueChanged<List<T>> onChanged;
  final bool Function(T t1, T t2) compare;
  final EdgeInsetsGeometry padding;
  final int maxSelectedItem;

  const MultipleSelection({
    Key key,
    this.initialValue,
    this.compare,
    this.onChanged,
    this.padding,
    this.maxSelectedItem,
    @required this.items,
    @required this.valueShow,
  })  : assert(items != null),
        assert(valueShow != null),
        super(key: key);

  @override
  _MultipleSelectionState<T> createState() => _MultipleSelectionState();
}

class _MultipleSelectionState<T> extends State<MultipleSelection<T>> {
  final List<T> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    this._selectedItems.addAll(widget.initialValue ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => _buildItem(widget.items[index]),
      itemCount: widget.items.length,
      separatorBuilder: (context, index) => HorizontalDivider(),
    );
  }

  Widget _buildItem(T item) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.bodyText2;

    final isSelected = _selectedItems.any((e) => widget.compare?.call(e, item) ?? e == item);

    return GestureDetector(
      onTap: () async {
        if (isSelected) {
          _selectedItems.removeWhere((e) => widget.compare?.call(e, item) ?? e == item);
        } else {
          if (widget.maxSelectedItem != null && widget.maxSelectedItem != 0 && _selectedItems.length >= widget.maxSelectedItem) {
              await BasicDialog.show(context, positiveButton: BasicDialogButton('OK'), message: AppLocalizations.of(context).text(Message.maximum_item_selected));
          } else {
            _selectedItems.add(item);
          }
        }
        setState(() {
        });

        widget.onChanged?.call(this._selectedItems);
      },
      child: Container(
        color: Colors.transparent,
        padding: widget.padding ?? const EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.valueShow?.call(item),
                style: textTheme,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: Dimens.size32,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: SizedBox(
                height: Dimens.size20,
                width: Dimens.size20,
                child: isSelected ?? false
                    ? Icon(
                        Icons.radio_button_checked_rounded,
                        color: theme.primaryColorDark,
                      )
                    : Icon(
                        Icons.radio_button_off_rounded,
                        color: theme.primaryColorDark,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
