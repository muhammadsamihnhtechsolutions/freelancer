import 'package:freelancer_app/service/ApiService.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatSocketService {
  static io.Socket? _socket;
  static bool _listenersAttached = false;

  static io.Socket? get socket => _socket;

  static const String _baseUrl =
      "https://freelancesupermarket.hnhsofttechsolutions.com";

  static String? _connectedRole;

  static Future<void> connect({
    required String role,
    String? userId,
  }) async {
    try {
      final token = await ApiService.getTokenByRole(role);

      if (token == null || token.isEmpty) {
        throw Exception("Token missing for role: $role");
      }

      if (_socket != null && _socket!.connected && _connectedRole == role) {
        return;
      }

      if (_socket != null) {
        _socket!.disconnect();
        _socket!.dispose();
        _socket = null;
        _listenersAttached = false;
      }

      _connectedRole = role;

      _socket = io.io(
        _baseUrl,
        io.OptionBuilder()
            .setTransports(["websocket"])
            .disableAutoConnect()
            .setAuth({
              "token": token,
            })
            .setExtraHeaders({
              "Authorization": "Bearer $token",
            })
            .enableForceNew()
            .build(),
      );

      _socket!.connect();

      if (!_listenersAttached) {
        _listenersAttached = true;

        _socket!.onConnect((_) {
          // debugPrint("✅ Socket connected: ${_socket?.id}");

          if (userId != null && userId.isNotEmpty) {
            _socket!.emit("join:notifications");
          }
        });

        _socket!.onConnectError((data) {
          // debugPrint("❌ Socket connect error => $data");
        });

        _socket!.onDisconnect((_) {
          // debugPrint("⚠️ Socket disconnected");
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  static void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    _listenersAttached = false;
    _connectedRole = null;
  }

  static void joinNotifications() {
    _socket?.emit("join:notifications");
  }

  static void joinProposalRoom(String proposalId) {
    _socket?.emit("join:room", "proposal_$proposalId");
  }

  static void leaveProposalRoom(String proposalId) {
    _socket?.emit("leave:room", "proposal_$proposalId");
  }

  static void emitDelete({
    required String proposalId,
    required String messageId,
  }) {
    _socket?.emit("message:delete", {
      "proposalId": proposalId,
      "messageId": messageId,
    });
  }
}