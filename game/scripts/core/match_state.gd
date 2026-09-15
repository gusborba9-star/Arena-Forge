class_name MatchState
extends RefCounted
enum Phase { CONTROL, IGNITION, CATACLYSM, RESULT }
var phase := Phase.CONTROL
var elapsed := 0.0
var control_end := 90.0
var cataclysm_start := 180.0
var end_seconds := 240.0
func configure(control: float, cataclysm: float, ending: float) -> void:
    control_end = control
    cataclysm_start = cataclysm
    end_seconds = maxf(cataclysm, ending)
    elapsed = 0.0
    phase = Phase.CONTROL
func tick(delta: float) -> void:
    if phase == Phase.RESULT: return
    elapsed += delta
    if elapsed >= end_seconds: phase = Phase.RESULT
    elif elapsed >= cataclysm_start: phase = Phase.CATACLYSM
    elif elapsed >= control_end: phase = Phase.IGNITION
func is_result() -> bool: return phase == Phase.RESULT
