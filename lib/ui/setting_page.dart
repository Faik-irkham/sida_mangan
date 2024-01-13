import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sida_mangan/provider/scheduling_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _schedulingProvider = SchedulingProvider();

  @override
  void initState() {
    super.initState();
    initScheduling();
  }

  void initScheduling() async {
    bool scheduling = await _schedulingProvider.schedulingPref.getScheduling();
    _schedulingProvider.scheduledRecomendations(scheduling);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('settings'),
        leading: Container(),
      ),
      body: ChangeNotifierProvider(
        create: (_) => _schedulingProvider,
        child: _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: const Text('Recomendation Restaurants'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, provider, _) {
                return Switch.adaptive(
                  value: provider.isScheduled,
                  onChanged: (value) {
                    provider.scheduledRecomendations(value);
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
