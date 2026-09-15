class_name ArenaEnemy
extends RefCounted
enum Role{CHASER,RANGED,TANK,SWARM,ELITE}
var role:=Role.CHASER;var hp:=40.0;var max_hp:=40.0;var damage:=8.0;var speed:=90.0;var armor:=0.0;var dead:=false;var position:=Vector2.ZERO
func configure(r:Role,h:float,d:float,s:float,a:float)->void:role=r;max_hp=h;hp=h;damage=d;speed=s;armor=a;dead=false
func move_toward_target(target:Vector2,delta:float)->void:if not dead and position.distance_squared_to(target)>1.0:position+=position.direction_to(target)*speed*delta
func take_damage(amount:float)->bool:if dead:return false;hp=maxf(0.0,hp-maxf(0.0,amount-armor));if hp<=0.0:dead=true;return dead
