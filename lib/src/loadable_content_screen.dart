import 'package:async_content/src/loadable_content_viewmodel.dart';
import 'package:async_content/src/loaded_content_error_view.dart';
import 'package:flutter/material.dart';

@Deprecated(
    'Use official ListenableBuilder class with a LoadableContentViewModel instead + router to call the start loading content when needed')
abstract class LoadableContentScreen<T extends LoadableContentViewModel>
    extends StatelessWidget {
  final T viewModel;
  final bool reloadDataEachTimeScreenIsDisplayed;
  final bool withSafeArea;
  final bool withAppBar;
  final double? appBarScrollElevation;
  const LoadableContentScreen(this.viewModel,
      {super.key,
      this.appBarScrollElevation,
      this.reloadDataEachTimeScreenIsDisplayed = false,
      this.withAppBar = true,
      this.withSafeArea = true});

  Widget? get child => null;

  @override
  Widget build(BuildContext context) {
    final actions = buildActionsList(context, viewModel);
    final futureBuilder = FutureBuilder(
        future: viewModel.loadContentToDisplay(
            force: reloadDataEachTimeScreenIsDisplayed),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return const Center(child: CircularProgressIndicator());
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
    return Scaffold(
        appBar: withAppBar
            ? AppBar(
                scrolledUnderElevation: appBarScrollElevation,
                title: AnimatedBuilder(
                  animation: viewModel,
                  builder: (context, child) {
                    Widget? preparedWidget =
                        pageTitleWidget(context, viewModel);
                    preparedWidget ??=
                        Text(pageTitle(context, viewModel) ?? "");
                    return preparedWidget;
                  },
                ),
                leading: appBarLeading(context, viewModel),
                actions: (actions != null && actions.isNotEmpty)
                    ? actions
                        .map((e) => AnimatedBuilder(
                            animation: viewModel, builder: (context, _) => e))
                        .toList()
                    : null)
            : null,
        body: withSafeArea
            ? SafeArea(
                child: futureBuilder,
              )
            : futureBuilder);
  }

  /// Override this method to build the content of the screen.
  Widget buildContent(BuildContext context, T viewModel, Widget? child);

  /// Override this method to build a list of actions to display in the app bar.
  List<Widget>? buildActionsList(BuildContext context, T viewModel) {
    return null;
  }

  /// Override this method to build a Text widget displaying the returned String in the title position of the app bar.
  /// This method will be ignored if [pageTitleWidget] is overridden and returns a non-null value.
  String? pageTitle(BuildContext context, T viewModel) => null;

  /// Override this method to build any widget to display in the title position of the app bar.
  Widget? pageTitleWidget(BuildContext context, T viewModel) => null;

  /// Override this method to build a widget to display in the leading position of the app bar.
  Widget? appBarLeading(BuildContext context, T viewModel) => null;
}
