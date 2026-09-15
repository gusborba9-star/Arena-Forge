class_name ArenaState
extends RefCounted
enum Tile{NORMAL,WATER,ICE,FIRE,OIL,ELECTRIC,HAZARD,CRACKED,COLLAPSED,ABYSS}
var width:=12;var height:=7;var tiles:Array=[];var active_hazards:Array[Dictionary]=[]
func _init()->void:for y in range(height):var row:Array=[];for x in range(width):row.append(Tile.NORMAL);tiles.append(row)
func set_tile(x:int,y:int,t:Tile)->void:if x>=0 and x<width and y>=0 and y<height:tiles[y][x]=t
func get_tile(x:int,y:int)->Tile:if x>=0 and x<width and y>=0 and y<height:return tiles[y][x];return Tile.ABYSS
func world_to_tile(p:Vector2)->Vector2i:return Vector2i(clampi(int(floor((p.x-40.0)/100.0)),0,width-1),clampi(int(floor((p.y-40.0)/91.4286)),0,height-1))
func destroy_tile(x:int,y:int)->Tile:
    var c:=get_tile(x,y);var n:=c
    match c:Tile.NORMAL:n=Tile.CRACKED;Tile.CRACKED:n=Tile.COLLAPSED;Tile.COLLAPSED:n=Tile.ABYSS;_:n=Tile.CRACKED
    set_tile(x,y,n);return n
func is_walkable(x:int,y:int)->bool:return get_tile(x,y) not in [Tile.COLLAPSED,Tile.ABYSS]
func add_hazard(kind:String,value:float,duration:float)->void:active_hazards.append({"kind":kind,"value":value,"remaining":duration})
func tick(delta:float)->void:
    for h in active_hazards:h["remaining"]=maxf(0.0,float(h["remaining"])-delta)
    active_hazards=active_hazards.filter(func(h):return float(h["remaining"])>0.0)
