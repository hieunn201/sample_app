import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<T extends dynamic> {
  BaseBloc({T state}) {
    _controller = BehaviorSubject<T>.seeded(state);
  }

  BehaviorSubject<T> _controller;
  final BehaviorSubject<dynamic> _listenerController = BehaviorSubject<dynamic>();
  final BehaviorSubject<bool> _loadingController = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get loadingStream => _loadingController?.stream;
  Stream<T> get stateStream => _controller?.stream;
  Stream<dynamic> get listenerStream => _listenerController?.stream;

  T get state => _controller?.value;

  @mustCallSuper
  void dispose() {
    _controller?.close();
    _listenerController?.close();
    _loadingController?.close();
  }

  @mustCallSuper
  void onResume() {}

  @mustCallSuper
  void onPause() {}

  @mustCallSuper
  void onDetach() {}

  @mustCallSuper
  void onInactive() {}

  void emit(T state)  {
    if (_controller?.isClosed ?? true) return;
    _controller?.sink?.add(state);
  }

  void addError(Object error, [StackTrace stackTrace]) {
    if (_controller?.isClosed ?? true) return;
    _controller?.sink?.addError(error, stackTrace);
  }

  void emitLoading(bool loading) {
    if (_loadingController?.isClosed ?? true) return;
    _loadingController.sink.add(loading);
  }

  void emitListener(dynamic payload) {
    if (_listenerController?.isClosed ?? true) return;
    _listenerController.sink.add(payload);
  }
}

class BaseEvent {
  final bool success;
  final String message;

  BaseEvent({this.success = false, this.message});
}
