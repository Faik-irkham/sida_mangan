import 'package:flutter/material.dart';

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
            title: const Text('Scheduling News'),
            trailing: Switch.adaptive(
              value: true,
              onChanged: (value) {},
            ),
          ),
        ),
      ],
    );
  }
}
