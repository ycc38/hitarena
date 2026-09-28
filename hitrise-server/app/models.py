from __future__ import annotations

from pydantic import BaseModel, Field


class ActivateRequest(BaseModel):
    serial: str = Field(min_length=1, max_length=64)
    code: str = Field(min_length=1, max_length=64)
    install_id: str = Field(min_length=1, max_length=128)
    device_hash: str = Field(min_length=1, max_length=128)
    app_version: str | None = Field(default=None, max_length=64)


class CheckRequest(BaseModel):
    serial: str = Field(min_length=1, max_length=64)
    activation_token: str = Field(min_length=1, max_length=128)
    install_id: str = Field(min_length=1, max_length=128)
    device_hash: str = Field(min_length=1, max_length=128)
    app_version: str | None = Field(default=None, max_length=64)


class DeviceReactivationRequest(BaseModel):
    install_id: str = Field(min_length=1, max_length=128)
    device_hash: str = Field(min_length=1, max_length=128)
    app_version: str | None = Field(default=None, max_length=64)


class ResetRequest(BaseModel):
    serial: str = Field(min_length=1, max_length=64)
    note: str | None = Field(default=None, max_length=255)


class AuthenticatedRequest(BaseModel):
    serial: str = Field(min_length=1, max_length=64)
    activation_token: str = Field(min_length=1, max_length=128)
    install_id: str = Field(min_length=1, max_length=128)
    device_hash: str = Field(min_length=1, max_length=128)
    app_version: str | None = Field(default=None, max_length=64)


class UserBootstrapRequest(AuthenticatedRequest):
    language_code: str | None = Field(default=None, max_length=8)


class UserProfileUpdateRequest(AuthenticatedRequest):
    nickname: str | None = Field(default=None, min_length=1, max_length=64)
    language_code: str | None = Field(default=None, max_length=8)
    country_code: str | None = Field(default=None, max_length=8)
    avatar_color: str | None = Field(default=None, max_length=16)


class UserStatisticsRequest(AuthenticatedRequest):
    pass


class TrainingHistoryRequest(AuthenticatedRequest):
    limit: int = Field(default=10, ge=1, le=50)


class TrainingSessionCreateRequest(AuthenticatedRequest):
    mode_seconds: int = Field(ge=1, le=600)
    duration_seconds: int | None = Field(default=None, ge=0, le=100000)
    total_hits: int = Field(ge=0, le=10000)
    average_frequency: float = Field(ge=0.0, le=1000.0)
    best_burst_count: int = Field(ge=0, le=10000)
    best_burst_start_sec: float = Field(ge=0.0, le=600.0)
    calories_burned: float | None = Field(default=None, ge=0.0, le=100000.0)
    fat_burned_grams: float | None = Field(default=None, ge=0.0, le=100000.0)
    avg_bpm: float | None = Field(default=None, ge=0.0, le=1000.0)
    peak_force_n: float | None = Field(default=None, ge=0.0, le=10000.0)
    avg_force_n: float | None = Field(default=None, ge=0.0, le=10000.0)
    rhythm_accuracy: float | None = Field(default=None, ge=0.0, le=1.0)
    combo_summary_json: str | None = Field(default=None, max_length=2048)
    beat_score_counts_json: str | None = Field(default=None, max_length=1024)
    round_config_json: str | None = Field(default=None, max_length=2048)
    round_reports_json: str | None = Field(default=None, max_length=20000)
    play_mode: str | None = Field(default=None, max_length=32)
    sound_pack_id: str | None = Field(default=None, max_length=64)
    started_at_epoch_ms: int | None = Field(default=None, ge=0)
    ended_at_epoch_ms: int | None = Field(default=None, ge=0)


class LeaderboardRequest(AuthenticatedRequest):
    board_key: str | None = Field(default=None, max_length=64)
    mode_seconds: int | None = Field(default=None, ge=1, le=600)
    window: str = Field(default="all", min_length=1, max_length=16)
    limit: int = Field(default=20, ge=1, le=100)


class ArenaDevicePayload(BaseModel):
    target_index: int = Field(ge=0, le=4)
    bluetooth_name: str = Field(min_length=1, max_length=128)
    address_hash: str = Field(min_length=16, max_length=128)
    transport: str | None = Field(default=None, max_length=16)


class ArenaPlayerPayload(BaseModel):
    target_index: int = Field(ge=0, le=4)
    player_name: str = Field(min_length=1, max_length=64)
    raw_hits: int = Field(ge=0, le=10000)
    valid_hits: int = Field(ge=0, le=10000)
    invalid_hits: int = Field(ge=0, le=10000)
    peak_force: float = Field(ge=0.0, le=10000.0)
    average_force: float = Field(ge=0.0, le=10000.0)
    speed_score: float = Field(ge=0.0, le=100.01)
    power_score: float = Field(ge=0.0, le=10000.0)
    score: float = Field(ge=0.0, le=10000.0)
    rank: int = Field(ge=1, le=5)
    required_punches: int = Field(default=0, ge=0, le=10000)
    completed_punches: int = Field(default=0, ge=0, le=10000)
    scoring_punch_count: int = Field(default=0, ge=0, le=1000)
    quota_average_force: float = Field(default=0.0, ge=0.0, le=10000.0)
    force_samples: list[float] = Field(default_factory=list, max_length=10000)
    elapsed_times_ms: list[int] = Field(default_factory=list, max_length=10000)
    awards: list[str] = Field(default_factory=list, max_length=20)


class ArenaMatchUploadRequest(AuthenticatedRequest):
    match_id: str = Field(min_length=8, max_length=64)
    rules_version: int = Field(ge=2, le=100)
    scoring_mode: str = Field(pattern="^(Hits|Power|Composite)$")
    duration_seconds: int = Field(ge=1, le=100000)
    rounds: int = Field(ge=1, le=100)
    work_seconds_per_round: int = Field(ge=1, le=3600)
    rest_seconds: int = Field(default=0, ge=0, le=3600)
    force_threshold: float = Field(ge=0.0, le=10000.0)
    power_punches_per_30_seconds: int = Field(ge=1, le=100)
    power_best_punch_count: int = Field(ge=1, le=1000)
    speed_weight: int = Field(ge=0, le=100)
    power_weight: int = Field(ge=0, le=100)
    ended_at_epoch_ms: int = Field(ge=0)
    devices: list[ArenaDevicePayload] = Field(min_length=1, max_length=5)
    players: list[ArenaPlayerPayload] = Field(min_length=1, max_length=5)


class ArenaLeaderboardRequest(AuthenticatedRequest):
    board_key: str = Field(default="overall", pattern="^(overall|hits|power|composite)$")
    limit: int = Field(default=50, ge=1, le=100)


class ArenaDeviceCertificationRequest(AuthenticatedRequest):
    bluetooth_names: list[str] = Field(min_length=1, max_length=20)


class AdminCertifiedDeviceRequest(BaseModel):
    bluetooth_name: str = Field(min_length=1, max_length=128)
    manufacturer: str = Field(default="HitArena", min_length=1, max_length=128)
    sensor_model: str = Field(default="SENBALL", min_length=1, max_length=128)
    active: bool = True
    note: str | None = Field(default=None, max_length=255)
