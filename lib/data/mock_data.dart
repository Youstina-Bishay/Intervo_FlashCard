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
      image: AppAssets.front,
      color: AppColors.frontend
    ),
    const Track(
      id: 'backend',
      name: 'Backend',
      description: 'Master the core concepts and be ready for any backend interview.',
      totalQuestions: 410,
        image: AppAssets.back,
        color: AppColors.backend
    ),
    const Track(
      id: 'devops',
      name: 'DevOps',
      description: 'Master the tools and mindset to ship software faster and smarter.',
      totalQuestions: 140,
        image: AppAssets.devops,
        color: AppColors.devops    ),
    const Track(
      id: 'Flutter',
      name: 'Flutter',
      description: 'Learn how to built mobile app .',
      totalQuestions: 140,
        image: AppAssets.flutter,
        color: AppColors.flutter
    ),
  ];

  static final List<Topic> topics = [
    // Backend
    const Topic(id: 'rest_api', trackId: 'backend', name: 'REST API', iconKey: 'rest_api', totalCards: 30, studiedCards: 18),
    const Topic(id: 'databases_sql', trackId: 'backend', name: 'Databases (SQL)', iconKey: 'sql', totalCards: 40, studiedCards: 18),
    const Topic(id: 'system_design_topic', trackId: 'backend', name: 'System Design', iconKey: 'system_design', totalCards: 50, studiedCards: 10),
    const Topic(id: 'authentication', trackId: 'backend', name: 'Authentication', iconKey: 'authentication', totalCards: 25, studiedCards: 0),
    const Topic(id: 'docker_backend', trackId: 'backend', name: 'Docker', iconKey: 'docker', totalCards: 20, studiedCards: 0),
    const Topic(id: 'linux_networking', trackId: 'backend', name: 'Linux & Networking', iconKey: 'linux', totalCards: 25, studiedCards: 0),

    // Database
    const Topic(id: 'sql_basics', trackId: 'database', name: 'SQL Basics', iconKey: 'sql_basics', totalCards: 30, studiedCards: 18),
    const Topic(id: 'normalization', trackId: 'database', name: 'Normalization', iconKey: 'normalization', totalCards: 25, studiedCards: 11),
    const Topic(id: 'joins', trackId: 'database', name: 'Joins & Set Operations', iconKey: 'joins', totalCards: 35, studiedCards: 11),
    const Topic(id: 'indexes', trackId: 'database', name: 'Indexes', iconKey: 'indexes', totalCards: 20, studiedCards: 4),
    const Topic(id: 'transactions', trackId: 'database', name: 'Transactions', iconKey: 'transactions', totalCards: 25, studiedCards: 0),

    // DevOps
    const Topic(id: 'git_github', trackId: 'devops', name: 'Git & GitHub', iconKey: 'git', totalCards: 30, studiedCards: 18),
    const Topic(id: 'ci_cd', trackId: 'devops', name: 'CI / CD', iconKey: 'ci_cd', totalCards: 30, studiedCards: 15),
    const Topic(id: 'docker_devops', trackId: 'devops', name: 'Docker', iconKey: 'docker', totalCards: 25, studiedCards: 10),
    const Topic(id: 'kubernetes', trackId: 'devops', name: 'Kubernetes', iconKey: 'kubernetes', totalCards: 30, studiedCards: 6),
    const Topic(id: 'iac', trackId: 'devops', name: 'Infrastructure as Code', iconKey: 'iac', totalCards: 25, studiedCards: 0),

    // System Design
    const Topic(id: 'sd_basics', trackId: 'system_design', name: 'Basics', iconKey: 'basics', totalCards: 35, studiedCards: 21),
    const Topic(id: 'scalability', trackId: 'system_design', name: 'Scalability', iconKey: 'scalability', totalCards: 30, studiedCards: 15),
    const Topic(id: 'load_balancing', trackId: 'system_design', name: 'Load Balancing', iconKey: 'load_balancing', totalCards: 20, studiedCards: 8),
    const Topic(id: 'caching', trackId: 'system_design', name: 'Caching', iconKey: 'caching', totalCards: 25, studiedCards: 5),
    const Topic(id: 'databases_in_depth', trackId: 'system_design', name: 'Databases in Depth', iconKey: 'databases_in_depth', totalCards: 30, studiedCards: 0),
  ];

  /// The topic shown on Home under "Continue Learning".
  static Topic get continueLearningTopic =>
      topics.firstWhere((t) => t.id == 'rest_api');

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
