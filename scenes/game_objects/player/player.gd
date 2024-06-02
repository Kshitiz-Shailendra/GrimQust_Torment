extends CharacterBody2D

@export var MAX_SPEED:int 
@export var ACCELERATION: int

@onready var damage_interval_timer:Timer = $DamageIntervalTimer
@onready var health_component:HealthComponent = $HealthComponent
@onready var health_bar: ProgressBar = $HealthBar


var number_colliding_bodies:int

func _ready() -> void:
	health_component.health_changed.connect(on_health_changed)
	update_health_display()

func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var max_velocity = direction * MAX_SPEED
	
	self.velocity = self.velocity.lerp(max_velocity, 1.0 - exp(-delta * ACCELERATION))
	
	move_and_slide()

func get_movement_vector():
	var move_horizontal = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var move_vertical 	= Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(move_horizontal,move_vertical)


func check_deal_damage() -> void:
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
	health_component.damage(1)
	#tggv print(health_component.current_health)
	damage_interval_timer.start()

func update_health_display() -> void:
	health_bar.value = health_component.get_health_percent()

#player takes damage while enters this area. 
#Damage done periodically not per frame as it will instantly kill player
#Concept of invincilibilty frames comes here
func on_enemy_collision_area_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()

func on_enemy_collision_area_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1


func on_damage_interval_timer_timeout():
	check_deal_damage()


func on_health_changed():
	update_health_display()
