import 'package:flutter/material.dart';
import 'custom_drawer.dart';

class BaseView extends StatelessWidget {
  final String title;
  final Widget body;

  const BaseView({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
        leading: canPop ? const BackButton() : null,
        actions: [
          Builder(
            builder: (ctx) => IconButton(
              tooltip: 'Menú',
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: body,
    );
  }
}
