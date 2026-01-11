import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class SyncButton extends StatefulWidget {
  final Future<int> Function() onSync;
  const SyncButton({super.key, required this.onSync});

  @override
  State<SyncButton> createState() => _SyncButtonState();
}


class _SyncButtonState extends State<SyncButton> {
  bool _isSyncing = false;

  Future<void> _handleSync() async {
    var result = await Connectivity().checkConnectivity();
    setState(() {
      _isSyncing = true;
    });
    if (result.contains(ConnectivityResult.none)) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("🛜 No internet connection. Please connect to the internet and try again."),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
    setState(() {
      _isSyncing = false;
    });
} else {
    try {
      final length = await widget.onSync();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("🛜 Database synced successfully! $length records added."),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("💀 Sync failed: ${e.toString()}"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      setState(() {
        _isSyncing = false;
      });
    }
  }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isSyncing ? null : _handleSync,
      child: _isSyncing
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          : const Text("Sync Database"),
    );
  }
}
