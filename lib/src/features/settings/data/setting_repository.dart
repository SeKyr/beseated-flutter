import 'dart:async';

import 'package:beseated/src/features/settings/domain/setting.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/app_utils.dart';
import '../../../shared/internet/beseated_secured_http_client.dart';

part 'setting_repository.g.dart';


class SettingRepository {
  SettingRepository({required this.client});
  final String _baseEndpointUrl = '/settings';

  final BeSeatedSecuredHttpClient client;

  Future<List<Setting>> getAll() async {
    final response = await client.get('$_baseEndpointUrl/all');
    final data = AppUtils.decodeJsonList(response.body);
    return data.map((s) => Setting.fromJson(s)).toList();
  }


}

@riverpod
SettingRepository settingRepository(SettingRepositoryRef ref) =>
    SettingRepository(client: BeSeatedSecuredHttpClient());