extends Node

const TOTAL_SCORABLE_INTERACTION_COUNT := 11

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


func scored_interaction_count() -> int:
	var count := 0

	for v in _had_interactions.values():
		if v != 0:
			count += 1

	return count


func completion_ratio() -> float:
	return float(scored_interaction_count()) / float(TOTAL_SCORABLE_INTERACTION_COUNT)


func good_bad_ratio() -> float:
	if scored_interaction_count() == 0:
		return 0.0

	var good_sum := 0.0
	var bad_sum := 0.0

	for v in _had_interactions.values():
		if v > 0:
			good_sum += 1
		elif v < 0:
			bad_sum += 1

	if bad_sum == 0:
		return 1.0

	return good_sum / bad_sum


func total_score() -> float:
	var good_count := 0
	for v in _had_interactions.values():
		if v > 0:
			good_count += 1

	return float(good_count) / float(TOTAL_SCORABLE_INTERACTION_COUNT)


func has_had_interaction(interaction: String) -> bool:
	return _had_interactions.has(interaction)


func had_interactions() -> PoolStringArray:
	var interactions = PoolStringArray()

	for k in _had_interactions.keys():
		interactions.append("%s (%s)" % [k, _had_interactions[k]])

	return interactions
