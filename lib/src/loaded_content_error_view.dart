import 'package:async_content/src/loadable_content_viewmodel.dart';
import 'package:extension_flutter_tools/extension_flutter_tools.dart';
import 'package:flutter/widgets.dart';

class LoadedContentErrorView extends StatelessWidget {
  final LoadableContentViewModel viewModel;
  const LoadedContentErrorView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ErrorView(
          title: viewModel.loadingErrorTitle ?? "Une erreur est survenue",
          subtitle: viewModel.loadingErrorSubtitle,
          details: viewModel.loadingErrorDetails,
          cancelActionText: viewModel.loadingErrorCancelActionText,
          cancelAction: viewModel.loadingErrorCancelAction,
          resolutionActionText: viewModel.loadingErrorResolutionActionText,
          resolutionAction: viewModel.loadingErrorResolutionAction),
    );
  }
}
