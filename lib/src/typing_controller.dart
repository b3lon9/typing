import '/src/typing_control_state.dart';
import '/src/typing_protocol.dart';
import '/src/typing_state.dart';
import '/src/typing_widget.dart';
import '/src/typing_const.dart';

class KeyboardTypingController extends TypingProtocol {
  TypingStateProvider? _state;
  late final Function({required Map<String, dynamic> bundle})
      _typingControlEventListener;
  Function(KeyboardTypingState state)? _typingStateEventListener;

  /// First init KeyboardTypingController
  ///
  /// Use [initState] function.
  bool _isPlay = false;

  /// [_state] should not access in Private Typing Stateful Widget.
  ///
  /// It is only alternative FLAG
  ///
  /// Do not use this.
  void setTypingEventListener(TypingStateProvider state,
      Function({required Map<String, dynamic> bundle}) eventFunction) {
    _state = state..addEventListener(_typingStateEventListener);
    _typingControlEventListener = eventFunction;

    if (_isPlay) {
      play();
    }
  }

  /// Start Typing Animation. (like keyboard).
  ///
  /// Resume is when [KeyboardTypingState.pause].
  ///
  /// If you want play() at [initState] function.
  /// try it this.
  ///
  /// -
  ///
  /// @override
  /// void initState() {
  ///   super.initState();
  ///
  ///   KeyboardTypingController controller = KeyboardTypingController();
  ///   controller.play();
  /// }
  @override
  void play() {
    /*assert(_state != null,
        "Put [TypingController] into [Typing] Widget's 'controller' parameter");*/

    _isPlay = true;

    if (_state != null) {
      _typingControlEventListener(
        bundle: {TypingConstant.controlState: TypingControlState.play},
      );
    }
  }

  /// [stop] function can stop typing action.
  ///
  /// [cancel] parameter is default 'false'.
  /// If you define 'true', It will be forced stop.
  ///
  /// and use [play] function clear sentence in Text Widget.
  ///
  /// If keyboardtyping state is [KeyboardTypingState.pause] so will can not apply forced stop.
  ///
  @override
  void stop({bool cancel = false}) {
    /*assert(_state != null,
        "Put [TypingController] into [Typing] Widget's 'controller' parameter");*/

    _isPlay = false;

    if (_state != null) {
      _typingControlEventListener(bundle: {
        TypingConstant.controlState: TypingControlState.stop,
        TypingConstant.stopForced: cancel
      });
    }
  }

  /// Know current [TypingState]'s state value.
  @override
  KeyboardTypingState get state =>
      _state != null ? _state!.state : KeyboardTypingState.idle;

  /// Event값을 전달해주는 역할
  @override
  void addStateEventListener(
      Function(KeyboardTypingState state) eventListener) {
    _typingStateEventListener = eventListener;
  }

  @override
  void removeStateEventListener(
      Function(KeyboardTypingState state) eventListener) {
    if (_typingStateEventListener == eventListener) {
      _typingStateEventListener = null;
    }
  }

  /// Default visible = true,
  ///
  /// Forced control Text Cursor visible
  @override
  void cursor({required bool visible}) {
    if (_state != null) {
      _typingControlEventListener(bundle: {
        TypingConstant.controlState: TypingControlState.cursor,
        TypingConstant.cursorVisible: visible
      });
    }
  }
}
