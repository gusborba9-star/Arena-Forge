class_name ArenaRules
extends RefCounted
static func resolve_element_interaction(first:String,second:String)->Dictionary:
    var a:=first.to_lower();var b:=second.to_lower()
    if (a=="water" and b in ["electricity","electric"]) or (b=="water" and a in ["electricity","electric"]):return {"result":"electricity","reaction":"shock_zone"}
    if (a=="oil" and b=="fire") or (b=="oil" and a=="fire"):return {"result":"fire","reaction":"ignite"}
    if (a=="ice" and b=="wind") or (b=="ice" and a=="wind"):return {"result":"ice","reaction":"slide"}
    return {"result":b,"reaction":"none"}
