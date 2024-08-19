import 'package:flutter/material.dart';

class BaseView<T> extends StatefulWidget {
  final T viewModel;
  final Widget Function(BuildContext context, T model) onPageBuilder;
  final void Function(T model) onModelReady;
  final Function(T model) onDispose;
  const BaseView({
    super.key,
    required this.viewModel,
    required this.onPageBuilder,
    required this.onModelReady,
    required this.onDispose,
  });

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T> extends State<BaseView<T>> {
  @override
  void initState() {
    widget.onModelReady(widget.viewModel);
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose(widget.viewModel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.onPageBuilder(context, widget.viewModel);
  }
}
