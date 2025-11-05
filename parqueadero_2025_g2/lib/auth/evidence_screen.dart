import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'session_manager.dart';
import 'package:parqueadero_2025_g2/widgets/base_view.dart';

class EvidenceScreen extends StatefulWidget {
  const EvidenceScreen({super.key});

  @override
  State<EvidenceScreen> createState() => _EvidenceScreenState();
}

class _EvidenceScreenState extends State<EvidenceScreen> {
  String? _name;
  String? _email;
  bool _hasToken = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final user = await SessionManager.getUser();
    final token = await SessionManager.getAccessToken();
    if (!mounted) return;
    setState(() {
      _name = user['name'];
      _email = user['email'];
      _hasToken = token != null && token.isNotEmpty;
      _loading = false;
    });
  }

  Future<void> _logout() async {
    setState(() => _loading = true);
    await SessionManager.clearAll();
    if (!mounted) return;
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Evidencia de sesión',
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre: ${_name ?? '-'}'),
                  const SizedBox(height: 8),
                  Text('Email: ${_email ?? '-'}'),
                  const SizedBox(height: 8),
                  Text('Estado de sesión: ${_hasToken ? 'token presente' : 'sin token'}'),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _logout,
                      child: const Text('Cerrar sesión'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
