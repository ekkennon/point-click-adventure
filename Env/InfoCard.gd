extends Node


signal close_dialog

onready var text_label : RichTextLabel = $RichTextLabel


func _ready():
	clear()


func toggle(show):
	if show:
		self.visible = true
		$AnimatedSprite.play("flip")
		$AnimatedSprite.set_frame(0)
	else:
		self.visible = false
		clear()


func clear():
	self.visible = false
	$RichTextLabel.bbcode_text = ""
	$RichTextLabel.visible = false
	$Button.visible = false


func _on_AnimatedSprite_animation_finished():
	text_label.visible = true
	text_label.percent_visible = 0 
	$Tween.interpolate_property(text_label, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Button_pressed():
	toggle(false)
	emit_signal("close_dialog")


func _on_Tween_tween_completed(object, key):
	$Button.visible = true
