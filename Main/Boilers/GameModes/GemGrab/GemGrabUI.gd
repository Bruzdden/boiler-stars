extends Control

var time = 0
var countdown = 15


func _ready():
	$Blue/Count.text = str(Global.gemCollected[0])
	$Red/Count.text = str(Global.gemCollected[1])
	$Red/ProgressBar.max_value = 10
	$Blue/ProgressBar.max_value = 10
	$Red/ProgressBar.value = 0
	$Blue/ProgressBar.value = 0
	
	$GameCountdown/GameCountdownText.hide()



func _process(delta):
	$GameTime/GameTimeText.text = str(time)
	$GameCountdown/GameCountdownText.text = str(countdown)
	
	$Red/ProgressBar.value = Global.gemCollected[1]
	$Blue/ProgressBar.value = Global.gemCollected[0]
	
	if Global.gemCollected[0] >= 10 or Global.gemCollected[1] >= 10:
		$GameCountdown/GameCountdownText.show()
		if $GameCountdown/GameCountdownTimer.is_stopped():
			$GameCountdown/GameCountdownTimer.start()
	else:
		$GameCountdown/GameCountdownTimer.stop()


func _on_game_t_ime_timer_timeout():
	time += 1


func _on_game_countdown_timer_timeout():
	countdown -= 1
