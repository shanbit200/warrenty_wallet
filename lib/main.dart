import 'package:flutter/material.dart';

void main() => runApp(const WarrantyWalletApp());

class WarrantyWalletApp extends StatelessWidget {
  const WarrantyWalletApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Warranty Wallet',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3456D1)),
      scaffoldBackgroundColor: const Color(0xFFF7F8FC),
    ),
    home: const WalletHome(),
  );
}

class WarrantyItem {
  WarrantyItem(this.name, this.brand, this.expiry, this.icon, this.color);
  final String name, brand;
  final DateTime expiry;
  final IconData icon;
  final Color color;
}

class WalletHome extends StatefulWidget {
  const WalletHome({super.key});
  @override
  State<WalletHome> createState() => _WalletHomeState();
}

class _WalletHomeState extends State<WalletHome> {
  int _tab = 0;
  String _query = '';
  final List<WarrantyItem> _items = [
    WarrantyItem(
      'AirPods Pro',
      'Apple',
      DateTime(2026, 10, 5),
      Icons.headphones_rounded,
      const Color(0xFFE8EDFF),
    ),
    WarrantyItem(
      'Galaxy S24',
      'Samsung',
      DateTime(2027, 1, 18),
      Icons.phone_android_rounded,
      const Color(0xFFE8F8F2),
    ),
    WarrantyItem(
      'Espresso Machine',
      'Breville',
      DateTime(2026, 9, 24),
      Icons.coffee_maker_rounded,
      const Color(0xFFFFF0E3),
    ),
    WarrantyItem(
      'MacBook Air',
      'Apple',
      DateTime(2027, 6, 2),
      Icons.laptop_mac_rounded,
      const Color(0xFFF3EAFF),
    ),
  ];
  List<WarrantyItem> get _visible => _items
      .where(
        (x) =>
            '${x.name} ${x.brand}'.toLowerCase().contains(_query.toLowerCase()),
      )
      .toList();
  int get _soon => _items
      .where((x) => x.expiry.difference(DateTime(2026, 9, 19)).inDays <= 30)
      .length;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: _tab == 0 ? _wallet() : _empty()),
    floatingActionButton: _tab == 0
        ? FloatingActionButton.extended(
            onPressed: _add,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add item'),
          )
        : null,
    bottomNavigationBar: NavigationBar(
      selectedIndex: _tab,
      onDestinationSelected: (v) => setState(() => _tab = v),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.wallet_outlined),
          selectedIcon: Icon(Icons.wallet_rounded),
          label: 'Wallet',
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_none_rounded),
          selectedIcon: Icon(Icons.notifications_rounded),
          label: 'Reminders',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings_rounded),
          label: 'Settings',
        ),
      ],
    ),
  );

  Widget _wallet() => CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3456D1),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(
                      Icons.verified_user_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Warranty Wallet',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Everything you own, covered.',
                          style: TextStyle(color: Color(0xFF667085)),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Good afternoon, Shantanu',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -.6,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Your coverage is looking good.',
                style: TextStyle(fontSize: 15, color: Color(0xFF667085)),
              ),
              const SizedBox(height: 20),
              _overview(),
              const SizedBox(height: 22),
              TextField(
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: 'Search your wallet',
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text(
                    'Your items',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const Spacer(),
                  Text(
                    '${_visible.length} saved',
                    style: const TextStyle(color: Color(0xFF667085)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
        sliver: _visible.isEmpty
            ? const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: Text('No matching items')),
                ),
              )
            : SliverList.separated(
                itemCount: _visible.length,
                separatorBuilder: (_, __) => const SizedBox(height: 11),
                itemBuilder: (_, i) => _card(_visible[i]),
              ),
      ),
    ],
  );

  Widget _overview() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF3456D1), Color(0xFF5476EB)],
      ),
      borderRadius: BorderRadius.circular(22),
    ),
    child: Row(
      children: [
        const Icon(
          Icons.shield_moon_rounded,
          color: Color(0xFFE7ECFF),
          size: 42,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_items.length} active warranties',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _soon == 0
                    ? 'Nothing needs your attention.'
                    : '$_soon item${_soon == 1 ? '' : 's'} expiring soon',
                style: const TextStyle(color: Color(0xFFE7ECFF)),
              ),
            ],
          ),
        ),
        const Icon(Icons.arrow_forward_rounded, color: Colors.white),
      ],
    ),
  );

  Widget _card(WarrantyItem item) {
    final days = item.expiry.difference(DateTime(2026, 9, 19)).inDays;
    final warning = days <= 30;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () => _details(item),
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 51,
                height: 51,
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(item.icon, color: const Color(0xFF30425D)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.brand,
                      style: const TextStyle(color: Color(0xFF667085)),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    warning ? '$days days left' : 'Active',
                    style: TextStyle(
                      color: warning
                          ? const Color(0xFFD96C08)
                          : const Color(0xFF198754),
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Expires ${item.expiry.month}/${item.expiry.day}/${item.expiry.year}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF98A2B3),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _empty() {
    final reminders = _tab == 1;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(34),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              reminders
                  ? Icons.notifications_active_outlined
                  : Icons.tune_rounded,
              size: 62,
              color: const Color(0xFF3456D1),
            ),
            const SizedBox(height: 16),
            Text(
              reminders ? 'Coverage reminders' : 'Your settings',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text(
              reminders
                  ? 'We’ll remind you 30 days before a warranty ends.'
                  : 'Manage your wallet and notification preferences.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF667085)),
            ),
          ],
        ),
      ),
    );
  }

  void _details(WarrantyItem item) => showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 34),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(item.brand, style: const TextStyle(color: Color(0xFF667085))),
          const SizedBox(height: 24),
          _line(
            Icons.event_available_rounded,
            'Warranty expires',
            '${item.expiry.month}/${item.expiry.day}/${item.expiry.year}',
          ),
          _line(Icons.receipt_long_rounded, 'Receipt', 'Stored securely'),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit item'),
          ),
        ],
      ),
    ),
  );
  Widget _line(IconData icon, String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Row(
      children: [
        Icon(icon, color: const Color(0xFF3456D1)),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Color(0xFF667085))),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ],
    ),
  );

  void _add() {
    final name = TextEditingController(), brand = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheet) => Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          4,
          24,
          MediaQuery.of(sheet).viewInsets.bottom + 28,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add to wallet',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: name,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Item name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: brand,
              decoration: const InputDecoration(
                labelText: 'Brand',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (name.text.trim().isEmpty) return;
                  setState(
                    () => _items.add(
                      WarrantyItem(
                        name.text.trim(),
                        brand.text.trim().isEmpty
                            ? 'Unspecified'
                            : brand.text.trim(),
                        DateTime.now().add(const Duration(days: 365)),
                        Icons.inventory_2_rounded,
                        const Color(0xFFE8EDFF),
                      ),
                    ),
                  );
                  Navigator.pop(sheet);
                },
                child: const Text('Save item'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
