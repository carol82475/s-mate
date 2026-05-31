import 'api_client.dart';

class TripGenerationGate {
  const TripGenerationGate._();

  static Future<bool> canGenerateTrip() async {
    try {
      // TODO: Replace with the final subscription/quota endpoint once the
      // backend contract is published.
      final response = await ApiClient.get('/purchase/status');
      final data = response['data'];

      if (data is! Map<String, dynamic>) {
        return true;
      }

      final active = data['active'] == true ||
          data['isActive'] == true ||
          data['hasActivePlan'] == true;
      final explicitlyInactive = data['active'] == false ||
          data['isActive'] == false ||
          data['hasActivePlan'] == false;
      final quota = _readQuota(data);

      if (explicitlyInactive) return false;
      if (quota != null) return quota > 0;

      if (active) return true;

      return true;
    } catch (e) {
      // If purchase status cannot be verified, keep the paid-generation guard
      // closed and send the user through the purchase flow.
      return false;
    }
  }

  static int? _readQuota(Map<String, dynamic> data) {
    final raw = data['quotaRemaining'] ??
        data['remainingTrips'] ??
        data['tripQuotaRemaining'] ??
        data['quota'];

    if (raw is num) return raw.toInt();
    return int.tryParse(raw?.toString() ?? '');
  }
}
