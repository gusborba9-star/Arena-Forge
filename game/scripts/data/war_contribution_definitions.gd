class_name WarContributionDefinitions
extends RefCounted

static func create(data: Dictionary = {}) -> Dictionary:
    return {
        "id": str(data.get("id", "")),
        "metrics": data.get("metrics", []).duplicate(true),
        "individual_limits": data.get("individual_limits", {}).duplicate(true),
        "forge_limits": data.get("forge_limits", {}).duplicate(true),
        "eligibility": data.get("eligibility", {}).duplicate(true),
        "aggregation": data.get("aggregation", "sum"),
        "objective_contribution": data.get("objective_contribution", {}).duplicate(true)
    }
