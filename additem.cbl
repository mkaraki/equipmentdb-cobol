      ******************************************************************
      * Author: mkaraki
      * Date: 2021-10-17
      * Purpose: Equipment Management
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EQUIPMENTDB-ADD.
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
           01 STATUS-EQUIPMENT-LIST-DATA PIC X(2).
           01 QUEUE-SERIAL PIC X(10).
           01 QUEUE-STATUS PIC X(10).
           01 QUEUE-SERIAN-AND-STATUS PIC X(20).
           01 QUEUE-NAME PIC X(50).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN EXTEND EQUIPMENT-LIST-DATA.

           PERFORM UNTIL 1 = 2
               PERFORM ADD-ITEM
           END-PERFORM.

       ADD-ITEM.
      *    Read Internal Serial Code
           DISPLAY "Internal Serial (`!` to exit): ".
           ACCEPT QUEUE-SERIAL FROM CONSOLE.
           IF QUEUE-SERIAL = "!" THEN
               CLOSE EQUIPMENT-LIST-DATA
               STOP RUN
           END-IF

      *    Set Default Item Status
           MOVE "ACTIVE" TO QUEUE-STATUS.

      *    Read Device Name
           DISPLAY "Device Name: ".
           ACCEPT QUEUE-NAME FROM CONSOLE.

           STRING
               QUEUE-SERIAL DELIMITED BY SIZE
               QUEUE-STATUS DELIMITED BY SIZE
               INTO QUEUE-SERIAN-AND-STATUS
           END-STRING.

           STRING
               QUEUE-SERIAN-AND-STATUS DELIMITED BY SIZE
               QUEUE-NAME DELIMITED BY SIZE
               INTO EQUIPMENT-LIST-DATA-REC
           END-STRING.

           WRITE EQUIPMENT-LIST-DATA-REC.

           EXIT.

       END PROGRAM EQUIPMENTDB-ADD.
