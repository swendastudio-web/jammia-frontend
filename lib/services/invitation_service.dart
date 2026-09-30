import '../models/invitation.dart';
import 'api_client.dart';

/// Invite links, join requests and approvals.
class InvitationService {
  final ApiClient _api;

  InvitationService(this._api);

  Future<InviteLink> getMyInviteLink(int roomId) async {
    return InviteLink.fromJson(await _api.post('/api/rooms/$roomId/invite-link') as Map<String, dynamic>);
  }

  Future<InvitePreview> preview(String token) async {
    return InvitePreview.fromJson(await _api.get('/api/invites/$token') as Map<String, dynamic>);
  }

  Future<void> requestToJoin(String token) async {
    await _api.post('/api/invites/$token/join-requests');
  }

  Future<List<JoinRequest>> getPendingRequests(int roomId) async {
    final json = await _api.get('/api/rooms/$roomId/join-requests') as List<dynamic>;
    return json.map((r) => JoinRequest.fromJson(r as Map<String, dynamic>)).toList();
  }

  Future<void> approve(int roomId, int requestId) async {
    await _api.post('/api/rooms/$roomId/join-requests/$requestId/approve');
  }

  Future<void> reject(int roomId, int requestId) async {
    await _api.post('/api/rooms/$roomId/join-requests/$requestId/reject');
  }

  /// Accepts a full link ("https://.../invite/AbC...") or just the token, and returns the token.
  static String extractToken(String input) {
    final text = input.trim();
    const marker = '/invite/';
    final index = text.lastIndexOf(marker);
    final token = index >= 0 ? text.substring(index + marker.length) : text;
    return token.split(RegExp(r'[/?#\s]')).first;
  }
}
