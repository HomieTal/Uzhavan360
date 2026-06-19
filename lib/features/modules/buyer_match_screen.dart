import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/section_header.dart';

class BuyerMatchScreen extends StatefulWidget {
  const BuyerMatchScreen({super.key});

  @override
  State<BuyerMatchScreen> createState() => _BuyerMatchScreenState();
}

class _BuyerMatchScreenState extends State<BuyerMatchScreen> {
  final _cropController = TextEditingController(text: 'Paddy');
  final _quantityController = TextEditingController(text: '500 kg');
  final _priceController = TextEditingController(text: '₹40/kg');

  @override
  void dispose() {
    _cropController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    return AppScaffold(
      title: context.tr('buyerMatch'),
      body: ListView(
        children: [
          SectionHeader(title: context.tr('buyerMatch'), subtitle: context.tr('buyerMatchSubtitle')),
          const SizedBox(height: 14),
          TextField(controller: _cropController, decoration: InputDecoration(labelText: context.tr('cropName'), prefixIcon: const Icon(Icons.local_florist_rounded))),
          const SizedBox(height: 12),
          TextField(controller: _quantityController, decoration: InputDecoration(labelText: context.tr('quantity'), prefixIcon: const Icon(Icons.scale_rounded))),
          const SizedBox(height: 12),
          TextField(controller: _priceController, decoration: InputDecoration(labelText: context.tr('expectedPrice'), prefixIcon: const Icon(Icons.currency_rupee_rounded))),
          const SizedBox(height: 16),
          Text(context.tr('nearbyBuyers'), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          ...controller.buyerOffers.map(
            (offer) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(offer.buyerName, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800))),
                        Text(offer.offeredPrice, style: const TextStyle(fontWeight: FontWeight.w800)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(context.tr(offer.buyerTypeKey)),
                    Text('${context.tr('requiredQuantity')}: ${offer.requiredQuantity}'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: OutlinedButton(onPressed: () {}, child: Text(context.tr('contact')))),
                        const SizedBox(width: 10),
                        Expanded(child: ElevatedButton(onPressed: () {}, child: Text(context.tr('acceptOffer')))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
