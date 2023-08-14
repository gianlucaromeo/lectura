import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProvidersLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log(
      "New value: $newValue\n",
      name: "${provider.name ?? provider.runtimeType}",
    );
  }

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    log("\nProvider: ${provider.toString()}\nValue: ${value.toString()}\n",
        name: "ProvidersLogger.didAddProvider");
  }
}
