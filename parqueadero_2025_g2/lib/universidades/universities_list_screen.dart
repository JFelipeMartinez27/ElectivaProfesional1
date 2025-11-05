import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'universities_service.dart';
import 'university.dart';
import 'package:parqueadero_2025_g2/widgets/base_view.dart';

class UniversitiesListScreen extends StatelessWidget {
  const UniversitiesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = UniversitiesService();

    return BaseView(
      title: 'Universidades',
      body: StreamBuilder<List<University>>(
        stream: service.streamAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final items = snapshot.data ?? const <University>[];
          if (items.isEmpty) {
            return const Center(child: Text('No hay universidades'));
          }
          return Stack(
            children: [
              ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final u = items[index];
                  return Dismissible(
                    key: ValueKey('uni-${u.id}'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (_) async {
                      return await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Eliminar'),
                              content: Text('¿Eliminar "${u.nombre}"?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                                FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
                              ],
                            ),
                          ) ??
                          false;
                    },
                    onDismissed: (_) async {
                      await service.delete(u.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Eliminada ${u.nombre}')),
                      );
                    },
                    child: ListTile(
                      leading: const Icon(Icons.school),
                      title: Text(u.nombre),
                      subtitle: Text('${u.nit} • ${u.telefono}\n${u.direccion}'),
                      isThreeLine: true,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/universidades/nueva', extra: u),
                    ),
                  );
                },
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton(
                  onPressed: () => context.push('/universidades/nueva'),
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
