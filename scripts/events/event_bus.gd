extends Node

@warning_ignore("unused_signal")
signal experience_gained(event: ExperienceGainEvent);

@warning_ignore("unused_signal")
signal post_experience_gained(event: PostExperienceGainEvent);

## Event emitted on level up, connect anything that wants to modify level up
## event details, such as power ups that are available, etc.
@warning_ignore("unused_signal")
signal level_up(event: LevelUpEvent);

@warning_ignore("unused_signal")
signal level_ups_generated(event: PowerUpsGeneratedEvent);

@warning_ignore("unused_signal")
signal enemy_dead(event: EntityDeathEvent);

@warning_ignore("unused_signal")
signal minion_dealt_damage(event: EntityDealDamageEvent);

@warning_ignore("unused_signal")
signal enemy_dealt_damage(event: EntityDealDamageEvent);

@warning_ignore("unused_signal")
signal minion_spawn(event: EntitySpawnEvent);

@warning_ignore("unused_signal")
signal powerup_selected(event: PowerUpSelectedEvent);

@warning_ignore("unused_signal")
signal powerup_removed(event: PowerUpRemovedEvent);

@warning_ignore("unused_signal")
signal player_dead(event: EntityDeathEvent);

@warning_ignore("unused_signal")
signal trade_upgrades(type: String);
