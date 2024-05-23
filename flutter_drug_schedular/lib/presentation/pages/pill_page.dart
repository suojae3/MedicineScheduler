
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pill_provider.dart';

class PillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pillProvider = Provider.of<PillProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Pill Info'),
      ),
      body: ListView.builder(
        itemCount: pillProvider.pills.length,
        itemBuilder: (context, index) {
          final pill = pillProvider.pills[index];
          return ListTile(
            title: Text(pill.name),
            subtitle: Text(pill.description),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add pill page
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
