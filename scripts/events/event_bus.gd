extends Node

@warning_ignore("unused_signal")
signal experience_gained(event: ExperienceGainEvent);

@warning_ignore("unused_signal")
signal post_experience_gained(event: PostExperienceGainEvent);

## Event emitted on level up, connect anything that wants to modify level up
## event details, such as power ups that are available, etc.
@warning_ignore("unused_signal")
signal level_up(event: LevelUpEvent);

## Use this for UI related stuff, this is the second phase of the level up event
## never write anything into the event at this phase, this is for anything
## that responds to the finialize details of the level up
@warning_ignore("unused_signal")
signal level_up_tail(event: LevelUpEvent);

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
