import 'package:async_content/async_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:extension_flutter_tools/extension_flutter_tools.dart';

void main() {
  group("LoadedContentErrorView", () {
    late MockLoadableContentViewModel mockViewModel;

    setUp(() {
      mockViewModel = MockLoadableContentViewModel();
    });
    testWidgets("Display title only error", (tester) async {
      mockViewModel.loadingErrorTitle = "Error Title";
      await TestTools.runTestableComponent(
          tester: tester,
          child: LoadedContentErrorView(viewModel: mockViewModel));
      expect(find.text("Error Title"), findsOneWidget);
      expect(find.byKey(const Key("toggle-details-button")), findsNothing);
    });
    testWidgets("Display error when no title provided", (tester) async {
      mockViewModel.loadingErrorTitle = null;
      await TestTools.runTestableComponent(
          tester: tester,
          child: LoadedContentErrorView(viewModel: mockViewModel));
      expect(find.text("Une erreur est survenue"), findsOneWidget);
    });
    testWidgets("Display error with all fields provided", (tester) async {
      mockViewModel.loadingErrorTitle = "Error Title";
      mockViewModel.loadingErrorSubtitle = "Error Subtitle";
      mockViewModel.loadingErrorDetails = "Error Details";
      mockViewModel.loadingErrorCancelActionText = "Cancel";
      mockViewModel.loadingErrorCancelAction = () {};
      mockViewModel.loadingErrorResolutionActionText = "Retry";
      mockViewModel.loadingErrorResolutionAction = () {};

      await TestTools.runTestableComponent(
          tester: tester,
          child: LoadedContentErrorView(viewModel: mockViewModel));
      expect(find.text("Error Title"), findsOneWidget);
      expect(find.text("Error Subtitle"), findsOneWidget);
      expect(find.byKey(const Key("toggle-details-button")), findsOneWidget);
      expect(find.text("Cancel"), findsOneWidget);
      expect(find.text("Retry"), findsOneWidget);
    });
  });
}
