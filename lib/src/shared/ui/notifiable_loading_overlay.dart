import 'package:beseated/src/shared/ui/loading_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotifiableLoadingOverlay extends ConsumerWidget {
  const NotifiableLoadingOverlay({super.key, required this.notifier});

  final ProviderListenable<AsyncValue<bool>> notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(notifier);
    return state.isLoading || state.value != true ? const LoadingOverlay() : const SizedBox.shrink();
  }
}