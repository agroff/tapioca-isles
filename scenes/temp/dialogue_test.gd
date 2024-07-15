extends Control


var sample_hz = 22050.0 # Keep the number of samples to mix low, GDScript is not super fast.
var pulse_hz = 0.0
#var pulse_hz = 440.0
var phase = 0.0
#var pitch_mod = 80.0
#var pitch_mod = 280.0
var pitch_mod = -80.0
#var pitch_mod = -100.0
var playback: AudioStreamPlayback = null # Actual playback stream, assigned in _ready().

#const notes = [
	#261.6, # C
	#277.2, # C#
	#293.7, # D
	#311.1, # Eb
	#329.6, # E
	#349.2, # F
	#370.0, # F#
	#392.0, # G
	#415.3, # G#
	#440.0, # A
	#466.2, # Bb
	#493.9 # B
#]
const notes = [
	160,
	180,
	200,
	220,
	240,
	260,
	280,
	300,
	320,
	340,
	360,
	380,
]

var note_queue = []

#var all_text = "Hi Chris - this is the game talking".split(" ")
var all_text = "Last but not least - the tea shop. This one might be the most important of all. No pressure hehe. King pruitt loves his tea. He always said that fresh tea is all that truly matters.".split(" ")


#var all_text = "Hurry now! Gather round! I'm here today to offer you the opportunity of a lifetime. 
#King Pruitt just announced that the Grand Dulani Tournament will be held here in Tapioca Isles!".split(" ")

func _process(_delta):
	_fill_buffer()


func _fill_buffer():
	var increment = pulse_hz / sample_hz

	var to_fill = playback.get_frames_available()
	while to_fill > 0:
		playback.push_frame(Vector2.ONE * sin(phase * TAU)) # Audio frames are stereo.
		phase = fmod(phase + increment, 1.0)
		to_fill -= 1


func buffer_text(text: String):
	for i in text:
		
		
		if i == " ":
			#$Label2.text = ""
			note_queue.push_back(0)
			note_queue.push_back(0)
		elif i in [".", "!", "?", ",", "-"]:
			note_queue.push_back(0)
			note_queue.push_back(0)
			note_queue.push_back(0)
			note_queue.push_back(0)
			note_queue.push_back(0)
		else:
			#$Label2.text += i
			#print(i)
			var num = i.to_utf8_buffer()[0]
			var idx = num % notes.size()
			note_queue.push_back(notes[idx])
			

func write_label_delayed(word):
	await get_tree().create_timer(0.5).timeout
	$Label.text = word

func buffer_next():
	if all_text.size() == 0: return
	var word = all_text[0]
	all_text.remove_at(0)
	buffer_text(word + " ")
	write_label_delayed(word)
	#$Label.text = word

func _ready():
	$Player.stream.mix_rate = sample_hz # Setting mix rate is only possible before play().
	$Player.play()
	playback = $Player.get_stream_playback()
	_fill_buffer() # Prefill, do before play() to avoid delay.
	await get_tree().create_timer(3.0).timeout
	$Timer.start()


func _on_timer_timeout() -> void:
	if note_queue.size() == 0:
		if all_text.size() > 0:
			buffer_next()
		else:
			pulse_hz = 0
	else:
		pulse_hz = note_queue.pop_back() + pitch_mod
		
	#note_queue = notes.duplicate()
	#note_queue.shuffle()
	#pulse_hz = randf_range(220, 987)
	#if pulse_hz < 280:
		#pulse_hz = 0
	#print(pulse_hz)
