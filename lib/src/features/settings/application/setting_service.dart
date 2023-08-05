import 'package:beseated/src/features/settings/data/setting_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/setting.dart';


part 'setting_service.g.dart';

class SettingService {

  SettingService({required this.settingRepository});

  final SettingRepository settingRepository;

  Future<List<Setting>> getAll() {
    return settingRepository.getAll();
  }

  Future<Map<String, String>> getAllAsMap() async {
    Map<String, String> settingsMap = {};
    List<Setting> settingsList = await settingRepository.getAll();
    for (var setting in settingsList) {
      settingsMap[setting.name] = setting.value;
    }
    return settingsMap;
  }
}
@riverpod
SettingService settingService(SettingServiceRef ref) =>
    SettingService(
        settingRepository: ref.watch(settingRepositoryProvider)
    );
