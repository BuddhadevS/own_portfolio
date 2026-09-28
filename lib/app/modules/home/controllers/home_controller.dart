import 'package:get/get.dart';
import 'package:buddhadev/shared/models/skill_model.dart';

class WorkExperienceItem {
  final String company;
  final String role;
  final String duration;
  final String domain;
  final String description;
  final List<String> techStack;
  final List<String> responsibilities;

  WorkExperienceItem({
    required this.company,
    required this.role,
    required this.duration,
    required this.domain,
    required this.description,
    required this.techStack,
    required this.responsibilities,
  });
}

class HomeController extends GetxController {
  final skills = [
    Skill(
      name: 'Java 17',
      description:
          'Expert in Java 17, OOP concepts, core collections, multithreading, and memory optimization. Solid foundation in building robust enterprise applications.',
      proficiency: 0.95,
      iconPath: 'assets/images/java.svg',
    ),
    Skill(
      name: 'Spring Boot 3',
      description:
          'Deep experience in Spring Boot 3, Spring MVC, Spring Data JPA, Spring Security, Spring Batch, and building resilient microservices.',
      proficiency: 0.92,
      iconPath: 'assets/images/flutter.svg',
    ),
    Skill(
      name: 'Microservices',
      description:
          'Adept at designing microservices architecture, API Gateways, service-to-service communication, SAGA pattern, and event-driven architectures.',
      proficiency: 0.90,
      iconPath: 'assets/images/architecture.svg',
    ),
    Skill(
      name: 'Keycloak & OAuth2',
      description:
          'Centralized authentication & authorization with Keycloak, OAuth 2.0, OpenID Connect (OIDC), JWT, PKCE, RBAC, and Google/Apple IDPs.',
      proficiency: 0.88,
      iconPath: 'assets/images/apis.svg',
    ),
    Skill(
      name: 'Spring AI & GenAI',
      description:
          'Building AI-driven workflows with Spring AI, RAG (Retrieval-Augmented Generation), Vector Embeddings, LLM integrations, Ollama, and Gemini API.',
      proficiency: 0.85,
      iconPath: 'assets/images/ai.svg',
    ),
    Skill(
      name: 'RESTful APIs',
      description:
          'Designing clean, secure, and idempotent RESTful API endpoints with Swagger/OpenAPI documentation, Bruno, and Postman testing.',
      proficiency: 0.92,
      iconPath: 'assets/images/apis.svg',
    ),
    Skill(
      name: 'PostgreSQL & SQL',
      description:
          'Database design, indexing, JPA/Hibernate ORM, query optimization, and transaction management with PostgreSQL and MySQL.',
      proficiency: 0.88,
      iconPath: 'assets/images/java.svg',
    ),
    Skill(
      name: 'Redis Caching',
      description:
          'High-performance caching strategies, distributed session management, and pub/sub message messaging with Redis.',
      proficiency: 0.85,
      iconPath: 'assets/images/apis.svg',
    ),
    Skill(
      name: 'Microsoft Azure',
      description:
          'Cloud deployment on Azure Container Apps (ACA), Azure Container Registry (ACR), Azure PostgreSQL, Azure KeyVault, and EventHubs.',
      proficiency: 0.82,
      iconPath: 'assets/images/code_magic.svg',
    ),
    Skill(
      name: 'Docker & CI/CD',
      description:
          'Containerizing Spring Boot microservices with Docker, multi-stage builds, automated GitHub Actions CI/CD pipelines, and Maven.',
      proficiency: 0.88,
      iconPath: 'assets/images/git.svg',
    ),
    Skill(
      name: 'OpenTelemetry',
      description:
          'Distributed tracing, metrics collection, and centralized logging using OpenTelemetry, Grafana Cloud, Loki, Tempo, Mimir, and Jaeger.',
      proficiency: 0.85,
      iconPath: 'assets/images/lint.svg',
    ),
    Skill(
      name: 'Git & GitHub',
      description:
          'Proficient in version control, branching strategies, code reviews, PR workflows, and GitHub Actions automation.',
      proficiency: 0.90,
      iconPath: 'assets/images/git.svg',
    ),
  ].obs;

  final workExperiences = [
    WorkExperienceItem(
      company: 'CoffeeWeb Pvt. Ltd.',
      role: 'Backend Developer / Software Engineer',
      duration: 'March 2026 - Present',
      domain: 'Social Media / Digital Platform',
      description:
          'CoffeeWeb is a cloud-native digital platform built for the global coffee industry, connecting coffee professionals and businesses through industry insights, market news, and interactive community engagement.',
      techStack: [
        'Java 17',
        'Spring Boot 3',
        'Spring Security',
        'Keycloak',
        'OAuth 2.0 / OIDC',
        'Azure ACA',
        'PostgreSQL',
        'Redis',
        'Spring AI / RAG',
        'OpenTelemetry',
        'Docker',
      ],
      responsibilities: [
        'Developed and maintained Java 17 / Spring Boot 3 microservices covering Authentication, Posts, Engagement, Feeds, Relationships, Media, and Notifications.',
        'Designed and implemented centralized authentication architecture using Keycloak with OAuth 2.0, OpenID Connect (OIDC), PKCE, and RBAC.',
        'Integrated external identity providers (Google & Apple Auth) into centralized Keycloak auth flows.',
        'Engineered core features including posts, comments, likes, user relationship graphs, and personalized feed generation.',
        'Implemented GenAI capabilities using Spring AI, RAG (Retrieval-Augmented Generation), vector embeddings, and Ollama/Gemini API integration.',
        'Optimized data access layers using PostgreSQL, Spring Data JPA/Hibernate, and Redis caching for low-latency feed generation.',
        'Set up full-stack observability and distributed tracing with OpenTelemetry, Grafana Cloud, Loki, Tempo, Mimir, and Jaeger.',
        'Containerized microservices with Docker and deployed to Azure Container Apps (ACA) via Azure Container Registry (ACR) and KeyVault.',
      ],
    ),
    WorkExperienceItem(
      company: 'Zediant Technologies Pvt. Ltd.',
      role: 'Backend Developer',
      duration: 'Sept 2024 - March 2026',
      domain: 'Fintech (Loan Recovery Automation)',
      description:
          'Loan Recovery Automation (LRA) Platform is a debt collection management system developed to automate and speed up the loan recovery and repayment process through a modular microservices architecture.',
      techStack: [
        'Java',
        'Spring Boot',
        'RESTful APIs',
        'Microservices',
        'PostgreSQL',
        'Payment Gateways',
        'Agile/Scrum',
      ],
      responsibilities: [
        'Designed and contributed to the microservices architecture for delinquency detection, bucket management, and automated collector assignment.',
        'Developed backend services handling complex financial workflows, loan state transitions, and real-time repayment notifications.',
        'Integrated SMS/Email notification gateways and third-party payment gateway APIs for seamless loan recovery.',
        'Optimized service performance to handle large volumes of loan and customer data efficiently.',
        'Collaborated with frontend and QA teams during Agile sprint planning, standups, and peer code reviews.',
      ],
    ),
  ];
}
