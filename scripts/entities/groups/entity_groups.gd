extends Node

var _minions: Node2D = null;
var _players: Node2D = null;

func get_minions() -> Array[Node]:
	return self._minions.get_children();

func set_minions_ref(minions: Node2D):
	self._minions = minions;

func get_players() -> Array[Node]:
	return self._players.get_children();

func set_players_ref(players: Node2D):
	self._players = players;
