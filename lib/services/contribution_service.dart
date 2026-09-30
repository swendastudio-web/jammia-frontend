import '../models/contribution.dart';
import '../models/owed_payment.dart';
import 'api_client.dart';

/// Payment tracking: the schedule, "I paid", "I received it".
class ContributionService {
  final ApiClient _api;

  ContributionService(this._api);

  /// Payments of the newest round, or of [roundNumber] (history).
  Future<List<Contribution>> getContributions(int roomId, {int? roundNumber}) async {
    final query = roundNumber == null ? '' : '?round=$roundNumber';
    final json = await _api.get('/api/rooms/$roomId/contributions$query') as List<dynamic>;
    return json.map((c) => Contribution.fromJson(c as Map<String, dynamic>)).toList();
  }

  /// The "You owe" reminder: unpaid payments whose turn has started, in every room.
  Future<List<OwedPayment>> getOwedPayments() async {
    final json = await _api.get('/api/users/me/owed-payments') as List<dynamic>;
    return json.map((p) => OwedPayment.fromJson(p as Map<String, dynamic>)).toList();
  }

  Future<void> markPaid(int roomId, int contributionId) async {
    await _api.post('/api/rooms/$roomId/contributions/$contributionId/paid');
  }

  Future<void> confirmReceived(int roomId, int contributionId) async {
    await _api.post('/api/rooms/$roomId/contributions/$contributionId/confirm');
  }
}
