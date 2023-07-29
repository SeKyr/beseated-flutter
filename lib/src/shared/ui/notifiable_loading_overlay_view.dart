import 'package:beseated/src/shared/ui/notifiable_loading_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotifiableLoadingOverlayView extends ConsumerWidget {
  const NotifiableLoadingOverlayView({super.key, required this.child, required this.notifier});

  final Widget child;
  final ProviderListenable<AsyncValue<bool>> notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        NotifiableLoadingOverlay(notifier: notifier)
      ],
    );
  }
}