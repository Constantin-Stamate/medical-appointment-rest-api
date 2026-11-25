import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:medical_appointment_rest_api/data/datasources/app_remote_data_source.dart';
import 'package:medical_appointment_rest_api/data/repositories/app_repository_impl.dart';
import 'package:medical_appointment_rest_api/domain/usecases/load_app_data.dart';
import 'package:medical_appointment_rest_api/presentation/state/app_cubit.dart';
import 'package:medical_appointment_rest_api/presentation/state/load_status.dart';

void main() {
  test('loads both V2 endpoints and parses JSON', () async {
    final paths = <String>[];
    final client = MockClient((request) async {
      paths.add(request.url.path);
      final name = request.url.path.endsWith('/details') ? 'details' : 'feed';
      return http.Response(
        File('test/fixtures/$name.json').readAsStringSync(),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });
    final cubit = AppCubit(
      LoadAppData(AppRepositoryImpl(AppRemoteDataSource(client))),
    );
    await cubit.load();
    expect(
      paths,
      unorderedEquals(['/lab2026/v2/feed', '/lab2026/v2/feed/details']),
    );
    expect(cubit.state.status, LoadStatus.success);
    expect(cubit.state.data!.doctors, isNotEmpty);
    await cubit.close();
    client.close();
  });
  test('HTTP failure produces error state', () async {
    final client = MockClient((_) async => http.Response('error', 503));
    final cubit = AppCubit(
      LoadAppData(AppRepositoryImpl(AppRemoteDataSource(client))),
    );
    await cubit.load();
    expect(cubit.state.status, LoadStatus.error);
    await cubit.close();
    client.close();
  });
}