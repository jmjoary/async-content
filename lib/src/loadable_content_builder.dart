import 'package:async_content/async_content.dart';
import 'package:flutter/material.dart';

class LoadableContentBuilder<T extends LoadableContentViewModel>
    extends StatelessWidget {
  final T viewModel;
  final bool reloadDataOnEachBuild;
  final Widget? child;
  final Widget? loadIndicator;
  final Widget Function(BuildContext context, T viewModel, Widget? child)
      builder;
  const LoadableContentBuilder(
      {required this.viewModel,
      required this.builder,
      this.child,
      this.loadIndicator,
      this.reloadDataOnEachBuild = false});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future(
            () => viewModel.loadContentToDisplay(force: reloadDataOnEachBuild)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return loadIndicator ?? Center(child: CircularProgressIndicator());
          }
          return AnimatedBuilder(
            key: const Key("viewmodel-watcher"),
            animation: viewModel,
            builder: (context, child) {
              final errorTitle = viewModel.loadingErrorTitle;
              return Column(
                children: [
                  if (errorTitle != null)
                    LoadedContentErrorView(viewModel: viewModel),
                  Expanded(child: builder(context, viewModel, child)),
                ],
              );
            },
            child: child,
          );
        });
  }
}
