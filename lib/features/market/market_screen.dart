import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/feature_card.dart';
import '../../core/widgets/section_header.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AppStateController>();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionHeader(title: context.tr('market'), subtitle: context.tr('marketSubtitle')),
        const SizedBox(height: 16),
        FeatureCard(
          title: context.tr('buyerMatch'),
          subtitle: context.tr('buyerMatchQuickAction'),
          icon: Icons.handshake_rounded,
          gradientColors: const [Color(0xFF00695C), Color(0xFF26A69A)],
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.buyerMatch),
        ),
        const SizedBox(height: 16),
        FeatureCard(
          title: context.tr('govtSchemes'),
          subtitle: context.tr('govtSchemesQuickAction'),
          icon: Icons.verified_rounded,
          gradientColors: const [Color(0xFF2E7D32), Color(0xFFA5D6A7)],
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.govtSchemes),
        ),
        const SizedBox(height: 20),
        SectionHeader(title: context.tr('nearbyBuyers'), subtitle: context.tr('nearbyBuyersSubtitle')),
        const SizedBox(height: 12),
        ...controller.buyerOffers.take(3).map(
          (offer) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(child: Text(offer.buyerName[0])),
              title: Text(offer.buyerName, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('${context.tr(offer.buyerTypeKey)} • ${offer.requiredQuantity}'),
              trailing: Text(offer.offeredPrice, style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
          ),
        ),
      ],
    );
  }
}