import 'package:async_content/src/loadable_content_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DisplayableError", () {
    test("Constructor", () {
      final String title = "Error message title";
      final String subtitle = "Error message subtitle";
      final String details = "Error message details";
      final Function resolutionAction = resolutionActionFunction;
      final String resolutionActionText = "Resolution action text";
      final Function cancelAction = cancelActionFunction;
      final String cancelActionText = "Cancel action text";
      final DisplayableError sut = DisplayableError(
        title,
        subtitle: subtitle,
        details: details,
        resolutionAction: resolutionAction,
        resolutionActionText: resolutionActionText,
        cancelAction: cancelAction,
        cancelActionText: cancelActionText,
      );

      expect(sut.title, title);
      expect(sut.subtitle, subtitle);
      expect(sut.details, details);
      expect(sut.resolutionAction, resolutionAction);
      expect(sut.resolutionActionText, resolutionActionText);
      expect(sut.cancelAction, cancelAction);
      expect(sut.cancelActionText, cancelActionText);
    });

    test("Equals", () {
      final String title = "Error message title";
      final String subtitle = "Error message subtitle";
      final String details = "Error message details";
      final Function resolutionAction = resolutionActionFunction;
      final String resolutionActionText = "Resolution action text";
      final Function cancelAction = cancelActionFunction;
      final String cancelActionText = "Cancel action text";
      final DisplayableError sut1 = DisplayableError(
        title,
        subtitle: subtitle,
        details: details,
        resolutionAction: resolutionAction,
        resolutionActionText: resolutionActionText,
        cancelAction: cancelAction,
        cancelActionText: cancelActionText,
      );
      final DisplayableError sut2 = DisplayableError(
        title,
        subtitle: subtitle,
        details: details,
        resolutionAction: resolutionAction,
        resolutionActionText: resolutionActionText,
        cancelAction: cancelAction,
        cancelActionText: cancelActionText,
      );

      expect(sut1, sut2);
    });

    test("hashCode", () {
      final String title = "Error message title";
      final String subtitle = "Error message subtitle";
      final String details = "Error message details";
      final Function resolutionAction = resolutionActionFunction;
      final String resolutionActionText = "Resolution action text";
      final Function cancelAction = cancelActionFunction;
      final String cancelActionText = "Cancel action text";
      final DisplayableError sut1 = DisplayableError(
        title,
        subtitle: subtitle,
        details: details,
        resolutionAction: resolutionAction,
        resolutionActionText: resolutionActionText,
        cancelAction: cancelAction,
        cancelActionText: cancelActionText,
      );

      final DisplayableError sut2 = DisplayableError(
        title,
        subtitle: subtitle,
        details: details,
        resolutionAction: resolutionAction,
        resolutionActionText: resolutionActionText,
        cancelAction: cancelAction,
        cancelActionText: cancelActionText,
      );

      expect(sut1.hashCode, sut2.hashCode);
    });
  });
}

resolutionActionFunction() {}

cancelActionFunction() {}
