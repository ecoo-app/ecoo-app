import 'package:e_coupon/business/core/failure.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_view_model.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T model;
  final Function(T) onModelReady;
  // final Function(Failure) onError;

  /// defualt: true. set true to create a new provider and dispose it each time the view comes up.
  /// Set false to use the provider.value constructor.
  final bool disposeState;

  BaseView(
      {Key key,
      this.builder,
      this.model,
      this.onModelReady,
      this.disposeState = true})
      : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>(disposeState);
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model;
  final bool disposeState;

  _BaseViewState(this.disposeState);

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (disposeState) {
      return ChangeNotifierProvider<T>(
          create: (_) => model, child: Consumer<T>(builder: widget.builder));
    } else {
      return ChangeNotifierProvider<T>.value(
          value: model, child: Consumer<T>(builder: widget.builder));
    }
  }
}
