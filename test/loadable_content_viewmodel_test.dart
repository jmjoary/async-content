import 'package:async_content/async_content.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("LoadableContentViewModel", () {
    late LoadableContentViewModel sut;

    setUp(() {
      sut = TestableLoadableContentViewModel();
    });

    test("initial state", () {
      expect(sut.isLoading, false);
      expect(sut.hasTriggeredInitialLoad, false);
    });

    test("startedLoading", () {
      sut.isLoading = false;
      sut.startedLoading();
      expect(sut.isLoading, true);
    });

    test("finishedLoading", () {
      sut.isLoading = true;
      sut.finishedLoading();
      expect(sut.isLoading, false);
    });

    test("hasTriggeredInitialLoad", () {
      sut.loadContentToDisplay();
      expect(sut.hasTriggeredInitialLoad, true);
    });

    test("onError with String message", () {
      sut.onError("Error message");
      expect(sut.isLoading, false);
      expect(sut.loadingErrorTitle,
          LoadableContentViewModel.defaultLoadingErrorTitle);
      expect(sut.loadingErrorSubtitle, null);
      expect(sut.loadingErrorDetails, "Error message");
      expect(sut.loadingErrorResolutionAction, null);
      expect(sut.loadingErrorResolutionActionText, null);
      expect(sut.loadingErrorCancelAction, null);
      expect(sut.loadingErrorCancelActionText, null);
    });

    test("onError with Error", () {
      sut.onError(Error());
      expect(sut.isLoading, false);
      expect(sut.loadingErrorTitle,
          LoadableContentViewModel.defaultLoadingErrorTitle);
      expect(sut.loadingErrorSubtitle, null);
      expect(sut.loadingErrorDetails, isNotNull,
          reason: "The stack trace should be added to the error details");
      expect(sut.loadingErrorResolutionAction, null);
      expect(sut.loadingErrorResolutionActionText, null);
      expect(sut.loadingErrorCancelAction, null);
      expect(sut.loadingErrorCancelActionText, null);
    });

    test("onError with Exception", () {
      sut.onError(Exception());
      expect(sut.isLoading, false);
      expect(sut.loadingErrorTitle,
          LoadableContentViewModel.defaultLoadingErrorTitle);
      expect(sut.loadingErrorSubtitle, null);
      expect(sut.loadingErrorDetails, isNotNull,
          reason: "The stack trace should be added to the error details");
      expect(sut.loadingErrorResolutionAction, null);
      expect(sut.loadingErrorResolutionActionText, null);
      expect(sut.loadingErrorCancelAction, null);
      expect(sut.loadingErrorCancelActionText, null);
    });

    test("onError with DisplayableError", () {
      sut.onError(DisplayableError("Custom title",
          subtitle: "Custom subtitle",
          details: "Custom details",
          resolutionAction: () {},
          resolutionActionText: "Custom resolution action text",
          cancelAction: () {},
          cancelActionText: "Custom cancel action text"));
      expect(sut.isLoading, false);
      expect(sut.loadingErrorTitle, "Custom title");
      expect(sut.loadingErrorSubtitle, "Custom subtitle");
      expect(sut.loadingErrorDetails, "Custom details");
      expect(sut.loadingErrorResolutionAction, isNotNull);
      expect(sut.loadingErrorResolutionActionText,
          "Custom resolution action text");
      expect(sut.loadingErrorCancelAction, isNotNull);
      expect(sut.loadingErrorCancelActionText, "Custom cancel action text");
    });

    test("clearError", () {
      sut.loadingErrorTitle = "Error title";
      sut.loadingErrorSubtitle = "Error subtitle";
      sut.loadingErrorDetails = "Error details";
      sut.loadingErrorResolutionAction = () {};
      sut.loadingErrorResolutionActionText = "Error resolution action text";
      sut.loadingErrorCancelAction = () {};
      sut.loadingErrorCancelActionText = "Error cancel action text";

      sut.clearErrors();

      expect(sut.isLoading, false);
      expect(sut.loadingErrorTitle, null);
      expect(sut.loadingErrorSubtitle, null);
      expect(sut.loadingErrorDetails, null);
      expect(sut.loadingErrorResolutionAction, null);
      expect(sut.loadingErrorResolutionActionText, null);
      expect(sut.loadingErrorCancelAction, null);
      expect(sut.loadingErrorCancelActionText, null);
    });
  });
}

class TestableLoadableContentViewModel extends LoadableContentViewModel {
  @override
  Future<void> startLoadingContent() async {}
}
