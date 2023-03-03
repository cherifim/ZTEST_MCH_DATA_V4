*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZADDRESSES......................................*
DATA:  BEGIN OF STATUS_ZADDRESSES                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZADDRESSES                    .
CONTROLS: TCTRL_ZADDRESSES
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZADDRESSES                    .
TABLES: ZADDRESSES                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
