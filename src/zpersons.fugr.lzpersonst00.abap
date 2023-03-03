*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZPERSONS........................................*
DATA:  BEGIN OF STATUS_ZPERSONS                      .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZPERSONS                      .
CONTROLS: TCTRL_ZPERSONS
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZPERSONS                      .
TABLES: ZPERSONS                       .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
