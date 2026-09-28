import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:buddhadev/network/api_constants.dart';
import 'package:buddhadev/shared/models/contact_model.dart';

class ApiServices extends GetConnect {
  ApiServices() {
    httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.timeout = const Duration(seconds: 20);
    httpClient.defaultContentType = 'application/json';
    httpClient.followRedirects = true;
    httpClient.maxRedirects = 3;
  }

  @override
  void onInit() {
    httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.timeout = const Duration(seconds: 20);
    httpClient.defaultContentType = 'application/json';
    httpClient.followRedirects = true;
    httpClient.maxRedirects = 3;
    super.onInit();
  }

  Future<String> sendContact(ContactModel contact) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.contact}');
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(contact.toJson()),
      );

      if (response.statusCode == 200) {
        return "Message sent successfully!";
      } else if (response.statusCode == 429) {
        return "You've reached the message limit. Please try again later.";
      } else if (response.statusCode == 400) {
        return "Invalid input data. Please check your entries.";
      } else {
        throw Exception("Failed: ${response.statusCode} ${response.body}");
      }
    } catch (_) {
      return "Something went wrong. Please try again.";
    }
  }

  Future<String> askQuestion(String question) async {
    for (int i = 0; i < ApiConstants.fallbackUrls.length; i++) {
      final baseUrl = ApiConstants.fallbackUrls[i];

      try {
        final client = GetConnect();
        client.baseUrl = baseUrl;
        client.timeout = const Duration(seconds: 8);
        client.defaultContentType = 'application/json';

        final headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'User-Agent': 'Flutter-Portfolio-App',
        };

        final response = await client
            .post(ApiConstants.chatbot, {
              'question': question,
            }, headers: headers)
            .timeout(
              const Duration(seconds: 10),
              onTimeout: () {
                throw Exception('Request timeout for $baseUrl');
              },
            );

        if (response.status.hasError) {
          if (i == ApiConstants.fallbackUrls.length - 1) {
            throw Exception('All endpoints failed: ${response.statusText}');
          }
          continue;
        }

        if (response.body is Map<String, dynamic>) {
          final data = response.body as Map<String, dynamic>;
          if (data['status'] == 'success') {
            return data['answer'] as String;
          } else {
            if (i == ApiConstants.fallbackUrls.length - 1) {
              throw Exception('API error: ${data['status']}');
            }
            continue;
          }
        } else {
          if (i == ApiConstants.fallbackUrls.length - 1) {
            throw Exception('Invalid response format');
          }
          continue;
        }
      } catch (e) {
        if (i == ApiConstants.fallbackUrls.length - 1) {
          throw Exception('All chatbot endpoints failed: $e');
        }
      }
    }

    throw Exception('No endpoints available');
  }
}
