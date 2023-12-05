import 'package:async_content/async_content.dart';
import 'package:extension_flutter_tools/extension_flutter_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("LoadableContentScreen", () {
    late MockLoadableContentViewModel mockViewModel;

    setUp(() {
      mockViewModel = MockLoadableContentViewModel();
    });

    Future<void> launchScreen(WidgetTester tester,
        {String? title,
        bool reloadDataEachTimeScreenIsDisplayed = false}) async {
      final screen = TestLoadContentScreen(
        mockViewModel,
        reloadDataEachTimeScreenIsDisplayed:
            reloadDataEachTimeScreenIsDisplayed,
      );
      screen.title = title;
      await TestTools.runTestableWidgetScreen(tester: tester, child: screen);
      await tester.pump();
    }

    testWidgets("Base structure", (widgetTester) async {
      await launchScreen(widgetTester,
          reloadDataEachTimeScreenIsDisplayed: false);

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(FutureBuilder), findsOneWidget);
      expect(find.byKey(const Key("viewmodel-watcher")), findsOneWidget,
          reason: "This AnimatedBuilder will watch the view model for changes");
      expect(find.byType(LoadedContentErrorView), findsNothing);

      expect(mockViewModel.calledFunctions, contains("loadContentToDisplay"));
      expect(mockViewModel.receivedObjects["force"], false);
    });

    testWidgets("Title option", (widgetTester) async {
      await launchScreen(widgetTester, title: "Title");

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text("Title"), findsOneWidget);
    });

    testWidgets("Reload data each time screen is displayed",
        (widgetTester) async {
      await launchScreen(widgetTester,
          reloadDataEachTimeScreenIsDisplayed: true);

      expect(mockViewModel.calledFunctions, contains("loadContentToDisplay"));
      expect(mockViewModel.receivedObjects["force"], true);
    });

    testWidgets("When error in view model", (widgetTester) async {
      mockViewModel.loadingErrorTitle = "Error title";
      await launchScreen(widgetTester);

      expect(find.byType(LoadedContentErrorView), findsOneWidget);
      expect(find.text("Error title"), findsOneWidget);
    });
  });
}

// ignore: must_be_immutable
class TestLoadContentScreen extends LoadableContentScreen {
  TestLoadContentScreen(super.viewModel,
      {super.key, super.reloadDataEachTimeScreenIsDisplayed = false});

  @override
  Widget buildContent(
      BuildContext context, LoadableContentViewModel viewModel, Widget? child) {
    return const Placeholder();
  }

  String? title;
  @override
  String? pageTitle(BuildContext context, LoadableContentViewModel viewModel) {
    return title;
  }
}
