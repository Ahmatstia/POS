import 'package:intl/intl.dart';

/// Format Rupiah amount with thousands separator and Rp prefix.
String formatCurrency(int rupiah) {
  final formatter = NumberFormat('#,##0', 'id_ID');
  return 'Rp ${formatter.format(rupiah)}';
}

/// Format amount for display without Rp prefix (for calculations, etc).
String formatNumber(int amount) {
  final formatter = NumberFormat('#,##0', 'id_ID');
  return formatter.format(amount);
}
