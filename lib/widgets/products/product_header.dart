import '../../extensions/extension.dart';
import '../../resources/resources.dart';
import 'package:flutter/material.dart';

class ListenerAppBar extends StatefulWidget {
  final Widget child;

  const ListenerAppBar({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _ListenerAppBarState createState() => _ListenerAppBarState();
}

class _ListenerAppBarState extends State<ListenerAppBar> {
  ScrollPosition _position;
  bool _visible;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible = settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: widget.child,
    );
  }
}

class ProductHeader extends StatelessWidget {
  final String image;

  const ProductHeader({
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Positioned.fill(
          child: image.isNullOrWhiteSpace
              ? Container(
            width: double.infinity,
            color: theme.primaryColor,
          )
              : Image.network(image, fit: BoxFit.fill),
        ),
        Container(
          color: Colors.transparent,
          padding: EdgeInsets.fromLTRB(
            Dimens.size16,
            Dimens.size16 + MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top,
            Dimens.size16,
            Dimens.size16,
          ),
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: image.isNullOrWhiteSpace ? theme.primaryColorDark : theme.primaryColor,
          ),
        ),
      ],
    );
  }
}
