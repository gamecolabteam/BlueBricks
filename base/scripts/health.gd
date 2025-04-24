## Basic health resource
class_name Health extends Resource


## Emitted when [member points] are reduced
signal damaged
## Emitted when [member points] reach zero
signal depleted
## Emitted when [member points] reach [member max_points]
signal filled
## Emitted when [member points] are increased
signal healed
## Emitted when [member points] change
## after all of the other signals
signal health_changed
## Emitted when [member points] increase after being zero
signal revived


## The maximum amoutn of points this health can have
@export var max_points: float
## The current points this health has
@export var points: float
## True when [member points] are zero
var is_depleted: bool
## True when [member points] equal [member max_points]
var is_full: bool


## Reduces [member points] and emits relevant signals
func damage(amount: float):
	if is_depleted: return
	
	points = maxf(0, points - amount)
	
	if is_zero_approx(points): is_depleted = true
	
	damaged.emit()
	if is_depleted: depleted.emit()
	health_changed.emit()


## Increases [member points] and emits relevant signals
func heal(amount: float):
	if is_full: return
	
	points = minf(max_points, points + amount)
	
	var rev: bool
	if is_depleted:
		rev = true
		is_depleted = false
	
	if is_equal_approx(points, max_points): is_full = true
	
	if rev: revived.emit()
	healed.emit()
	if is_full: filled.emit()
	health_changed.emit()
