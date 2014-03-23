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
190  LET EYES_NYSTAGMUS_MAXIMUM = 1
200  LET eyes_minimal_speed = 7.5
210  LET eyes_maximal_speed = 10
220
230  REM Fog settings:
240  FOG(1)
250  FOG_COLOR(0, 0, 0)
260  FOG_DEPTH(20)
270
280  REM Creating eyes:
290  DIM eyes[100]
300  DIM eyes_positions_x[100]
310  DIM eyes_positions_y[100]
320  DIM eyes_positions_z[100]
330  DIM eyes_speeds[100]
340  LET i = 0
350  IF i > NUMBER_OF_EYES - 1 THEN 500
360      REM Load of eye:
370      LET eyes[i] = LOAD_OBJECT(eye_model_path)
380      LET t = 2 * PI * RND()
390      LET l = EYES_SCATTER * RND()
400      LET eyes_positions_x[i] = l * COS(t)
410      LET eyes_positions_y[i] = EYES_START_POSITION
420      LET eyes_positions_z[i] = l * SIN(t)
430      POSITION_OBJECT(eyes[i], eyes_positions_x[i], eyes_positions_y[i], eyes_positions_z[i])
440
450      REM Select of eye speed:
460      LET eyes_speeds[i] = RND() * (eyes_maximal_speed - eyes_minimal_speed) + eyes_minimal_speed
470
480      LET i = i + 1
490      GOTO 350
500
510  REM Main loop:
520  LET player_position_x = 0
530  LET player_position_z = 0
540  LET last_time = TIMER()
550  IF KEYSTATE(ESCAPE_KEY) = TRUE THEN 1290
560      REM Get delta time:
570      LET current_time = TIMER()
580      LET delta_time = current_time - last_time
590      LET last_time = current_time
600
610      REM Output FPS:
620      DIM FPS_LABEL = " fps"
630      IF delta_time = 0 THEN 670
640          PRINT(1 / delta_time)
650          PRINT(FPS_LABEL)
660          PRINT(NEW_LINE)
670
680      REM Control of player:
690      IF KEYSTATE(LEFT_KEY) = FALSE THEN 710
700          LET player_position_x = player_position_x - PLAYER_SPEED * delta_time
710      IF KEYSTATE(RIGHT_KEY) = FALSE THEN 730
720          LET player_position_x = player_position_x + PLAYER_SPEED * delta_time
730      IF KEYSTATE(DOWN_KEY) = FALSE THEN 750
740          LET player_position_z = player_position_z - PLAYER_SPEED * delta_time
750      IF KEYSTATE(UP_KEY) = FALSE THEN 770
760          LET player_position_z = player_position_z + PLAYER_SPEED * delta_time
770      POSITION_CAMERA(player_position_x, 0, player_position_z)
780
790      REM Move of eyes:
800      LET i = 0
810      IF i > NUMBER_OF_EYES - 1 THEN 930
820          LET eyes_positions_y[i] = eyes_positions_y[i] - eyes_speeds[i] * delta_time
830          IF eyes_positions_y[i] > 0 THEN 890
840              LET t = 2 * PI * RND()
850              LET l = EYES_SCATTER * RND()
860              LET eyes_positions_x[i] = player_position_x + l * COS(t)
870              LET eyes_positions_y[i] = EYES_START_POSITION
880              LET eyes_positions_z[i] = player_position_z + l * SIN(t)
890          POSITION_OBJECT(eyes[i], eyes_positions_x[i], eyes_positions_y[i], eyes_positions_z[i])
900
910          LET i = i + 1
920          GOTO 810
930
940      REM Rotate of eyes:
950      LET i = 0
960      IF i > NUMBER_OF_EYES - 1 THEN 1250
970          LET delta_x = player_position_x - eyes_positions_x[i]
980          LET delta_y = 0 - eyes_positions_y[i]
990          LET delta_z = player_position_z - eyes_positions_z[i]
1000
1010          IF eyes_positions_y[i] > EYES_START_ROTATION_POSITION THEN 1140
1020              IF delta_x = 0 THEN 1070
1030                  LET angle_z = ATN((0 - eyes_positions_y[i]) / delta_x)
1040                  IF delta_x > 0 THEN 1060
1050                      LET angle_z = angle_z - PI
1060                 GOTO 1080
1070                     LET angle_z = (0 - PI) / 2
1080             LET angle_x = ATN(delta_z / (0 - eyes_positions_y[i]))
1090             IF delta_z < 0 THEN 1120
1100                 LET angle_x = angle_x + PI
1110                 GOTO 1130
1120                     LET angle_x = angle_x - PI
1130             GOTO 1210
1140                 LET angle_x = 0
1150                 LET angle_z = PI / 2
1160
1170         LET distance = SQR(delta_x * delta_x + delta_y * delta_y + delta_z * delta_z)
1171         LET normalized_distance = distance / ABS(EYES_START_POSITION)
1172         IF normalized_distance < 1 THEN 1174
1173             LET normalized_distance = 1
1174         LET normalized_distance = 1 - normalized_distance
1180         LET maximum_nystagmus_angle = EYES_NYSTAGMUS_MAXIMUM * normalized_distance
1190         LET nystagmus_angle = RND() * 2 * maximum_nystagmus_angle - maximum_nystagmus_angle
1200
1210         ROTATION_OBJECT(eyes[i], (angle_x + nystagmus_angle) * 180 / PI, 0, 0 - (angle_z + nystagmus_angle) * 180 / PI)
1220
1230         LET i = i + 1
1240         GOTO 960
1250
1260     SYNC()
1270     GOTO 550
1280
1290 REM Dummy:
1300 RND()