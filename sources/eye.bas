10  DIM eye_model_path = "data/eye.ao"
20  LET ESCAPE_KEY = 1
30  LET TRUE = 1
40
50  LET eye = LOAD_OBJECT(eye_model_path)
60  POSITION_OBJECT(eye, 0, 5, 0)
70
80  REM Main loop:
90  IF KEYSTATE(ESCAPE_KEY) = TRUE THEN 130
100     SYNC()
110     GOTO 90
120
130 REM Dummy:
140 RND()
