import 'package:flutter/material.dart';
import 'dart:ui' show ViewFocusState, ViewFocusDirection;
import 'focusable_app.dart';

void main() {
  runApp(const FocusableApp(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(title: 'Flutter Demo Home Page'),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < 6; i++)
              TextButton(
                onPressed: _incrementCounter,
                child: Text('Press me to increase count'),
              ),
            Text('You have pushed the button this many times: $_counter'),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                final viewId = View.of(context).viewId;
                final platformDispatcher = WidgetsFlutterBinding.ensureInitialized().platformDispatcher;
                platformDispatcher.requestViewFocusChange(
                  viewId: viewId,
                  state: ViewFocusState.unfocused,
                  direction: ViewFocusDirection.undefined,
                );
              },
              child: Text('Press me to unfocus this view'),
            ),
          ],
        ),
      ),
    );
  }
}
