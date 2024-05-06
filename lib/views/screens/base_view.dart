import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/base_viewmodel.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T) onModelReady;
  final T viewModel;

  const BaseView({
    super.key,
    required this.builder,
    required this.onModelReady,
    required this.viewModel,
  });

  @override
  BaseViewState<T> createState() => BaseViewState<T>();
}

class BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T? model;
  @override
  void initState() {
    model = widget.viewModel;

    widget.onModelReady(model!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model ?? widget.viewModel,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
