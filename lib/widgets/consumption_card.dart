import 'package:flutter/material.dart';

class ConsumptionCard extends StatelessWidget {
  final String title;
  final String value;
  final double percentage;
  final IconData icon;
  final Color color;
  final String subtitle;

  const ConsumptionCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.icon,
    required this.color,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 140),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header dengan icon dan title
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                        overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              // Nilai konsumsi dengan flexible layout
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        _formatValue(value),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getUnit(value),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 4),
              // Subtitle
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),

              const SizedBox(height: 8),
              // Persentase perubahan - dengan layout yang bisa wrap
              _buildPercentageChange(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPercentageChange() {
    final isPositive = percentage >= 0;
    final percentText = '${percentage.abs().toStringAsFixed(1)}%';
    final directionText = isPositive ? 'naik' : 'turun';
    final fullText = '$percentText $directionText dari kemarin';
    
    // Cek apakah teks panjang (lebih dari 20 karakter untuk font size 11)
    final bool isLongText = fullText.length > 20;

    if (isLongText) {
      // Layout untuk teks panjang - icon di atas, teks di bawah
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPositive
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                color: isPositive ? Colors.red : Colors.green,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                percentText,
                style: TextStyle(
                  color: isPositive ? Colors.red : Colors.green,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            '$directionText dari kemarin',
            style: TextStyle(
              color: isPositive ? Colors.red : Colors.green,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    } else {
      // Layout untuk teks pendek - semuanya dalam satu baris
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive
                ? Icons.arrow_upward_rounded
                : Icons.arrow_downward_rounded,
            color: isPositive ? Colors.red : Colors.green,
            size: 14,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              fullText,
              style: TextStyle(
                color: isPositive ? Colors.red : Colors.green,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      );
    }
  }

  // Helper method to format value
  String _formatValue(String value) {
    final RegExp regex = RegExp(r'([\d.,]+)');
    final match = regex.firstMatch(value);
    if (match != null) {
      return match.group(1)!;
    }
    return value;
  }

  // Helper method to get unit
  String _getUnit(String value) {
    final RegExp regex = RegExp(r'[\d.,]+\s*(.*)');
    final match = regex.firstMatch(value);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!.trim();
    }
    return '';
  }
}