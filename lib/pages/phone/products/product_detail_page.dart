import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../widgets/widgets.dart';
import '../../../app_localizations/localizations.dart';
import '../../../resources/resources.dart';
import '../../../extensions/extension.dart';
import '../../../blocs/bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductDetailBloc bloc;
  const ProductDetailPage(this.bloc, {Key key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  AppLocalizations _localizations;
  ThemeData _theme;

  @override
  void initState() {
    widget.bloc.onAppearing();
    widget.bloc.listenerStream.listen((state) {
      BasicDialog.show(context,
          positiveButton: BasicDialogButton('OK'),
          message:_localizations.text(state is bool && state != null && state ? Message.add_to_cart_success : ErrorMessage.add_to_cart_failed));
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations ??= AppLocalizations.of(context);
    _theme ??= Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: !kIsWeb,
                  floating: false,
                  forceElevated: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).primaryColor,
                  expandedHeight: MediaQuery.of(context).size.width / AppConstants.productRatio,
                  flexibleSpace: FlexibleSpaceBar(
                    background: StreamBuilder<String>(
                      stream: widget.bloc.stateStream.map((state) => state.productModel?.images?.fullSize).distinct(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ProductHeader(
                            image: snapshot.data,
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                  title: kIsWeb ? Container() : ListenerAppBar(
                    child: StreamBuilder<String>(
                      stream: widget.bloc.stateStream.map((state) => state.productModel?.name).distinct(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot?.data ?? '', style: _theme.textTheme.headline6.bold,);
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.only(top: Dimens.size20, bottom: Dimens.size40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder<ProductModel>(
                          stream: widget.bloc.stateStream.map((state) => state.productModel).distinct(),
                          builder: (context, snapshot) {
                            final model = snapshot.data;
                            if (model == null) return SizedBox();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  child: Text(
                                    model?.name ?? '',
                                    style: _theme.textTheme.headline5,
                                    textAlign: TextAlign.center,
                                  ),
                                  alignment: Alignment.topCenter,
                                ),
                                Align(
                                  child: Text(
                                    model?.description ?? '',
                                    style: _theme.textTheme.subtitle2.textColor(_theme.primaryColorLight).regular,
                                    textAlign: TextAlign.center,
                                  ),
                                  alignment: Alignment.topCenter,
                                ),
                                const SizedBox(height: Dimens.size20),
                                const HorizontalDivider(),
                                Padding(
                                  padding: const EdgeInsets.all(Dimens.size20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${model?.price ?? ''}'.formatCurrency,
                                        style: _theme.textTheme.bodyText1,
                                      ),
                                      StreamBuilder<int>(
                                        stream: widget.bloc.stateStream.map((state) => state.quantity).distinct(),
                                        builder: (context, snapshot) {
                                          final quantity = snapshot.data ?? ProductConstants.defaultQuantity;
                                          return CounterWidget(
                                            initialValue: quantity,
                                            min: ProductConstants.minQuantity,
                                            max: ProductConstants.maxQuantity,
                                            mainAxisSize: MainAxisSize.min,
                                            onChanged: (quantity) => widget.bloc.onQuantityChanged(quantity),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                ...model.extras
                                        ?.map((e) => ExtraWidget(
                                              model: e,
                                              onChanged: (model, items) => widget.bloc.onToppingChanged(model, items),
                                            ))
                                        ?.toList() ??
                                    [],
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: Dimens.size20,
              left: Dimens.size40,
              right: Dimens.size40,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () => widget.bloc.addToCart(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.size16, vertical: Dimens.size10),
                    color: Colors.brown,
                    child: Table(
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: IntrinsicColumnWidth(),
                        2: FlexColumnWidth(2),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.shopping_cart_sharp,
                              size: Dimens.size20,
                              color: _theme.primaryColor,
                            ),
                          ),
                          StreamBuilder<int>(
                            stream: widget.bloc.stateStream.map((state) => state.quantity).distinct(),
                            builder: (context, snapshot) {
                              return Text(
                                _localizations.text(UI.add_to_cart_args, args: [snapshot.data ?? '']).toUpperCase(),
                                style: _theme.textTheme.bodyText2.primaryColor,
                              );
                            },
                          ),
                          StreamBuilder<int>(
                            stream: widget.bloc.stateStream.map((state) => state.totalPrice).distinct(),
                            builder: (context, snapshot) {
                              return Text(
                                '${snapshot.data ?? 0}'.formatCurrency,
                                textAlign: TextAlign.end,
                                style: _theme.textTheme.bodyText2.primaryColor,
                              );
                            },
                          ),
                        ])
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
