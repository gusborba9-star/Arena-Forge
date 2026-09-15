class_name ArenaHero
extends RefCounted
var id:="elf"; var hp:=120.0; var max_hp:=120.0; var damage:=14.0; var speed:=260.0; var armor:=0.0; var dead:=false; var position:=Vector2.ZERO
func configure(d:Dictionary)->void: id=str(d.get("id",id)); max_hp=float(d.get("hp",max_hp)); hp=max_hp; damage=float(d.get("damage",damage)); speed=float(d.get("speed",speed)); armor=float(d.get("armor",armor)); dead=false
func move(direction:Vector2,delta:float)->void: if not dead: position+=direction.normalized()*speed*delta if direction.length_squared()>1.0 else Vector2.ZERO
func take_damage(amount:float)->bool: if dead:return false; hp=maxf(0.0,hp-maxf(0.0,amount-armor)); if hp<=0.0:dead=true; return dead
func heal(amount:float)->void: if not dead:hp=minf(max_hp,hp+maxf(0.0,amount))
