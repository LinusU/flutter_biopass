import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_biopass/flutter_biopass.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_biopass');

  setUp(() {
    var nextId = 0;
    var store = Map<String, String>();

    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'init':
          final id = '${nextId++}';
          store[id] = null;
          return id;
        case 'store':
          final id = (methodCall.arguments as Map)['id'] as String;
          final password = (methodCall.arguments as Map)['password'] as String;
          store[id] = password;
          return null;
        case 'retreive':
          final id = (methodCall.arguments as Map)['id'] as String;
          return store[id];
        case 'delete':
          final id = (methodCall.arguments as Map)['id'] as String;
          store[id] = null;
          return null;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('Smoke test', () async {
    final biopass = BioPass();
    expect(await biopass.retreive(withPrompt: 'x'), null);

    await biopass.store('foobar');
    expect(await biopass.retreive(withPrompt: 'x'), 'foobar');

    await biopass.delete();
    expect(await biopass.retreive(withPrompt: 'x'), null);
  });
}
