CREATE DATABASE IF NOT EXISTS hitarena
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE hitarena;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.TABLE_CONSTRAINTS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'training_sessions'
      AND CONSTRAINT_NAME = 'fk_training_sessions_license_serial'
  ),
  'ALTER TABLE training_sessions DROP FOREIGN KEY fk_training_sessions_license_serial',
  'SELECT 1'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.TABLE_CONSTRAINTS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'app_users'
      AND CONSTRAINT_NAME = 'fk_app_users_license_serial'
  ),
  'ALTER TABLE app_users DROP FOREIGN KEY fk_app_users_license_serial',
  'SELECT 1'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

DROP TABLE IF EXISTS activation_logs;
DROP TABLE IF EXISTS activations;
DROP TABLE IF EXISTS licenses;

CREATE TABLE IF NOT EXISTS app_users (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  serial CHAR(11) NOT NULL,
  nickname VARCHAR(64) NOT NULL,
  language_code VARCHAR(8) NOT NULL DEFAULT 'zh',
  country_code VARCHAR(8) DEFAULT NULL,
  avatar_color VARCHAR(16) NOT NULL DEFAULT '#145DA0',
  total_sessions_cached INT UNSIGNED NOT NULL DEFAULT 0,
  total_hits_cached INT UNSIGNED NOT NULL DEFAULT 0,
  total_calories_cached DECIMAL(12, 3) NOT NULL DEFAULT 0,
  total_fat_burned_grams_cached DECIMAL(12, 3) NOT NULL DEFAULT 0,
  best_score_cached INT UNSIGNED NOT NULL DEFAULT 0,
  best_30_hits_cached INT UNSIGNED NOT NULL DEFAULT 0,
  best_60_hits_cached INT UNSIGNED NOT NULL DEFAULT 0,
  best_burst_cached INT UNSIGNED NOT NULL DEFAULT 0,
  longest_streak_cached INT UNSIGNED NOT NULL DEFAULT 0,
  active_days_cached INT UNSIGNED NOT NULL DEFAULT 0,
  current_tier TINYINT UNSIGNED NOT NULL DEFAULT 1,
  highest_tier TINYINT UNSIGNED NOT NULL DEFAULT 1,
  tier_updated_at DATETIME DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_seen_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_app_users_serial (serial),
  KEY idx_app_users_nickname (nickname)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'app_users' AND COLUMN_NAME = 'total_sessions_cached'
  ),
  'SELECT 1',
  'ALTER TABLE app_users ADD COLUMN total_sessions_cached INT UNSIGNED NOT NULL DEFAULT 0'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'app_users' AND COLUMN_NAME = 'total_hits_cached'
  ),
  'SELECT 1',
  'ALTER TABLE app_users ADD COLUMN total_hits_cached INT UNSIGNED NOT NULL DEFAULT 0'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'app_users' AND COLUMN_NAME = 'total_calories_cached'
  ),
  'SELECT 1',
  'ALTER TABLE app_users ADD COLUMN total_calories_cached DECIMAL(12, 3) NOT NULL DEFAULT 0'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'app_users' AND COLUMN_NAME = 'total_fat_burned_grams_cached'
  ),
  'SELECT 1',
  'ALTER TABLE app_users ADD COLUMN total_fat_burned_grams_cached DECIMAL(12, 3) NOT NULL DEFAULT 0'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'app_users' AND COLUMN_NAME = 'best_score_cached'
  ),
  'SELECT 1',
  'ALTER TABLE app_users ADD COLUMN best_score_cached INT UNSIGNED NOT NULL DEFAULT 0'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'app_users' AND COLUMN_NAME = 'best_30_hits_cached'
  ),
  'SELECT 1',
  'ALTER TABLE app_users ADD COLUMN best_30_hits_cached INT UNSIGNED NOT NULL DEFAULT 0'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'app_users' AND COLUMN_NAME = 'best_60_hits_cached'
  ),
  'SELECT 1',
  'ALTER TABLE app_users ADD COLUMN best_60_hits_cached INT UNSIGNED NOT NULL DEFAULT 0'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'app_users' AND COLUMN_NAME = 'best_burst_cached'
  ),
  'SELECT 1',
  'ALTER TABLE app_users ADD COLUMN best_burst_cached INT UNSIGNED NOT NULL DEFAULT 0'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'app_users' AND COLUMN_NAME = 'longest_streak_cached'
  ),
  'SELECT 1',
  'ALTER TABLE app_users ADD COLUMN longest_streak_cached INT UNSIGNED NOT NULL DEFAULT 0'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'app_users' AND COLUMN_NAME = 'active_days_cached'
  ),
  'SELECT 1',
  'ALTER TABLE app_users ADD COLUMN active_days_cached INT UNSIGNED NOT NULL DEFAULT 0'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'app_users' AND COLUMN_NAME = 'current_tier'
  ),
  'SELECT 1',
  'ALTER TABLE app_users ADD COLUMN current_tier TINYINT UNSIGNED NOT NULL DEFAULT 1'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'app_users' AND COLUMN_NAME = 'highest_tier'
  ),
  'SELECT 1',
  'ALTER TABLE app_users ADD COLUMN highest_tier TINYINT UNSIGNED NOT NULL DEFAULT 1'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'app_users' AND COLUMN_NAME = 'tier_updated_at'
  ),
  'SELECT 1',
  'ALTER TABLE app_users ADD COLUMN tier_updated_at DATETIME DEFAULT NULL'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

CREATE TABLE IF NOT EXISTS user_achievements (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  achievement_key VARCHAR(64) NOT NULL,
  unlocked_at DATETIME DEFAULT NULL,
  progress_value INT UNSIGNED NOT NULL DEFAULT 0,
  goal_value INT UNSIGNED NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_user_achievement (user_id, achievement_key),
  KEY idx_user_achievements_user (user_id, unlocked_at),
  CONSTRAINT fk_user_achievements_user
    FOREIGN KEY (user_id) REFERENCES app_users(id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS training_sessions (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  serial CHAR(11) NOT NULL,
  mode_seconds SMALLINT UNSIGNED NOT NULL,
  duration_seconds INT UNSIGNED NOT NULL DEFAULT 0,
  total_hits INT UNSIGNED NOT NULL,
  average_frequency DECIMAL(8, 3) NOT NULL,
  best_burst_count INT UNSIGNED NOT NULL DEFAULT 0,
  best_burst_start_sec DECIMAL(8, 3) NOT NULL DEFAULT 0,
  calories_burned DECIMAL(10, 3) NOT NULL DEFAULT 0,
  fat_burned_grams DECIMAL(10, 3) NOT NULL DEFAULT 0,
  avg_bpm DECIMAL(8, 3) NOT NULL DEFAULT 0,
  peak_force_n DECIMAL(10, 3) NOT NULL DEFAULT 0,
  avg_force_n DECIMAL(10, 3) NOT NULL DEFAULT 0,
  rhythm_accuracy DECIMAL(6, 4) NOT NULL DEFAULT 0,
  combo_summary_json TEXT DEFAULT NULL,
  beat_score_counts_json TEXT DEFAULT NULL,
  round_config_json TEXT DEFAULT NULL,
  play_mode VARCHAR(32) DEFAULT NULL,
  sound_pack_id VARCHAR(64) DEFAULT NULL,
  started_at DATETIME DEFAULT NULL,
  ended_at DATETIME NOT NULL,
  device_hash VARCHAR(128) DEFAULT NULL,
  app_version VARCHAR(64) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_training_user_time (user_id, ended_at DESC),
  KEY idx_training_mode_time (mode_seconds, ended_at DESC),
  KEY idx_training_mode_hits (mode_seconds, total_hits DESC, ended_at DESC),
  CONSTRAINT fk_training_sessions_user
    FOREIGN KEY (user_id) REFERENCES app_users(id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS training_session_rounds (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  session_id BIGINT UNSIGNED NOT NULL,
  user_id BIGINT UNSIGNED NOT NULL,
  round_index SMALLINT UNSIGNED NOT NULL,
  total_rounds SMALLINT UNSIGNED NOT NULL DEFAULT 1,
  round_duration_seconds INT UNSIGNED NOT NULL DEFAULT 0,
  cumulative_duration_seconds INT UNSIGNED NOT NULL DEFAULT 0,
  round_hits INT UNSIGNED NOT NULL DEFAULT 0,
  cumulative_hits INT UNSIGNED NOT NULL DEFAULT 0,
  round_calories_burned DECIMAL(10, 3) NOT NULL DEFAULT 0,
  cumulative_calories_burned DECIMAL(10, 3) NOT NULL DEFAULT 0,
  round_fat_burned_grams DECIMAL(10, 3) NOT NULL DEFAULT 0,
  cumulative_fat_burned_grams DECIMAL(10, 3) NOT NULL DEFAULT 0,
  peak_force_n DECIMAL(10, 3) NOT NULL DEFAULT 0,
  avg_force_n DECIMAL(10, 3) NOT NULL DEFAULT 0,
  avg_bpm DECIMAL(8, 3) NOT NULL DEFAULT 0,
  rhythm_accuracy DECIMAL(6, 4) NOT NULL DEFAULT 0,
  ended_at DATETIME DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_session_round (session_id, round_index),
  KEY idx_rounds_user_round (user_id, round_index),
  KEY idx_rounds_user_time (user_id, ended_at),
  CONSTRAINT fk_training_rounds_session
    FOREIGN KEY (session_id) REFERENCES training_sessions(id)
    ON DELETE CASCADE,
  CONSTRAINT fk_training_rounds_user
    FOREIGN KEY (user_id) REFERENCES app_users(id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS arena_certified_devices (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  bluetooth_name VARCHAR(128) NOT NULL,
  normalized_name VARCHAR(128) NOT NULL,
  manufacturer VARCHAR(128) NOT NULL DEFAULT 'HitArena',
  sensor_model VARCHAR(128) NOT NULL DEFAULT 'SENBALL',
  active TINYINT(1) NOT NULL DEFAULT 1,
  note VARCHAR(255) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_arena_certified_device_name (normalized_name),
  KEY idx_arena_certified_device_active (active, normalized_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS arena_matches (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  match_uuid VARCHAR(64) NOT NULL,
  uploader_user_id BIGINT UNSIGNED NOT NULL,
  serial CHAR(11) NOT NULL,
  rules_version SMALLINT UNSIGNED NOT NULL,
  scoring_mode VARCHAR(16) NOT NULL,
  duration_seconds INT UNSIGNED NOT NULL,
  rounds SMALLINT UNSIGNED NOT NULL,
  work_seconds_per_round INT UNSIGNED NOT NULL,
  rest_seconds INT UNSIGNED NOT NULL DEFAULT 0,
  force_threshold DECIMAL(10,3) NOT NULL DEFAULT 0,
  power_punches_per_30_seconds SMALLINT UNSIGNED NOT NULL DEFAULT 10,
  power_best_punch_count SMALLINT UNSIGNED NOT NULL DEFAULT 5,
  speed_weight TINYINT UNSIGNED NOT NULL DEFAULT 60,
  power_weight TINYINT UNSIGNED NOT NULL DEFAULT 40,
  certified TINYINT(1) NOT NULL DEFAULT 0,
  certification_reason VARCHAR(255) DEFAULT NULL,
  complete_payload_json MEDIUMTEXT NOT NULL,
  ended_at DATETIME NOT NULL,
  device_hash VARCHAR(128) DEFAULT NULL,
  app_version VARCHAR(64) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_arena_match_uuid (match_uuid),
  KEY idx_arena_match_certified_time (certified, ended_at DESC),
  KEY idx_arena_match_mode_time (scoring_mode, ended_at DESC),
  CONSTRAINT fk_arena_matches_user FOREIGN KEY (uploader_user_id) REFERENCES app_users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS arena_match_devices (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  match_id BIGINT UNSIGNED NOT NULL,
  target_index TINYINT UNSIGNED NOT NULL,
  bluetooth_name VARCHAR(128) NOT NULL,
  address_hash VARCHAR(128) NOT NULL,
  transport VARCHAR(16) DEFAULT NULL,
  certified TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY uk_arena_match_target_device (match_id, target_index),
  KEY idx_arena_device_name (bluetooth_name),
  CONSTRAINT fk_arena_devices_match FOREIGN KEY (match_id) REFERENCES arena_matches(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS arena_match_players (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  match_id BIGINT UNSIGNED NOT NULL,
  target_index TINYINT UNSIGNED NOT NULL,
  player_name VARCHAR(64) NOT NULL,
  raw_hits INT UNSIGNED NOT NULL DEFAULT 0,
  valid_hits INT UNSIGNED NOT NULL DEFAULT 0,
  invalid_hits INT UNSIGNED NOT NULL DEFAULT 0,
  peak_force DECIMAL(10,3) NOT NULL DEFAULT 0,
  average_force DECIMAL(10,3) NOT NULL DEFAULT 0,
  speed_score DECIMAL(8,3) NOT NULL DEFAULT 0,
  power_score DECIMAL(10,3) NOT NULL DEFAULT 0,
  final_score DECIMAL(10,3) NOT NULL DEFAULT 0,
  player_rank TINYINT UNSIGNED NOT NULL,
  match_points TINYINT UNSIGNED NOT NULL DEFAULT 0,
  required_punches INT UNSIGNED NOT NULL DEFAULT 0,
  completed_punches INT UNSIGNED NOT NULL DEFAULT 0,
  scoring_punch_count SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  quota_average_force DECIMAL(10,3) NOT NULL DEFAULT 0,
  complete_player_json MEDIUMTEXT NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uk_arena_match_target_player (match_id, target_index),
  KEY idx_arena_player_overall (player_name, match_points, player_rank),
  KEY idx_arena_player_hits (valid_hits DESC),
  KEY idx_arena_player_score (final_score DESC),
  CONSTRAINT fk_arena_players_match FOREIGN KEY (match_id) REFERENCES arena_matches(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'arena_matches' AND COLUMN_NAME = 'trust_state'),
  'SELECT 1',
  'ALTER TABLE arena_matches ADD COLUMN trust_state VARCHAR(24) NOT NULL DEFAULT ''pending'' AFTER certified, ADD COLUMN scoring_engine_version SMALLINT UNSIGNED NOT NULL DEFAULT 2 AFTER rules_version, ADD COLUMN verified_at DATETIME DEFAULT NULL AFTER certification_reason, ADD COLUMN uploaded_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER verified_at'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'arena_match_devices' AND COLUMN_NAME = 'certified_device_id'),
  'SELECT 1',
  'ALTER TABLE arena_match_devices ADD COLUMN certified_device_id BIGINT UNSIGNED DEFAULT NULL AFTER match_id, ADD COLUMN manufacturer_snapshot VARCHAR(128) DEFAULT NULL AFTER certified, ADD COLUMN sensor_model_snapshot VARCHAR(128) DEFAULT NULL AFTER manufacturer_snapshot, ADD KEY idx_arena_device_registry (certified_device_id), ADD CONSTRAINT fk_arena_match_device_registry FOREIGN KEY (certified_device_id) REFERENCES arena_certified_devices(id) ON DELETE SET NULL'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

CREATE TABLE IF NOT EXISTS arena_punch_events (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  match_id BIGINT UNSIGNED NOT NULL,
  player_result_id BIGINT UNSIGNED NOT NULL,
  target_index TINYINT UNSIGNED NOT NULL,
  punch_sequence INT UNSIGNED NOT NULL,
  round_index SMALLINT UNSIGNED NOT NULL,
  elapsed_ms BIGINT UNSIGNED NOT NULL,
  round_elapsed_ms INT UNSIGNED NOT NULL,
  force_value DECIMAL(10,3) NOT NULL,
  is_valid_hit TINYINT(1) NOT NULL DEFAULT 0,
  is_within_power_quota TINYINT(1) NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_arena_punch_sequence (match_id, target_index, punch_sequence),
  KEY idx_arena_punch_match_player (match_id, player_result_id),
  KEY idx_arena_punch_round (match_id, round_index, target_index),
  KEY idx_arena_punch_valid_force (is_valid_hit, force_value DESC),
  CONSTRAINT fk_arena_punch_match FOREIGN KEY (match_id) REFERENCES arena_matches(id) ON DELETE CASCADE,
  CONSTRAINT fk_arena_punch_player FOREIGN KEY (player_result_id) REFERENCES arena_match_players(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS arena_round_player_stats (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  match_id BIGINT UNSIGNED NOT NULL,
  player_result_id BIGINT UNSIGNED NOT NULL,
  target_index TINYINT UNSIGNED NOT NULL,
  round_index SMALLINT UNSIGNED NOT NULL,
  raw_hits INT UNSIGNED NOT NULL DEFAULT 0,
  valid_hits INT UNSIGNED NOT NULL DEFAULT 0,
  invalid_hits INT UNSIGNED NOT NULL DEFAULT 0,
  peak_force DECIMAL(10,3) NOT NULL DEFAULT 0,
  average_force DECIMAL(10,3) NOT NULL DEFAULT 0,
  first_punch_elapsed_ms BIGINT UNSIGNED DEFAULT NULL,
  last_punch_elapsed_ms BIGINT UNSIGNED DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_arena_round_player (match_id, target_index, round_index),
  KEY idx_arena_round_match (match_id, round_index),
  CONSTRAINT fk_arena_round_match FOREIGN KEY (match_id) REFERENCES arena_matches(id) ON DELETE CASCADE,
  CONSTRAINT fk_arena_round_player FOREIGN KEY (player_result_id) REFERENCES arena_match_players(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'training_sessions' AND COLUMN_NAME = 'duration_seconds'),
  'SELECT 1',
  'ALTER TABLE training_sessions ADD COLUMN duration_seconds INT UNSIGNED NOT NULL DEFAULT 0 AFTER mode_seconds'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

UPDATE training_sessions
SET duration_seconds = mode_seconds
WHERE duration_seconds = 0;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'training_sessions' AND COLUMN_NAME = 'calories_burned'),
  'SELECT 1',
  'ALTER TABLE training_sessions ADD COLUMN calories_burned DECIMAL(10, 3) NOT NULL DEFAULT 0 AFTER best_burst_start_sec'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'training_sessions' AND COLUMN_NAME = 'fat_burned_grams'),
  'SELECT 1',
  'ALTER TABLE training_sessions ADD COLUMN fat_burned_grams DECIMAL(10, 3) NOT NULL DEFAULT 0 AFTER calories_burned'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'training_sessions' AND COLUMN_NAME = 'avg_bpm'),
  'SELECT 1',
  'ALTER TABLE training_sessions ADD COLUMN avg_bpm DECIMAL(8, 3) NOT NULL DEFAULT 0 AFTER fat_burned_grams'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'training_sessions' AND COLUMN_NAME = 'peak_force_n'),
  'SELECT 1',
  'ALTER TABLE training_sessions ADD COLUMN peak_force_n DECIMAL(10, 3) NOT NULL DEFAULT 0 AFTER avg_bpm'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'training_sessions' AND COLUMN_NAME = 'rhythm_accuracy'),
  'SELECT 1',
  'ALTER TABLE training_sessions ADD COLUMN rhythm_accuracy DECIMAL(6, 4) NOT NULL DEFAULT 0 AFTER peak_force_n'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'training_sessions' AND COLUMN_NAME = 'avg_force_n'),
  'SELECT 1',
  'ALTER TABLE training_sessions ADD COLUMN avg_force_n DECIMAL(10, 3) NOT NULL DEFAULT 0 AFTER peak_force_n'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'training_sessions' AND COLUMN_NAME = 'combo_summary_json'),
  'SELECT 1',
  'ALTER TABLE training_sessions ADD COLUMN combo_summary_json TEXT DEFAULT NULL AFTER rhythm_accuracy'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'training_sessions' AND COLUMN_NAME = 'beat_score_counts_json'),
  'SELECT 1',
  'ALTER TABLE training_sessions ADD COLUMN beat_score_counts_json TEXT DEFAULT NULL AFTER combo_summary_json'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'training_sessions' AND COLUMN_NAME = 'round_config_json'),
  'SELECT 1',
  'ALTER TABLE training_sessions ADD COLUMN round_config_json TEXT DEFAULT NULL AFTER beat_score_counts_json'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'training_sessions' AND COLUMN_NAME = 'play_mode'),
  'SELECT 1',
  'ALTER TABLE training_sessions ADD COLUMN play_mode VARCHAR(32) DEFAULT NULL AFTER round_config_json'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = IF(
  EXISTS(SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'training_sessions' AND COLUMN_NAME = 'sound_pack_id'),
  'SELECT 1',
  'ALTER TABLE training_sessions ADD COLUMN sound_pack_id VARCHAR(64) DEFAULT NULL AFTER play_mode'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;
