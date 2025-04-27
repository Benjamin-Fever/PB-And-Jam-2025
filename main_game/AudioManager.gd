extends Node2D

var sound_fx : AudioStreamPlayer2D
var music : AudioStreamPlayer2D

func _ready():
    sound_fx = AudioStreamPlayer2D.new()
    sound_fx.bus = "Sound FX"
    music = AudioStreamPlayer2D.new()
    music.bus = "Music"
    add_child(sound_fx)
    add_child(music)

func play_music(resourcePath: String) -> void:
    if resourcePath == "":
        music.stop()
        return
    music.stream = ResourceLoader.load(resourcePath)
    music.play()

func play_sound(resourcePath: String) -> void:
    if resourcePath == "":
        sound_fx.stop()
        return
    var stream = ResourceLoader.load(resourcePath)
    if sound_fx.stream == stream:
        return
    sound_fx.stream = stream
    sound_fx.play()