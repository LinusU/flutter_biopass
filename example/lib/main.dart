import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_biopass/flutter_biopass.dart' show BioPass;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();

  BioPass biopass;

  @override
  void initState() {
    super.initState();
    biopass = BioPass();
  }

  Future<void> store(BuildContext context) async {
    await biopass.store('foobar');

    showDialog(
      context: navigatorKey.currentState.overlay.context,
      builder: (_) => AlertDialog(
            title: Text('Store'),
            content: Text('Password stored successfully!'),
            actions: <Widget>[FlatButton(child: Text('close'), onPressed: () => navigatorKey.currentState.pop())],
          ),
    );
  }

  Future<void> retreive(BuildContext context) async {
    final result = await biopass.retreive(withPrompt: 'Example prompt text...');

    showDialog(
      context: navigatorKey.currentState.overlay.context,
      builder: (_) => AlertDialog(
            title: Text('Retreive'),
            content: Text('Result: $result'),
            actions: <Widget>[FlatButton(child: Text('close'), onPressed: () => navigatorKey.currentState.pop())],
          ),
    );
  }

  Future<void> delete(BuildContext context) async {
    await biopass.delete();

    showDialog(
      context: navigatorKey.currentState.overlay.context,
      builder: (_) => AlertDialog(
            title: Text('Delete'),
            content: Text('Password deleted successfully!'),
            actions: <Widget>[FlatButton(child: Text('close'), onPressed: () => navigatorKey.currentState.pop())],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Store'),
                onPressed: () => this.store(context),
              ),
              RaisedButton(
                child: Text('Retreive'),
                onPressed: () => this.retreive(context),
              ),
              RaisedButton(
                child: Text('Delete'),
                onPressed: () => this.delete(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
