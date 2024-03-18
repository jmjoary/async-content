import 'package:extension_dart_tools/extension_tools.dart';
import 'package:async_content/src/loadable_content_viewmodel.dart';

class MockLoadableContentPresenter extends ILoadableContentPresenter
    with MockMixin {
  @override
  void startedLoading() {
    addCall(named: "startedLoading");
  }

  @override
  void onError(dynamic error) {
    addCall(named: "onError", arguments: {"error": error});
  }

  @override
  void clearErrors() {
    addCall(named: "clearError");
  }

  @override
  void finishedLoading() {
    addCall(named: "finishedLoading");
  }
}
