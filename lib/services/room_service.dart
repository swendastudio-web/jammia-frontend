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

  /// memberOrder: only for MANUAL — every member's user id, first receiver first.
  Future<Room> startRoom({
    required int roomId,
    required String turnOrderMethod,
    required DateTime startDate,
    List<int>? memberOrder,
  }) async {
    final date = '${startDate.year.toString().padLeft(4, '0')}-'
        '${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
    final json = await _api.post('/api/rooms/$roomId/start', body: {
      'turnOrderMethod': turnOrderMethod,
      'startDate': date,
      if (memberOrder != null) 'memberOrder': memberOrder,
    });
    return Room.fromJson(json as Map<String, dynamic>);
  }
}
