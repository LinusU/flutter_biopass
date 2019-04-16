import 'dart:async';

import 'package:flutter/services.dart';

class BioPass {
  static const MethodChannel _channel = const MethodChannel('flutter_biopass');

  final Future<String> _idFuture;

  BioPass() : _idFuture = _channel.invokeMethod('init', <String, dynamic>{});
  BioPass.withServiceName(String serviceName) : _idFuture = _channel.invokeMethod('init', <String, dynamic>{'serviceName': serviceName});
  BioPass.withSharedAccessGroup(String sharedAccessGroupName) : _idFuture = _channel.invokeMethod('init', <String, dynamic>{'sharedAccessGroupName': sharedAccessGroupName});

  Future<void> store(String password) async {
    await _channel.invokeMethod('store', <String, dynamic>{'id': await _idFuture, 'password': password});
  }

  Future<String> retreive({String withPrompt}) async {
    return await _channel.invokeMethod('retreive', <String, dynamic>{'id': await _idFuture, 'prompt': withPrompt}) as String;
  }

  Future<void> delete() async {
    await _channel.invokeMethod('delete', <String, dynamic>{'id': await _idFuture});
  }
}
