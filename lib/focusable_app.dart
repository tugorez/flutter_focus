import 'dart:ui' show ViewFocusState;
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class FocusableApp extends StatefulWidget {
  final Widget child;

  const FocusableApp({super.key, required this.child});

  @override
  State<FocusableApp> createState() => _FocusableAppState();
}

class _FocusableAppState extends State<FocusableApp> {
  late FocusScopeNode _focusNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();

    final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
    final PlatformDispatcher platformDispatcher = binding.platformDispatcher;
    platformDispatcher.onViewFocusChange = (ev) {
      if (ev.state == ViewFocusState.focused) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      child: FocusScope(
        node: _focusNode,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
  }
}
