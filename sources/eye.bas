10  LET FALSE = 0
20  LET TRUE = 1
30  LET ESCAPE_KEY = 1
40  LET LEFT_KEY = 82
50  LET RIGHT_KEY = 84
60  LET DOWN_KEY = 83
70  LET UP_KEY = 81
80  DIM eye_model_path = "data/eye.ao"
90  LET PLAYER_SPEED = 1
100
110 LET eye = LOAD_OBJECT(eye_model_path)
120 POSITION_OBJECT(eye, 0, 5, 0)
130 ROTATION_OBJECT(eye, 0, 0, 180)
140
150 REM Main loop:
160 LET player_position_x = 0
170 LET player_position_z = 0
180 LET last_time = TIMER()
190 IF KEYSTATE(ESCAPE_KEY) = TRUE THEN 370
200     LET current_time = TIMER()
210     LET delta_time = current_time - last_time
220     LET last_time = current_time
230
240     IF KEYSTATE(LEFT_KEY) = FALSE THEN 260
250         LET player_position_x = player_position_x - PLAYER_SPEED * delta_time
260     IF KEYSTATE(RIGHT_KEY) = FALSE THEN 280
270         LET player_position_x = player_position_x + PLAYER_SPEED * delta_time
280     IF KEYSTATE(DOWN_KEY) = FALSE THEN 300
290         LET player_position_z = player_position_z - PLAYER_SPEED * delta_time
300     IF KEYSTATE(UP_KEY) = FALSE THEN 320
310         LET player_position_z = player_position_z + PLAYER_SPEED * delta_time
320     POSITION_CAMERA(player_position_x, 0, player_position_z)
330
340     SYNC()
350     GOTO 190
360
370 REM Dummy:
380 RND()
