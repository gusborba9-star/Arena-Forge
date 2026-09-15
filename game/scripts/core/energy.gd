class_name EnergyPool
extends RefCounted
var maximum:=10.0; var current:=10.0; var regen_interval:=1.5; var timer:=0.0
func configure(max_value:float,interval:float)->void: maximum=maxf(0.0,max_value);current=maximum;regen_interval=maxf(0.05,interval);timer=0.0
func tick(delta:float)->void:
    if current>=maximum:timer=0.0;return
    timer+=delta
    while timer>=regen_interval and current<maximum:timer-=regen_interval;current=minf(maximum,current+1.0)
func spend(cost:float)->bool: if current+0.0001<cost:return false;current-=cost;return true
