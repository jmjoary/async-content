import 'package:async_content/async_content.dart';
import 'package:flutter/material.dart';

class LoadableContent<T extends LoadableContentViewModel>
    extends StatelessWidget {
  final T viewModel;
  final bool reloadDataEachTimeScreenIsDisplayed;
  final Widget? child;
  final Widget? loadIndicator;
  final Widget Function(BuildContext context, T viewModel, Widget? child)
      buildContent;
  const LoadableContent(
      {required this.viewModel,
      required this.buildContent,
      this.child,
      this.loadIndicator,
      this.reloadDataEachTimeScreenIsDisplayed = false});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future(() => viewModel.loadContentToDisplay(
            force: reloadDataEachTimeScreenIsDisplayed)),
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
                  Expanded(child: buildContent(context, viewModel, child)),
                ],
              );
            },
            child: child,
          );
        });
  }
}
