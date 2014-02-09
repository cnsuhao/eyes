10  REM Util constants:
20  LET FALSE = 0
30  LET TRUE = 1
40  LET ESCAPE_KEY = 1
50  LET LEFT_KEY = 82
60  LET RIGHT_KEY = 84
70  LET DOWN_KEY = 83
80  LET UP_KEY = 81
90  LET PI = 3.14159
100
110 REM Game constants:
120 DIM eye_model_path = "data/eye.ao"
130 LET PLAYER_SPEED = 2.5
140 LET EYE_MODEL_CORRECT_ANGLE = 180
150 LET NUMBER_OF_EYES = 10
160 LET EYES_SCATTER = 10
170 LET EYES_START_POSITION = 25
180 LET eyes_minimal_speed = 5
190 LET eyes_maximal_speed = 10
200
210 REM Creating eyes:
220 DIM eyes[10]
230 DIM eyes_positions_x[10]
240 DIM eyes_positions_y[10]
250 DIM eyes_positions_z[10]
260 DIM eyes_speeds[10]
270 LET i = 0
280 IF i > NUMBER_OF_EYES - 1 THEN 440
290     REM Load of eye:
300     LET eyes[i] = LOAD_OBJECT(eye_model_path)
310     LET t = 2 * PI * RND()
320     LET l = EYES_SCATTER * RND()
330     LET eyes_positions_x[i] = l * COS(t)
340     LET eyes_positions_y[i] = EYES_START_POSITION
350     LET eyes_positions_z[i] = l * SIN(t)
360     POSITION_OBJECT(eyes[i], eyes_positions_x[i], eyes_positions_y[i], eyes_positions_z[i])
370     ROTATION_OBJECT(eyes[i], 0, 0, EYE_MODEL_CORRECT_ANGLE)
380
390     REM Select of eye speed:
400     LET eyes_speeds[i] = RND() * (eyes_maximal_speed - eyes_minimal_speed) + eyes_minimal_speed
410
420     LET i = i + 1
430     GOTO 280
440
450 REM Main loop:
460 LET player_position_x = 0
470 LET player_position_z = 0
480 LET last_time = TIMER()
490 IF KEYSTATE(ESCAPE_KEY) = TRUE THEN 780
500     REM Get delta time:
510     LET current_time = TIMER()
520     LET delta_time = current_time - last_time
530     LET last_time = current_time
540
550     REM Control of player:
560     IF KEYSTATE(LEFT_KEY) = FALSE THEN 580
570         LET player_position_x = player_position_x - PLAYER_SPEED * delta_time
580     IF KEYSTATE(RIGHT_KEY) = FALSE THEN 600
590         LET player_position_x = player_position_x + PLAYER_SPEED * delta_time
600     IF KEYSTATE(DOWN_KEY) = FALSE THEN 620
610         LET player_position_z = player_position_z - PLAYER_SPEED * delta_time
620     IF KEYSTATE(UP_KEY) = FALSE THEN 640
630         LET player_position_z = player_position_z + PLAYER_SPEED * delta_time
640     POSITION_CAMERA(player_position_x, 0, player_position_z)
650
660     REM Move of eyes:
670     LET i = 0
680     IF i > NUMBER_OF_EYES - 1 THEN 740
690         LET eyes_positions_y[i] = eyes_positions_y[i] - eyes_speeds[i] * delta_time
700         POSITION_OBJECT(eyes[i], eyes_positions_x[i], eyes_positions_y[i], eyes_positions_z[i])
710
720         LET i = i + 1
730         GOTO 680
740
750     SYNC()
760     GOTO 490
770
780 REM Dummy:
790 RND()
