import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'universities_service.dart';
import 'university.dart';
import 'package:parqueadero_2025_g2/widgets/base_view.dart';

class UniversityFormScreen extends StatefulWidget {
  final University? university;
  const UniversityFormScreen({super.key, this.university});

  @override
  State<UniversityFormScreen> createState() => _UniversityFormScreenState();
}

class _UniversityFormScreenState extends State<UniversityFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nit = TextEditingController();
  final _nombre = TextEditingController();
  final _direccion = TextEditingController();
  final _telefono = TextEditingController();
  final _pagina = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final u = widget.university;
    if (u != null) {
      _nit.text = u.nit;
      _nombre.text = u.nombre;
      _direccion.text = u.direccion;
      _telefono.text = u.telefono;
      _pagina.text = u.paginaWeb;
    }
  }

  @override
  void dispose() {
    _nit.dispose();
    _nombre.dispose();
    _direccion.dispose();
    _telefono.dispose();
    _pagina.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final service = UniversitiesService();
    final u = University(
      id: widget.university?.id ?? '',
      nit: _nit.text.trim(),
      nombre: _nombre.text.trim(),
      direccion: _direccion.text.trim(),
      telefono: _telefono.text.trim(),
      paginaWeb: _pagina.text.trim(),
    );
    if (widget.university == null) {
      await service.create(u);
    } else {
      await service.update(widget.university!.id, u);
    }
    if (!mounted) return;
    setState(() => _saving = false);
    context.pop();
  }

  String? _required(String? v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null;

  String? _url(String? v) {
    if (v == null || v.trim().isEmpty) return 'Requerido';
    final text = v.trim();
    final uri = Uri.tryParse(text);
    if (uri == null || (!uri.isScheme('http') && !uri.isScheme('https'))) {
      return 'URL inválida (http/https)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: widget.university == null ? 'Nueva Universidad' : 'Editar Universidad',
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nit,
                    decoration: const InputDecoration(labelText: 'NIT'),
                    validator: _required,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nombre,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator: _required,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _direccion,
                    decoration: const InputDecoration(labelText: 'Dirección'),
                    validator: _required,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _telefono,
                    decoration: const InputDecoration(labelText: 'Teléfono'),
                    validator: _required,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _pagina,
                    decoration: const InputDecoration(labelText: 'Página web (URL)'),
                    validator: _url,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _saving ? null : _submit,
                      child: _saving
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : Text(widget.university == null ? 'Guardar' : 'Guardar cambios'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
