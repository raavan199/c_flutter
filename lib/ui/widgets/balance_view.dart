import 'package:flutter/material.dart';

import '../../../exports/resources.dart';
import '../../../utilities/shadow.dart';

class BalanceView extends StatelessWidget {
  const BalanceView({
    required this.openingBalance,
    required this.newBilling,
    required this.adjustments,
    required this.closingBalance,
    Key? key
  }) : super(key: key);

  final double openingBalance;
  final double newBilling;
  final double adjustments;
  final double closingBalance;

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [Shadows.greyShadow],
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Opening Balance : ',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  "INR ${openingBalance.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'New Billing : ',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  "INR ${newBilling.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Payment + Adjustments : ',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  "INR ${adjustments.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Closing Balance : ',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.primary,
                    fontWeight: AppFonts.extraBold,
                  ),
                ),
                Text(
                  "INR ${closingBalance.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.primary,
                    fontWeight: AppFonts.extraBold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
}
