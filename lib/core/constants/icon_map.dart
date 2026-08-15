import 'package:flutter/material.dart';

/// Maps a topic/track `iconKey` string to a Flutter [IconData], so icons
/// stay data-driven instead of hardcoded per screen.
IconData iconForKey(String key) {
  switch (key.toLowerCase()) {
    case 'frontend':
      return Icons.code_rounded;
    case 'backend':
      return Icons.dns_rounded;
    case 'rest_api':
      return Icons.http_rounded;
    case 'database':
    case 'sql':
    case 'sql_basics':
      return Icons.storage_rounded;
    case 'normalization':
      return Icons.view_column_rounded;
    case 'joins':
      return Icons.join_full_rounded;
    case 'indexes':
      return Icons.list_alt_rounded;
    case 'transactions':
      return Icons.sync_alt_rounded;
    case 'system_design':
      return Icons.hub_rounded;
    case 'authentication':
      return Icons.lock_rounded;
    case 'docker':
      return Icons.developer_board_rounded;
    case 'kubernetes':
      return Icons.settings_suggest_rounded;
    case 'linux':
      return Icons.terminal_rounded;
    case 'devops':
      return Icons.all_inclusive_rounded;
    case 'git':
      return Icons.merge_type_rounded;
    case 'ci_cd':
      return Icons.loop_rounded;
    case 'iac':
      return Icons.integration_instructions_rounded;
    case 'scalability':
      return Icons.trending_up_rounded;
    case 'caching':
      return Icons.cached_rounded;
    case 'load_balancing':
      return Icons.balance_rounded;
    case 'basics':
      return Icons.hub_rounded;
    case 'databases_in_depth':
      return Icons.storage_rounded;
    default:
      return Icons.school_rounded;
  }
}
