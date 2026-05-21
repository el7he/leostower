extends CharacterBody2D
class_name Player

# ============================================================
#  CELESTE-STYLE PLATFORMER CONTROLLER — Godot 4.6.1
#  Features : coyote time, jump buffer, variable jump height,
#             smooth acceleration, snappy direction changes,
#             optional wall-slide & wall-jump (toggle below)
# ============================================================

# ── Feature toggles ──────────────────────────────────────────
@export var enable_wall_mechanics : bool = true

# ── Horizontal movement ──────────────────────────────────────
@export_group("Horizontal Movement")
@export var max_speed        : float = 260.0
@export var acceleration     : float = 1800.0
@export var deceleration     : float = 2400.0
@export var air_acceleration : float = 1400.0
@export var air_deceleration : float = 1000.0
@export var turn_multiplier  : float = 2.5   # boost quand on change de direction

# ── Gravity ──────────────────────────────────────────────────
@export_group("Gravity")
@export var gravity_up       : float = 1100.0  # gravité pendant la montée
@export var gravity_down     : float = 1400.0  # gravité en descente (+ lourde = + pêchu)
@export var max_fall_speed   : float = 600.0

# ── Jump ─────────────────────────────────────────────────────
@export_group("Jump")
@export var jump_force         : float = -420.0   # impulsion initiale (négatif = vers le haut)
@export var jump_cut_factor    : float = 0.4      # coupe la vélocité quand on relâche tôt
@export var coyote_time        : float = 0.10     # secondes après avoir quitté le sol
@export var jump_buffer_time   : float = 0.12     # secondes avant de toucher le sol

# ── Wall slide / wall jump (optionnel) ───────────────────────
@export_group("Wall Mechanics")
@export var wall_slide_speed   : float = 80.0
@export var wall_jump_force    : Vector2 = Vector2(320.0, -400.0)
@export var wall_jump_lock_time: float = 0.15  # temps où le joueur ne contrôle pas l'horizontal
@export var player_sprite : playersprite
# ── Interne ──────────────────────────────────────────────────
var _coyote_timer       : float = 0.0
var _jump_buffer_timer  : float = 0.0
var _wall_jump_lock     : float = 0.0
var _was_on_floor       : bool  = false
var _facing_dir         : float = 1.0   # 1 = droite, -1 = gauche
var _is_jumping         : bool  = false
@onready var cri_macaque: AudioStreamPlayer2D = $cri_macaque
@onready var sprite_2d: Sprite2D = $Sprite2D

var time_elapsed : float
var banananumber : int =0;
var isinrotation : bool = false;
func _enter_tree():
	Gamemanager.playervar = self

func _ready() -> void:
	setscalex()
	

	pass

func setscalex(sizenumber : int = 0) ->void:
	var xscale :float = 0.2 + (0.03 *  sizenumber)
	sprite_2d.scale=Vector2(xscale,0.256)
	velocity = Vector2.ZERO
	
func eat()->void:
	banananumber+=1
	if banananumber==8:
		player_sprite.beginloop()
		banananumber=0
		setscalex()
		isinrotation = true
		var cri = "res://bananes/Monkey Noises SFX.wav"
		cri_macaque.stream = load(cri)
		cri_macaque.play()
		await get_tree().create_timer(4.0).timeout
		player_sprite.endloop()
		isinrotation = false
	setscalex(banananumber)
	pass
	
func teleport(xvar:float,yvar:float) -> void : 
	
	self.global_position = Vector2(xvar, yvar)

func _physics_process(delta: float) -> void:
	var input_dir := _get_input_direction()
	
	_update_timers(delta)
	_apply_gravity(delta)
	_apply_horizontal_movement(delta, input_dir)

	if enable_wall_mechanics:
		_handle_wall_slide(delta, input_dir)

	_handle_jump(input_dir)
	_update_facing(input_dir)

	move_and_slide()


# ── Input ────────────────────────────────────────────────────

func _get_input_direction() -> float:
	return Input.get_axis("move_left", "move_right")


# ── Timers ───────────────────────────────────────────────────

func _update_timers(delta: float) -> void:
	# Coyote time : on vient de quitter le sol sans sauter
	if is_on_floor():
		_coyote_timer = coyote_time
		_is_jumping = false
	elif _was_on_floor and not _is_jumping:
		pass  # le timer va décrémenter naturellement
	_coyote_timer = maxf(_coyote_timer - delta, 0.0)

	# Jump buffer : le joueur a appuyé sur saut récemment
	if Input.is_action_just_pressed("jump"):
		#SaveManager.save_game({"clicks":clicks,"time_elapsed":time_elapsed})
		#print("click : ",clicks)
		if isinrotation==false : 
			var randomcri = randi_range(1, 4)
			var cri = "res://Monkey - Sound Effect"+str(randomcri)+".wav"
			cri_macaque.stream = load(cri)
			cri_macaque.play()
			jump_force=-420
		else :
			jump_force=-800
		_jump_buffer_timer = jump_buffer_time
	_jump_buffer_timer = maxf(_jump_buffer_timer - delta, 0.0)

	# Wall jump lock
	_wall_jump_lock = maxf(_wall_jump_lock - delta, 0.0)

	_was_on_floor = is_on_floor()


# ── Gravity ──────────────────────────────────────────────────

func _apply_gravity(delta: float) -> void:
	if is_on_floor():
		return

	# Gravité asymétrique : montée lente, descente rapide = très Celeste
	var grav := gravity_up if velocity.y < 0.0 else gravity_down
	velocity.y = minf(velocity.y + grav * delta, max_fall_speed)


# ── Horizontal ───────────────────────────────────────────────

func _apply_horizontal_movement(delta: float, input_dir: float) -> void:
	if _wall_jump_lock > 0.0:
		return  # on bloque le contrôle horizontal pendant un wall jump

	var on_ground := is_on_floor()
	var accel := acceleration if on_ground else air_acceleration
	var decel := deceleration if on_ground else air_deceleration

	if input_dir != 0.0:
		# Boost de changement de direction (le fameux "snap" Celeste)
		var turning := (input_dir * velocity.x < 0.0)
		var effective_accel := accel * (turn_multiplier if turning else 1.0)

		velocity.x = move_toward(velocity.x, input_dir * max_speed, effective_accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, decel * delta)


# ── Jump ─────────────────────────────────────────────────────

func _handle_jump(input_dir: float) -> void:
	var can_ground_jump := _coyote_timer > 0.0
	var can_wall_jump   := enable_wall_mechanics and is_on_wall() and not is_on_floor()
	var buffered        := _jump_buffer_timer > 0.0

	# ── Ground / coyote jump ──
	if buffered and can_ground_jump:
		_execute_jump(jump_force)
		return

	# ── Wall jump ──
	if buffered and can_wall_jump:
		_execute_wall_jump()
		return

	# ── Variable jump height : relâcher = couper l'élan ──
	if Input.is_action_just_released("jump") and velocity.y < 0.0 and _is_jumping:
		velocity.y *= jump_cut_factor


func _execute_jump(force: float) -> void:
	velocity.y = force
	_coyote_timer = 0.0
	_jump_buffer_timer = 0.0
	_is_jumping = true


func _execute_wall_jump() -> void:
	var wall_normal := get_wall_normal()
	velocity.x = wall_normal.x * wall_jump_force.x
	velocity.y = wall_jump_force.y
	_jump_buffer_timer = 0.0
	_is_jumping = true
	_wall_jump_lock = wall_jump_lock_time
	_facing_dir = wall_normal.x


# ── Wall slide ───────────────────────────────────────────────

func _handle_wall_slide(_delta: float, input_dir: float) -> void:
	if not is_on_wall() or is_on_floor():
		return
	if velocity.y < 0.0:
		return  # on monte, pas de slide

	# Slide seulement si le joueur pousse vers le mur
	var wall_dir := -get_wall_normal().x   # direction du mur
	if input_dir != 0.0 and signf(input_dir) == signf(wall_dir):
		velocity.y = minf(velocity.y, wall_slide_speed)


# ── Facing direction ─────────────────────────────────────────

func _update_facing(input_dir: float) -> void:
	if input_dir != 0.0 and _wall_jump_lock <= 0.0:
		_facing_dir = signf(input_dir)

	# Flip le sprite si tu as un Sprite2D ou AnimatedSprite2D en enfant
	var sprite := get_node_or_null("Sprite2D")
	if sprite == null:
		sprite = get_node_or_null("AnimatedSprite2D")
	if sprite:
		sprite.flip_h = (_facing_dir < 0.0)

func die():
	get_tree().reload_current_scene()
	print("oui")
