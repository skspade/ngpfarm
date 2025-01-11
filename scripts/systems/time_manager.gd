extends Node

# Signals emitted when different time units change
signal time_tick
signal hour_changed(new_hour)
signal day_changed(new_day)
signal season_changed(new_season)

# Constants defining time unit relationships
const MINUTES_PER_HOUR := 60
const HOURS_PER_DAY := 24
const DAYS_PER_SEASON := 28
const SEASONS := ["spring", "summer", "fall", "winter"]

# Time flow control variables
var time_flow_rate := 1.0  # How many real seconds pass per game minute
var is_time_flowing := true

# Current time state variables
var _minute := 0
var _hour := 6  # Game starts at 6 AM
var _day := 1
var _season := 0  # Seasons are zero-indexed (0 = spring)
var _year := 1

# Accumulator for partial time updates
var _accumulated_time := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Skip time processing if time is paused
	if not is_time_flowing:
		return
	
	# Accumulate real time until we reach the time_flow_rate	
	_accumulated_time += delta
	if _accumulated_time >= time_flow_rate:
		_accumulated_time = 0.0
		advance_time()

func advance_time() -> void:
	# Increment minute and emit time tick
	_minute += 1
	emit_signal("time_tick")
	
	# Check for hour rollover
	if _minute >= MINUTES_PER_HOUR:
		_minute = 0
		_hour += 1
		emit_signal("hour_changed", _hour)
		
		# Check for day rollover
		if _hour >= HOURS_PER_DAY:
			_hour = 0
			_day += 1
			emit_signal("day_changed", _day)
			
			# Check for season rollover
			if _day > DAYS_PER_SEASON:
				_day = 1
				_season = (_season + 1) % SEASONS.size()
				emit_signal("season_changed", get_season_name())
				
				# Check for year rollover
				if _season == 0:
					_year += 1

# Helper functions for time manipulation and retrieval
func get_time_string() -> String:
	return "%02d:%02d" % [_hour, _minute]

func get_season_name() -> String:
	return SEASONS[_season]

func set_time_flow_rate(rate: float) -> void:
	time_flow_rate = rate

func pause_time() -> void:
	is_time_flowing = false

func resume_time() -> void:
	is_time_flowing = true
