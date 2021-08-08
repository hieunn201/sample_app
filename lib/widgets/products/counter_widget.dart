import 'package:flutter/material.dart';
import '../../resources/resources.dart';

class CounterWidget extends StatelessWidget {
  final int initialValue;
  final int min;
  final int max;
  final double buttonSize;
  final ValueChanged<int> onChanged;
  final MainAxisSize mainAxisSize;

  CounterWidget({
    Key key,
    @required this.initialValue,
    @required this.min,
    @required this.max,
    this.onChanged,
    this.mainAxisSize,
    this.buttonSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    int currentValue = initialValue ?? (min ?? 0);
    final disableDecrease = currentValue <= min;
    final disableIncrease = currentValue >= max;
    final _buttonSize = buttonSize ?? Dimens.size20;
    return Container(
      child: Row(
        mainAxisSize: mainAxisSize,
        children: [
          Card(
            elevation: 0.0,
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: CircleBorder(),
            color: disableDecrease ? theme.dividerColor : theme.primaryColorDark,
            child: GestureDetector(
              onTap: disableDecrease ? null : _decrease,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.size4),
                child: Icon(
                  Icons.remove_rounded,
                  size: _buttonSize,
                  color: disableDecrease ? Colors.grey.shade500 : Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: Dimens.size8,),
          SizedBox(
            width: Dimens.size32,
            child: Text(
              '$initialValue',
              style: theme.textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: Dimens.size8,),
          Card(
            elevation: 0.0,
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: CircleBorder(),
            color: disableIncrease ? theme.dividerColor : theme.primaryColorDark,
            child: GestureDetector(
              onTap: disableIncrease ? null : _increase,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.size4),
                child: Icon(
                  Icons.add_rounded,
                  size: _buttonSize,
                  color: disableIncrease ? Colors.grey.shade500 : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _increase() {
    int minValue = min ?? 0;
    int maxValue = max ?? 10;
    int currentValue = initialValue ?? minValue;
    currentValue += 1;
    if (currentValue > maxValue) currentValue = maxValue;
    onChanged?.call(currentValue);
  }

  void _decrease() {
    int minValue = min ?? 0;
    int currentValue = initialValue ?? minValue;
    currentValue -= 1;
    if (currentValue < minValue) currentValue = minValue;
    onChanged?.call(currentValue);
  }
}
