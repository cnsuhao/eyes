10   REM Util constants:
20   LET FALSE = 0
30   LET TRUE = 1
40   LET ESCAPE_KEY = 1
50   LET LEFT_KEY = 82
60   LET RIGHT_KEY = 84
70   LET DOWN_KEY = 83
80   LET UP_KEY = 81
90   LET PI = 3.14159
100  DIM NEW_LINE = "\n"
110
120  REM Game constants:
130  DIM eye_model_path = "data/eye.ao"
140  LET PLAYER_SPEED = 3
150  LET NUMBER_OF_EYES = 25
160  LET EYES_SCATTER = 10
170  LET EYES_START_POSITION = 25
180  LET eyes_minimal_speed = 10
190  LET eyes_maximal_speed = 20
200
210  REM Fog settings:
220  FOG(1)
230  FOG_COLOR(0, 0, 0)
240  FOG_DEPTH(20)
250
260  REM Creating eyes:
270  DIM eyes[25]
280  DIM eyes_positions_x[25]
290  DIM eyes_positions_y[25]
300  DIM eyes_positions_z[25]
310  DIM eyes_speeds[25]
320  LET i = 0
330  IF i > NUMBER_OF_EYES - 1 THEN 480
340      REM Load of eye:
350      LET eyes[i] = LOAD_OBJECT(eye_model_path)
360      LET t = 2 * PI * RND()
370      LET l = EYES_SCATTER * RND()
380      LET eyes_positions_x[i] = l * COS(t)
390      LET eyes_positions_y[i] = RND() * EYES_START_POSITION
400      LET eyes_positions_z[i] = l * SIN(t)
410      POSITION_OBJECT(eyes[i], eyes_positions_x[i], eyes_positions_y[i], eyes_positions_z[i])
420
430      REM Select of eye speed:
440      LET eyes_speeds[i] = RND() * (eyes_maximal_speed - eyes_minimal_speed) + eyes_minimal_speed
450
460      LET i = i + 1
470      GOTO 330
480
490  REM Main loop:
500  LET player_position_x = 0
510  LET player_position_z = 0
520  LET last_time = TIMER()
530  IF KEYSTATE(ESCAPE_KEY) = TRUE THEN 1160
540      REM Get delta time:
550      LET current_time = TIMER()
560      LET delta_time = current_time - last_time
570      LET last_time = current_time
580
590      REM Output FPS:
600      DIM FPS_LABEL = " fps"
610      IF delta_time = 0 THEN 650
620          PRINT(1 / delta_time)
630          PRINT(FPS_LABEL)
640          PRINT(NEW_LINE)
650
660      REM Control of player:
670      IF KEYSTATE(LEFT_KEY) = FALSE THEN 690
680          LET player_position_x = player_position_x - PLAYER_SPEED * delta_time
690      IF KEYSTATE(RIGHT_KEY) = FALSE THEN 710
700          LET player_position_x = player_position_x + PLAYER_SPEED * delta_time
710      IF KEYSTATE(DOWN_KEY) = FALSE THEN 730
720          LET player_position_z = player_position_z - PLAYER_SPEED * delta_time
730      IF KEYSTATE(UP_KEY) = FALSE THEN 750
740          LET player_position_z = player_position_z + PLAYER_SPEED * delta_time
750      POSITION_CAMERA(player_position_x, 0, player_position_z)
760
770      REM Move of eyes:
780      LET i = 0
790      IF i > NUMBER_OF_EYES - 1 THEN 910
800          LET eyes_positions_y[i] = eyes_positions_y[i] - eyes_speeds[i] * delta_time
810          IF eyes_positions_y[i] > 0 THEN 870
820              LET t = 2 * PI * RND()
830              LET l = EYES_SCATTER * RND()
840              LET eyes_positions_x[i] = player_position_x + l * COS(t)
850              LET eyes_positions_y[i] = EYES_START_POSITION
860              LET eyes_positions_z[i] = player_position_z + l * SIN(t)
870          POSITION_OBJECT(eyes[i], eyes_positions_x[i], eyes_positions_y[i], eyes_positions_z[i])
880
890          LET i = i + 1
900          GOTO 790
910
920      REM Rotate of eyes:
930      LET i = 0
940      IF i > NUMBER_OF_EYES - 1 THEN 1120
950          LET delta_x = player_position_x - eyes_positions_x[i]
960          IF delta_x = 0 THEN 1010
970              LET angle_z = ATN((0 - eyes_positions_y[i]) / delta_x)
980              IF delta_x > 0 THEN 1000
990                  LET angle_z = angle_z - PI
1000             GOTO 1020
1010                 LET angle_z = (0 - PI) / 2
1020         LET delta_z = player_position_z - eyes_positions_z[i]
1030         LET angle_x = ATN(delta_z / (0 - eyes_positions_y[i]))
1040         IF delta_z < 0 THEN 1070
1050             LET angle_x = angle_x + PI
1060             GOTO 1080
1070                 LET angle_x = angle_x - PI
1080         ROTATION_OBJECT(eyes[i], angle_x * 180 / PI, 0, 0 - angle_z * 180 / PI)
1090
1100         LET i = i + 1
1110         GOTO 940
1120
1130     SYNC()
1140     GOTO 530
1150
1160 REM Dummy:
1170 RND()
