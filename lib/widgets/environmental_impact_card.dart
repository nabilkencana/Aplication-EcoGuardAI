import 'package:flutter/material.dart';

class EnvironmentalImpactCard extends StatelessWidget {
  final int treesSaved;
  final double co2Reduced;
  final double waterSaved;

  const EnvironmentalImpactCard({
    super.key,
    required this.treesSaved,
    required this.co2Reduced,
    required this.waterSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.eco, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Dampak Lingkungan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildImpactItem(
                  '🌳',
                  'Pohon Terselamatkan',
                  '$treesSaved pohon',
                  Colors.green,
                ),
                _buildImpactItem(
                  '☁️',
                  'CO₂ Berkurang',
                  '${co2Reduced} kg',
                  Colors.blueGrey,
                ),
                _buildImpactItem(
                  '💧',
                  'Air Tersimpan',
                  '${waterSaved} L',
                  Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const LinearProgressIndicator(
              value: 0.78,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Target Bulanan',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  '78% Tercapai',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactItem(
    String emoji,
    String title,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 32)),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
