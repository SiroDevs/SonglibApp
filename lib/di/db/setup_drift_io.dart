import 'dart:developer' as logger show log;
import 'dart:io';
import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/utilities.dart';

Future<DatabaseConnection> createDriftDatabaseConnection(String name) async {
  Directory dbFolder = await getApplicationDocumentsDirectory();
  if (isDesktop) {
    dbFolder = await getApplicationSupportDirectory();
  }

  final file = File(join(dbFolder.path, '$name.sqlite'));

  final receivePort = ReceivePort();

  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, file.path),
  );
  logger.log('Database $file');
  final isolate = await receivePort.first as DriftIsolate;
  return isolate.connect();
}

void _startBackground(_IsolateStartRequest request) {
  final executor = NativeDatabase(File(request.targetPath));
  final driftIsolate = DriftIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
  );
  request.sendDriftIsolate.send(driftIsolate);
}

class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}
