import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:buddhadev/network/api_services.dart';

class ChatService extends GetxService {
  final ApiServices _apiServices = Get.find<ApiServices>();

  // Fallback responses for common questions
  final Map<String, String> _fallbackResponses = {
    'experience': 'Buddhadev Sahu is a Java Backend Developer with 2+ years of experience specializing in Java 17, Spring Boot 3, Microservices Architecture, Keycloak OAuth2/OIDC, Azure Cloud, and Spring AI / Generative AI integrations.',
    'skills': 'Buddhadev\'s core skills include Java 17, Spring Boot 3, Spring Data JPA, Spring Security, Keycloak, RESTful APIs, Microservices, Azure Container Apps, Docker, PostgreSQL, Redis, Spring AI (RAG, Vector Embeddings, Ollama), and OpenTelemetry observability.',
    'contact': 'You can reach Buddhadev via email at buddhadev0509@gmail.com, call/WhatsApp at +91 7001780223, connect on LinkedIn (linkedin.com/in/buddhadev-sahu), or schedule a meeting directly using the calendar link in this app.',
    'location': 'Buddhadev is based in India and open to remote, hybrid, and relocation opportunities for Java Backend, Spring Boot, and Microservices roles.',
    'projects': 'Key projects include CoffeeWeb (a cloud-native social media digital platform for the coffee industry with Keycloak auth, Azure ACA, and Spring AI) and Loan Recovery Automation Platform (a fintech debt collection system with microservices architecture).',
    'default': 'Thanks for reaching out! Buddhadev specializes in Java 17, Spring Boot 3, Microservices, and Cloud/AI solutions. Feel free to contact him directly via email (buddhadev0509@gmail.com) or phone (+91 7001780223).'
  };

  Future<String> sendMessage(String message) async {
    debugPrint("📡 Chat Service: Processing message: $message");
    
    try {
      final response = await _apiServices.askQuestion(message).timeout(
        const Duration(seconds: 25),
        onTimeout: () {
          return _getFallbackResponse(message);
        },
      );
      return response;
    } catch (e) {
      final fallbackResponse = _getFallbackResponse(message);
      return fallbackResponse;
    }
  }

  String _getFallbackResponse(String message) {
    final lowercaseMessage = message.toLowerCase().trim();
    
    if (lowercaseMessage.contains('experience') || lowercaseMessage.contains('work') || lowercaseMessage.contains('background')) {
      return _fallbackResponses['experience']!;
    }
    
    if (lowercaseMessage.contains('skill') || lowercaseMessage.contains('technology') || lowercaseMessage.contains('tech')) {
      return _fallbackResponses['skills']!;
    }
    
    if (lowercaseMessage.contains('contact') || lowercaseMessage.contains('reach') || lowercaseMessage.contains('email') || lowercaseMessage.contains('phone')) {
      return _fallbackResponses['contact']!;
    }
    
    if (lowercaseMessage.contains('location') || lowercaseMessage.contains('located') || lowercaseMessage.contains('where') || lowercaseMessage.contains('live')) {
      return _fallbackResponses['location']!;
    }
    
    if (lowercaseMessage.contains('project') || lowercaseMessage.contains('portfolio') || lowercaseMessage.contains('coffeeweb') || lowercaseMessage.contains('lra')) {
      return _fallbackResponses['projects']!;
    }
    
    return _fallbackResponses['default']!;
  }
}
