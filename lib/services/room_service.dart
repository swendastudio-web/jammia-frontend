import '../models/room.dart';
import 'api_client.dart';

/// Savings rooms: list, create, view, start.
class RoomService {
  final ApiClient _api;

  RoomService(this._api);

  Future<List<RoomSummary>> getMyRooms() async {
    final json = await _api.get('/api/rooms') as List<dynamic>;
    return json.map((r) => RoomSummary.fromJson(r as Map<String, dynamic>)).toList();
  }

  Future<Room> getRoom(int roomId) async {
    return Room.fromJson(await _api.get('/api/rooms/$roomId') as Map<String, dynamic>);
  }

  Future<Room> createRoom({
    required String name,
    required String? description,
    required num contributionAmount,
    required String currency,
    required String frequency,
    required int maxMembers,
  }) async {
    final json = await _api.post('/api/rooms', body: {
      'name': name,
      'description': description,
      'contributionAmount': contributionAmount,
      'currency': currency,
      'frequency': frequency,
      'maxMembers': maxMembers,
    });
    return Room.fromJson(json as Map<String, dynamic>);
  }

  /// Starts the next round. memberOrder: only for MANUAL — every member's user id, first receiver first.
  /// startDate is not needed for 5-minute test rooms (they start at once).
  Future<Room> startRoom({
    required int roomId,
    required String turnOrderMethod,
    DateTime? startDate,
    List<int>? memberOrder,
  }) async {
    final json = await _api.post('/api/rooms/$roomId/start', body: {
      'turnOrderMethod': turnOrderMethod,
      if (startDate != null)
        'startDate': '${startDate.year.toString().padLeft(4, '0')}-'
            '${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}',
      if (memberOrder != null) 'memberOrder': memberOrder,
    });
    return Room.fromJson(json as Map<String, dynamic>);
  }

  /// Admin, between rounds.
  Future<Room> updateMaxMembers(int roomId, int maxMembers) async {
    final json = await _api.put('/api/rooms/$roomId/max-members', body: {'maxMembers': maxMembers});
    return Room.fromJson(json as Map<String, dynamic>);
  }

  /// Admin, between rounds.
  Future<Room> removeMember(int roomId, int memberUserId) async {
    return Room.fromJson(await _api.delete('/api/rooms/$roomId/members/$memberUserId') as Map<String, dynamic>);
  }

  /// A member, between rounds.
  Future<void> leaveRoom(int roomId) async {
    await _api.post('/api/rooms/$roomId/leave');
  }

  /// Rounds history, newest first.
  Future<List<RoomRound>> getRounds(int roomId) async {
    final json = await _api.get('/api/rooms/$roomId/rounds') as List<dynamic>;
    return json.map((r) => RoomRound.fromJson(r as Map<String, dynamic>)).toList();
  }

  /// Whether this backend offers the 5-minute test period (only a development backend does).
  Future<bool> fiveMinuteCyclesEnabled() async {
    final json = await _api.get('/api/app-info') as Map<String, dynamic>;
    return json['fiveMinuteCyclesEnabled'] as bool;
  }
}
