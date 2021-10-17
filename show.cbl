      ******************************************************************
      * Author: mkaraki
      * Date: 2021-10-17
      * Purpose: Equipment Management
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EQUIPMENTDB-SHOW.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
               SELECT EQUIPMENT-LIST-DATA ASSIGN TO "equipments.data"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS STATUS-EQUIPMENT-LIST-DATA.
       DATA DIVISION.
       FILE SECTION.
           FD EQUIPMENT-LIST-DATA.
           01 EQUIPMENT-LIST-DATA-REC PIC X(70).
       WORKING-STORAGE SECTION.
           01 ITEM-COUNTER PIC 9(5).
           01 STATUS-EQUIPMENT-LIST-DATA PIC X(2).
           01 INTERNAL-SERIAL PIC X(10).
           01 ITEM-STATUS PIC X(10).
           01 PROD-NAME PIC X(50).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           MOVE SPACE TO STATUS-EQUIPMENT-LIST-DATA.
           OPEN INPUT EQUIPMENT-LIST-DATA.

           PERFORM DISPLAY-EQUIPMENTS.

           CLOSE EQUIPMENT-LIST-DATA.
           STOP RUN.

       DISPLAY-EQUIPMENTS.
           PERFORM UNTIL STATUS-EQUIPMENT-LIST-DATA NOT= "00"
               READ EQUIPMENT-LIST-DATA
                   NOT AT END
                       IF EQUIPMENT-LIST-DATA-REC(1:2) NOT = "* " THEN
                           IF ITEM-COUNTER = 0 THEN
                               PERFORM DISPLAY-HEADER-LINE
                           END-IF
                           PERFORM DISPLAY-ITEM
                       ELSE
                           DISPLAY EQUIPMENT-LIST-DATA-REC(3:68)
                       END-IF

               END-READ
           END-PERFORM.
           EXIT.

       DISPLAY-ITEM.
           MOVE EQUIPMENT-LIST-DATA-REC(1:10)
               TO INTERNAL-SERIAL
           MOVE EQUIPMENT-LIST-DATA-REC(11:10)
               TO ITEM-STATUS
           MOVE EQUIPMENT-LIST-DATA-REC(21:50)
               TO PROD-NAME
           DISPLAY
               INTERNAL-SERIAL
               " | "
               ITEM-STATUS
               " | "
               PROD-NAME
           ADD 1 TO ITEM-COUNTER
           EXIT.

       DISPLAY-HEADER-LINE.
           DISPLAY "SERIAL     | STATUS     | PRODUCT NAME"
           EXIT.

       END PROGRAM EQUIPMENTDB-SHOW.
