// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html; // Only valid on web builds
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'api.dart';

class ProductsPage extends StatefulWidget {
  final ApiClient api;
  const ProductsPage({super.key, required this.api});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _searchCtrl = TextEditingController();
  List<dynamic> _products = [];
  List<dynamic> _clients = [];
  String? _selectedClient;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final clients = await widget.api.getClients();
    setState(() => _clients = clients);
    if (kIsWeb) {
      // Use hostname (without port). If matches a known client slug, select it.
      final hostname = html.window.location.hostname; // e.g., brazil.in8.local
      final match = clients.cast<Map<String, dynamic>>().firstWhere(
        (c) => c['slug'] == hostname,
        orElse: () => {},
      );
      _selectedClient = (match.isNotEmpty)
          ? (match['slug'] as String)
          : clients.isNotEmpty
              ? clients.first['slug'] as String
              : null;
    } else {
      _selectedClient = clients.isNotEmpty ? clients.first['slug'] as String : null;
    }
    await _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _loading = true);
    final items = await widget.api.getProducts(search: _searchCtrl.text.trim(), client: _selectedClient);
    setState(() {
      _products = items;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: TextField(
                  controller: _searchCtrl,
                  decoration: const InputDecoration(hintText: 'Filtrar por nome/descrição'),
                  onSubmitted: (_) => _loadProducts(),
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _selectedClient,
                items: _clients
                    .map((c) => DropdownMenuItem<String>(
                          value: c['slug'] as String,
                          child: Text(c['name'] as String),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _selectedClient = v),
              ),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: _loadProducts, child: const Text('Buscar')),
            ]),
            const SizedBox(height: 12),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemBuilder: (_, i) {
                        final p = _products[i];
                        return ListTile(
                          title: Text(p['name']?.toString() ?? 'Sem nome'),
                          subtitle: Text(p['description']?.toString() ?? ''),
                          leading: p['image'] != null
                              ? Image.network(p['image'], width: 56, height: 56, fit: BoxFit.cover)
                              : const Icon(Icons.image_not_supported),
                        );
                      },
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemCount: _products.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
