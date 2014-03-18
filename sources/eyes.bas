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
140  LET PLAYER_SPEED = 5
150  LET NUMBER_OF_EYES = 100
160  LET EYES_SCATTER = 20
170  LET EYES_START_POSITION = 25
180  LET EYES_START_ROTATION_POSITION = 15
190  LET eyes_minimal_speed = 7.5
200  LET eyes_maximal_speed = 15
210
220  REM Fog settings:
230  FOG(1)
240  FOG_COLOR(0, 0, 0)
250  FOG_DEPTH(20)
260
270  REM Creating eyes:
280  DIM eyes[100]
290  DIM eyes_positions_x[100]
300  DIM eyes_positions_y[100]
310  DIM eyes_positions_z[100]
320  DIM eyes_speeds[100]
330  LET i = 0
340  IF i > NUMBER_OF_EYES - 1 THEN 490
350      REM Load of eye:
360      LET eyes[i] = LOAD_OBJECT(eye_model_path)
370      LET t = 2 * PI * RND()
380      LET l = EYES_SCATTER * RND()
390      LET eyes_positions_x[i] = l * COS(t)
400      LET eyes_positions_y[i] = EYES_START_POSITION
410      LET eyes_positions_z[i] = l * SIN(t)
420      POSITION_OBJECT(eyes[i], eyes_positions_x[i], eyes_positions_y[i], eyes_positions_z[i])
430
440      REM Select of eye speed:
450      LET eyes_speeds[i] = RND() * (eyes_maximal_speed - eyes_minimal_speed) + eyes_minimal_speed
460
470      LET i = i + 1
480      GOTO 340
490
500  REM Main loop:
510  LET player_position_x = 0
520  LET player_position_z = 0
530  LET last_time = TIMER()
540  IF KEYSTATE(ESCAPE_KEY) = TRUE THEN 1210
550      REM Get delta time:
560      LET current_time = TIMER()
570      LET delta_time = current_time - last_time
580      LET last_time = current_time
590
600      REM Output FPS:
610      DIM FPS_LABEL = " fps"
620      IF delta_time = 0 THEN 660
630          PRINT(1 / delta_time)
640          PRINT(FPS_LABEL)
650          PRINT(NEW_LINE)
660
670      REM Control of player:
680      IF KEYSTATE(LEFT_KEY) = FALSE THEN 700
690          LET player_position_x = player_position_x - PLAYER_SPEED * delta_time
700      IF KEYSTATE(RIGHT_KEY) = FALSE THEN 720
710          LET player_position_x = player_position_x + PLAYER_SPEED * delta_time
720      IF KEYSTATE(DOWN_KEY) = FALSE THEN 740
730          LET player_position_z = player_position_z - PLAYER_SPEED * delta_time
740      IF KEYSTATE(UP_KEY) = FALSE THEN 760
750          LET player_position_z = player_position_z + PLAYER_SPEED * delta_time
760      POSITION_CAMERA(player_position_x, 0, player_position_z)
770
780      REM Move of eyes:
790      LET i = 0
800      IF i > NUMBER_OF_EYES - 1 THEN 920
810          LET eyes_positions_y[i] = eyes_positions_y[i] - eyes_speeds[i] * delta_time
820          IF eyes_positions_y[i] > 0 THEN 880
830              LET t = 2 * PI * RND()
840              LET l = EYES_SCATTER * RND()
850              LET eyes_positions_x[i] = player_position_x + l * COS(t)
860              LET eyes_positions_y[i] = EYES_START_POSITION
870              LET eyes_positions_z[i] = player_position_z + l * SIN(t)
880          POSITION_OBJECT(eyes[i], eyes_positions_x[i], eyes_positions_y[i], eyes_positions_z[i])
890
900          LET i = i + 1
910          GOTO 800
920
930      REM Rotate of eyes:
940      LET i = 0
950      IF i > NUMBER_OF_EYES - 1 THEN 1170
960          IF eyes_positions_y[i] > EYES_START_ROTATION_POSITION THEN 1110
970              LET delta_x = player_position_x - eyes_positions_x[i]
980              IF delta_x = 0 THEN 1030
990                  LET angle_z = ATN((0 - eyes_positions_y[i]) / delta_x)
1000                  IF delta_x > 0 THEN 1020
1010                      LET angle_z = angle_z - PI
1020                 GOTO 1040
1030                     LET angle_z = (0 - PI) / 2
1040             LET delta_z = player_position_z - eyes_positions_z[i]
1050             LET angle_x = ATN(delta_z / (0 - eyes_positions_y[i]))
1060             IF delta_z < 0 THEN 1090
1070                 LET angle_x = angle_x + PI
1080                 GOTO 1100
1090                     LET angle_x = angle_x - PI
1100             GOTO 1130
1110                 LET angle_x = 0
1120                 LET angle_z = PI / 2
1130         ROTATION_OBJECT(eyes[i], angle_x * 180 / PI, 0, 0 - angle_z * 180 / PI)
1140
1150         LET i = i + 1
1160         GOTO 950
1170
1180     SYNC()
1190     GOTO 540
1200
1210 REM Dummy:
1220 RND()