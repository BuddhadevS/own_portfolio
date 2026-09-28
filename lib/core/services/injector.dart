import 'package:get/get.dart';
import 'package:buddhadev/network/api_services.dart';
import 'package:buddhadev/app/modules/chat/services/chat_service.dart';

Future<void> setupLocator() async {
  final apiService = ApiServices();
  Get.put<ApiServices>(apiService, permanent: true);

  // ChatService resolves ApiServices in its constructor via Get.find,
  // so ApiServices must already be registered before ChatService is created.
  final chatService = ChatService();
  Get.put<ChatService>(chatService, permanent: true);
}
