// Di file consumption_card.dart
import 'package:flutter/material.dart';

class ConsumptionCard extends StatelessWidget {
  final String title;
  final String value;
  final double percentage;
  final IconData icon;
  final Color color;
  final String subtitle;
  final String? status; // Tambahkan status

  const ConsumptionCard({
    Key? key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.icon,
    required this.color,
    required this.subtitle,
    this.status, // Status opsional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris atas: Icon, Title, dan Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, size: 20, color: color),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                // Badge Status (jika ada)
                if (status != null && status!.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: status!.toLowerCase() == 'optimal'
                          ? const Color(0xFF34C759).withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status!,
                      style: TextStyle(
                        color: status!.toLowerCase() == 'optimal'
                            ? const Color(0xFF34C759)
                            : Colors.orange,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Nilai Konsumsi
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: 60, // Minimum height untuk value
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Value - dengan handling overflow
                    Flexible(
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                          height: 1.1,
                        ),
                        maxLines: 2, // Maksimal 2 baris
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Subtitle dan Persentase
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              percentage >= 0
                                  ? Icons.trending_up_rounded
                                  : Icons.trending_down_rounded,
                              color: percentage >= 0
                                  ? const Color(0xFF34C759)
                                  : const Color(0xFFFF3B30),
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${percentage >= 0 ? '+' : ''}${percentage.toStringAsFixed(1)}%',
                              style: TextStyle(
                                color: percentage >= 0
                                    ? const Color(0xFF34C759)
                                    : const Color(0xFFFF3B30),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}