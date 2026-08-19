import '../core/constants/appAssets.dart';
import '../models/flashcard.dart';
import '../models/topic.dart';
import '../models/track.dart';
import '../models/user_stats.dart';
import '../theme/app_colors.dart';

/// In-memory seed data for the whole app. This is a UI-only build: there is
/// no networking, no persistence, and no Firebase — everything here just
/// lives in RAM for the lifetime of the app session. Providers read and
/// mutate these lists directly.
class MockData {
  MockData._();

  static final List<Track> tracks = [
    const Track(
      id: 'frontend',
      name: 'Frontend',
      description: 'Master the core concepts and be ready for any frontend interview.',
      totalQuestions: 320,

    ),
    const Track(
      id: 'backend',
      name: 'Backend',
      description: 'Master the core concepts and be ready for any backend interview.',
      totalQuestions: 410,

    ),
    const Track(
      id: 'devops',
      name: 'DevOps',
      description: 'Master the tools and mindset to ship software faster and smarter.',
      totalQuestions: 140,
          ),
    const Track(
      id: 'Flutter',
      name: 'Flutter',
      description: 'Learn how to built mobile app .',
      totalQuestions: 140,

    ),
  ];

  static final List<Topic> topics = [
    // Backend
    Topic(
      name: 'REST API',
      questions: [],
    ),
    Topic(
      name: 'Databases (SQL)',
      questions: [],
    ),
    Topic(
      name: 'System Design',
      questions: [],
    ),
    Topic(
      name: 'Authentication',
      questions: [],
    ),
    Topic(
      name: 'Docker',
      questions: [],
    ),
    Topic(
      name: 'Linux & Networking',
      questions: [],
    ),

    // Database
    Topic(
      name: 'SQL Basics',
      questions: [],
    ),
    Topic(
      name: 'Normalization',
      questions: [],
    ),
    Topic(
      name: 'Joins & Set Operations',
      questions: [],
    ),
    Topic(
      name: 'Indexes',
      questions: [],
    ),
    Topic(
      name: 'Transactions',
      questions: [],
    ),

    // DevOps
    Topic(
      name: 'Git & GitHub',
      questions: [],
    ),
    Topic(
      name: 'CI / CD',
      questions: [],
    ),
    Topic(
      name: 'Docker',
      questions: [],
    ),
    Topic(
      name: 'Kubernetes',
      questions: [],
    ),
    Topic(
      name: 'Infrastructure as Code',
      questions: [],
    ),

    // System Design
    Topic(
      name: 'Basics',
      questions: [],
    ),
    Topic(
      name: 'Scalability',
      questions: [],
    ),
    Topic(
      name: 'Load Balancing',
      questions: [],
    ),
    Topic(
      name: 'Caching',
      questions: [],
    ),
    Topic(
      name: 'Databases in Depth',
      questions: [],
    ),
  ];
  /// The topic shown on Home under "Continue Learning".

  static final List<Flashcard> flashcards = [
    const Flashcard(
      id: 'card_1',
      topicId: 'rest_api',
      question: 'What is REST and what are its main principles?',
      answer: 'REST (Representational State Transfer) is an architectural '
          'style for designing networked applications. Its main principles:\n'
          '• Client-Server\n• Stateless\n• Cacheable\n• Layered System\n'
          '• Uniform Interface\n• Code on Demand (optional)',
      isStudied: true,
    ),
    const Flashcard(
      id: 'card_2',
      topicId: 'rest_api',
      question: 'What HTTP methods are commonly used in REST APIs, and what does each one do?',
      answer: 'GET reads a resource, POST creates one, PUT replaces an '
          'existing resource, PATCH partially updates it, and DELETE '
          'removes it. GET/PUT/DELETE are idempotent; POST is not.',
    ),
    const Flashcard(
      id: 'card_3',
      topicId: 'rest_api',
      question: 'What does "statelessness" mean in REST, and why does it matter?',
      answer: 'Each request from the client must contain all the '
          'information the server needs to process it — the server keeps '
          'no client session between requests. It matters because it makes '
          'the API easier to scale horizontally and simpler to cache.',
    ),
    const Flashcard(
      id: 'card_4',
      topicId: 'rest_api',
      question: 'What is the difference between PUT and PATCH?',
      answer: 'PUT replaces the entire resource with the payload sent — '
          'any field left out is treated as removed. PATCH applies a '
          'partial update, changing only the fields included in the request.',
    ),
    const Flashcard(
      id: 'card_5',
      topicId: 'rest_api',
      question: 'What is HATEOAS in the context of REST APIs?',
      answer: 'Hypermedia As The Engine Of Application State: responses '
          'include links to related actions/resources, so clients can '
          'navigate the API dynamically instead of hardcoding URLs.',
    ),
  ];
}
