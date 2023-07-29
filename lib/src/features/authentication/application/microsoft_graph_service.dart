import 'package:beseated/src/features/authentication/data/microsoft_graph_repository.dart';
import 'package:beseated/src/features/authentication/domain/user.dart';
import 'package:beseated/src/features/authentication/presentation/logged_in_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'microsoft_graph_service.g.dart';

class MicrosoftGraphService {
  MicrosoftGraphService({required this.ref});

  MicrosoftGraphServiceRef ref;
  
  Future<void> loadUserDetails() async {
    final microsoftGraphRepository = ref.watch(microsoftGraphRepositoryProvider);
    final image = await microsoftGraphRepository.getProfilImage();
    final organizationLogo = await microsoftGraphRepository.getOrganizationLogo();
    var user = await microsoftGraphRepository.getUser();
    user = user.copyWith(image: image, organizationLogo: organizationLogo);
    ref.read(loggedInUserProvider.notifier).change(user);
    return;
  }

}

@riverpod
MicrosoftGraphService microsoftGraphService(MicrosoftGraphServiceRef ref) =>
    MicrosoftGraphService(
        ref: ref,
    );

@riverpod
Future<void> loadUserDetails(LoadUserDetailsRef ref) =>
    ref.watch(microsoftGraphServiceProvider).loadUserDetails();
