import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../core/extensions/build_context_extensions.dart';
import '../../../core/utils/haptics.dart';

@RoutePage()
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Haptics.selection();
            context.router.maybePop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Icon(
                    Icons.checkroom,
                    size: 120,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  context.l10n.result_title,
                  style: context.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Haptics.mediumImpact();
                          // TODO: Download
                        },
                        icon: const Icon(Icons.download),
                        label: Text(context.l10n.result_download),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Haptics.mediumImpact();
                          // TODO: Share
                        },
                        icon: const Icon(Icons.share),
                        label: Text(context.l10n.result_share),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Haptics.selection();
                      context.router.maybePop();
                    },
                    child: Text(context.l10n.result_try_again),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

