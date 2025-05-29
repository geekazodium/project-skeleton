extends Node

var _minions: Node2D = null;
var _players: Node2D = null;
var _projectiles: Node2D = null;

func get_minions() -> Array[Node]:
	return self._minions.get_children();

func set_minions_ref(minions: Node2D) -> void:
	self._minions = minions;

func get_players() -> Array[Node]:
	return self._players.get_children();

func set_players_ref(players: Node2D) -> void:
	self._players = players;

func get_projectiles() -> Array[Node]:
	return self._projectiles.get_children();

func add_projectile(projectile: Node2D) -> void:
	self._projectiles.add_child(projectile);

func set_projectiles_ref(projectiles: Node2D) -> void:
	self._projectiles = projectiles;
