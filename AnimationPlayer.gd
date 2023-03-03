extends AnimationPlayer

var start_time := 0.0


func _ready():
	start_time = Time.get_unix_time_from_system()


func _on_animation_player_animation_finished(anim_name):
	if OS.has_feature("movie"):
		var time_taken := Time.get_unix_time_from_system() - start_time

		var quality := float(ProjectSettings.get_setting("editor/movie_writer/mjpeg_quality"))
		var file = FileAccess.open("res://output/movie_%.2f.txt" % quality, FileAccess.WRITE)
		file.store_string(str(time_taken) + "\n")

		get_tree().quit()
