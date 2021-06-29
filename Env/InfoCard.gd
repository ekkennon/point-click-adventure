extends Node
onready var Text : RichTextLabel = $RichTextLabel
onready var AnimationSprite : AnimatedSprite = $AnimatedSprite

signal close_dialog

func _ready():
	clear()

func toogle(show):
	print("card interacted")
	if(show):
		$Button.visible = false
		Text.visible = false
		self.visible = true
		AnimationSprite.play("flip")
		AnimationSprite.set_frame(0)
	else:
		self.visible = false
		clear()


func clear():
	self.visible = false
	Text.bbcode_text = ""
	Text.visible = false
	$Button.visible = false


func _on_AnimatedSprite_animation_finished():
	Text.visible = true
	Text.percent_visible = 0 
	$Tween.interpolate_property(Text, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Button_pressed():
	toogle(false)
	emit_signal("close_dialog")


func _on_Tween_tween_completed(object, key):
	$Button.visible = true
