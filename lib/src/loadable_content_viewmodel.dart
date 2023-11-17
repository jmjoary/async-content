import 'dart:async';

import 'package:flutter/material.dart';

abstract class ILoadableContentPresenter {
  void startedLoading();
  void finishedLoading();
  void onError(dynamic error);
  void clearErrors();
}

abstract class LoadableContentViewModel
    with ChangeNotifier
    implements ILoadableContentPresenter {
  static const String defaultLoadingErrorTitle = "Erreur de chargement";
  bool isLoading = false;
  String? loadingErrorTitle;
  String? loadingErrorDetails;
  String? loadingErrorSubtitle;
  Function? loadingErrorResolutionAction;
  String? loadingErrorResolutionActionText;
  Function? loadingErrorCancelAction;
  String? loadingErrorCancelActionText;

  @visibleForTesting
  Future? existingLoad;

  /// Call this method to trigger loading content to display.
  /// If content is not loading, this method will start loading content and return the future.
  /// If content is already loading, this method will return the same future.
  /// If content is already loaded, this method will return the already completed future unless [force] is true.
  /// If [force] is true, this method will either return an existing non completed future, or start a new one if none is in progress.
  Future loadContentToDisplay({bool force = false}) {
    Future? currentLoad = existingLoad;

    if (currentLoad == null || force == true) {
      currentLoad = startLoadingContent();
      existingLoad = currentLoad;
    }

    return currentLoad;
  }

  bool get hasTriggeredInitialLoad => existingLoad != null;

  @protected
  Future startLoadingContent();

  @override
  void startedLoading() {
    if (isLoading == false) {
      isLoading = true;
      loadingErrorTitle = null;
      notifyListeners();
    }
  }

  @override
  void finishedLoading() {
    if (isLoading) {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void onError(dynamic error) {
    isLoading = false;
    if (error is DisplayableError) {
      loadingErrorTitle = error.title;
      loadingErrorSubtitle = error.subtitle;
      loadingErrorDetails = error.details;
      loadingErrorResolutionAction = error.resolutionAction;
      loadingErrorResolutionActionText = error.resolutionActionText;
      loadingErrorCancelAction = error.cancelAction;
      loadingErrorCancelActionText = error.cancelActionText;
    } else {
      loadingErrorTitle = defaultLoadingErrorTitle;
      if (error is Error) {
        loadingErrorDetails = "$error ${error.stackTrace}";
      } else if (error is String) {
        loadingErrorDetails = error;
      } else {
        loadingErrorDetails = error.toString();
      }
    }
    notifyListeners();
  }

  @override
  void clearErrors() {
    loadingErrorTitle = null;
    loadingErrorSubtitle = null;
    loadingErrorDetails = null;
    loadingErrorResolutionAction = null;
    loadingErrorResolutionActionText = null;
    loadingErrorCancelAction = null;
    loadingErrorCancelActionText = null;
    notifyListeners();
  }
}

class DisplayableError {
  final String title;
  final String? subtitle;
  final String? details;
  final Function? resolutionAction;
  final String? resolutionActionText;
  final Function? cancelAction;
  final String? cancelActionText;

  const DisplayableError(this.title,
      {this.subtitle,
      this.details,
      this.resolutionAction,
      this.resolutionActionText,
      this.cancelAction,
      this.cancelActionText});
}
