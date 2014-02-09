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
170 LET EYES_START_POSITION = 10
180
190 REM Creating eyes:
200 DIM eyes[10]
210 LET i = 0
220 IF i > NUMBER_OF_EYES - 1 THEN 330
230     LET eyes[i] = LOAD_OBJECT(eye_model_path)
240     LET t = 2 * PI * RND()
250     LET l = EYES_SCATTER * RND()
260     LET eye_x = l * COS(t)
270     LET eye_z = l * SIN(t)
280     POSITION_OBJECT(eyes[i], eye_x, EYES_START_POSITION, eye_z)
290     ROTATION_OBJECT(eyes[i], 0, 0, EYE_MODEL_CORRECT_ANGLE)
300
310     LET i = i + 1
320     GOTO 220
330
340 REM Main loop:
350 LET player_position_x = 0
360 LET player_position_z = 0
370 LET last_time = TIMER()
380 IF KEYSTATE(ESCAPE_KEY) = TRUE THEN 580
390     REM Get delta time:
400     LET current_time = TIMER()
410     LET delta_time = current_time - last_time
420     LET last_time = current_time
430
440     REM Control of player:
450     IF KEYSTATE(LEFT_KEY) = FALSE THEN 470
460         LET player_position_x = player_position_x - PLAYER_SPEED * delta_time
470     IF KEYSTATE(RIGHT_KEY) = FALSE THEN 490
480         LET player_position_x = player_position_x + PLAYER_SPEED * delta_time
490     IF KEYSTATE(DOWN_KEY) = FALSE THEN 510
500         LET player_position_z = player_position_z - PLAYER_SPEED * delta_time
510     IF KEYSTATE(UP_KEY) = FALSE THEN 530
520         LET player_position_z = player_position_z + PLAYER_SPEED * delta_time
530     POSITION_CAMERA(player_position_x, 0, player_position_z)
540
550     SYNC()
560     GOTO 380
570
580 REM Dummy:
590 RND()
