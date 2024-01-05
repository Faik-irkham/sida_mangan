import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sida_mangan/provider/scheduling_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('settings'),
        leading: Container(),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: const Text('Recomendation Restaurants'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) {
                    scheduled.scheduledRecomendations(value);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
