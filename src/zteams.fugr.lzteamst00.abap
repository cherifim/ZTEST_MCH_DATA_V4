*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTEAMS..........................................*
DATA:  BEGIN OF STATUS_ZTEAMS                        .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTEAMS                        .
CONTROLS: TCTRL_ZTEAMS
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZTEAMS                        .
TABLES: ZTEAMS                         .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
