extends Node

var _last_interaction := ""
var _had_interactions := {}


func new_interaction(interaction: String) -> void:
	_last_interaction = interaction

	if not _had_interactions.has(interaction):
		_had_interactions[interaction] = 0


func good_interaction() -> void:
	if _had_interactions[_last_interaction] == 0:
		_had_interactions[_last_interaction] = 1


func bad_interaction() -> void:
	if _had_interactions[_last_interaction] == 0:
		_had_interactions[_last_interaction] = -1


func has_had_interaction(interaction: String) -> bool:
	return _had_interactions.has(interaction)


func had_interactions() -> PoolStringArray:
	var interactions = PoolStringArray()

	for k in _had_interactions.keys():
		interactions.append("%s (%s)" % [k, _had_interactions[k]])

	return interactions
