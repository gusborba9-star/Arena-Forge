class_name WarRewardsDefinitions
extends RefCounted

static func create(data: Dictionary = {}) -> Dictionary:
    return {
        "id": str(data.get("id", "war_rewards_default")),
        "placement_rewards": data.get("placement_rewards", {}).duplicate(true),
        "participation_rewards": data.get("participation_rewards", {}).duplicate(true),
        "individual_contribution_rewards": data.get("individual_contribution_rewards", {}).duplicate(true),
        "objective_rewards": data.get("objective_rewards", {}).duplicate(true),
        "forge_rewards": data.get("forge_rewards", {}).duplicate(true),
        "idempotency_key_policy": data.get("idempotency_key_policy", "war_id:player_id:reward_id")
    }
