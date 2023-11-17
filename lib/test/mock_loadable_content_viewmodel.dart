import 'package:extension_dart_tools/extension_tools.dart';
import 'package:async_content/src/loadable_content_viewmodel.dart';

class MockLoadableContentViewModel extends LoadableContentViewModel
    with MockMixin {
  @override
  Future loadContentToDisplay({bool force = false}) {
    addCalledFunction(named: "loadContentToDisplay");
    addReceivedObject(force, name: "force");
    return Future.value();
  }

  @override
  Future startLoadingContent() {
    addCalledFunction(named: "startLoadingContent");
    return Future.value();
  }

  @override
  void startedLoading() {
    addCalledFunction(named: "startedLoading");
  }

  @override
  void onError(dynamic error) {
    addCalledFunction(named: "onError");
    addReceivedObject(error, name: "error");
  }
}
