UNIT Elog;

INTERFACE

Uses Crt,Dos,NetFileP,DDPlus;

VAR
 SaveExitProc: POINTER;

FUNCTION File_Exists(Filename: string ): boolean;
PROCEDURE Terminate (N:Byte);
PROCEDURE TrapExit;
PROCEDURE MyExit1;

IMPLEMENTATION   (********************************)

Procedure GetDate1(VAR Month:Word;
                   VAR day:Word;
                   VAR year:Word);
 VAR MyRegs:Registers;

 Begin
  MyRegs.AH:=$2A;
  MSDOS(MyRegs);
  Month:=MyRegs.DH;
  Day:=MyRegs.DL;
  Year:=MyRegs.CX;
 End;

FUNCTION File_Exists(Filename: string ): boolean;
{returns true if file exists}
var Inf: SearchRec;
begin
    findfirst(Filename,AnyFile,Inf);
    File_Exists := (DOSError = 0);
end;  {func Exist}

PROCEDURE Terminate (N:Byte);
 Begin
   CASE N OF
     0:SWriteln('Normal Termination');
     1:Begin SWriteln('Carrier lost'); End;
     2:Begin SWriteln('*** TIME LIMIT HAS EXPIRED ***'); End;
     3:Begin SWriteln('User Inactive for 5+ minutes'); End;
   End
 End;

{$F+}

(* This exit procedure may be used to trap HALT codes.  If defined in the
   main body of your program (DoorExit := TrapExit), this procedure will be
   called whenever your program encounters a HALT code or runtime error.

   As shown below, if ErrorAddr <> NIL (no runtime error has occurred) the
   runtime error information is displayed to the local console and is also
   written to a file called PROG_ERR.LOG.  You may wish to change the name
   of this error log file to something more fitting to your program.
   If ErrorAddr = NIL then this code assumes that no runtime error has
   occurred but rather that a HALT code has been encountered.  You could
   conceivably handle all your HALT functions within the TRAPEXIT procedure.
   However, in this demonstration, we can see that we are passing the HALT
   code onto the TERMINATE procedure which is located within your program's
   code.
*)


PROCEDURE TrapExit;

CONST

   ProductName='Thieves'' Guild';

VAR
   ErrFile    : TEXT ;
   A1: Byte;
   YE: Boolean;
   OpenAttempts: Integer;
   GoAhead:Boolean;
   Year,Month,Day: Word;

   FUNCTION Error_message(Code: Integer): STRING;
      {return message text for a given runtime error code}
   VAR
      Class:  STRING;
      Msg:    STRING;
   BEGIN
      CASE Code OF
           1.. 99: Class := 'DOS ERROR      :';
         100..149: Class := 'I/O ERROR      :';
         150..199: Class := 'CRITICAL ERROR :';
         200..249: Class := 'FATAL ERROR    :';
         ELSE      Class := 'UNKNOWN ERROR  :';
      END;

      CASE Code OF
           2: Msg := 'File not found';
           3: Msg := 'Path not found';
           4: Msg := 'Too many open files';
           5: Msg := 'File access denied';
           6: Msg := 'Bad file handle';
          12: Msg := 'Bad file access code';
          15: Msg := 'Bad drive number';
          16: Msg := 'Can''t remove current dir';
          17: Msg := 'Can''t rename across drives';

         100: Msg := 'Disk read error, read past eof on Typed File';
         101: Msg := 'Disk write error';
         102: Msg := 'File not assigned';
         103: Msg := 'File not open';
         104: Msg := 'File not open for input';
         105: Msg := 'File not open for output';
         106: Msg := 'Bad numeric format';

         150: Msg := 'Disk is write-protected';
         151: Msg := 'Unknown diskette unit';
         152: Msg := 'Drive not ready';
         153: Msg := 'Unknown command';
         154: Msg := 'CRC error in data';
         155: Msg := 'Bad drive request structure length';
         156: Msg := 'Disk seek error';
         157: Msg := 'Unknown diskette type';
         158: Msg := 'Sector not found';
         159: Msg := 'Printer out of paper';
         160: Msg := 'Device write fault';
         161: Msg := 'Device read fault';
         162: Msg := 'Hardware failure';

         200: Msg := 'Division by zero';
         201: Msg := 'Range check';
         202: Msg := 'Stack overflow';
         203: Msg := 'Heap overflow'+' (Not enough memory to run)';
         204: Msg := 'Bad pointer operation';
         205: Msg := 'Floating point overflow';
         206: Msg := 'Floating point underflow';
         207: Msg := 'Bad floating point operation';

         ELSE STR(Code,Msg);
      END;

      Error_message := Class + Msg;
   END;

   FUNCTION Exit_message(Code: Integer): STRING;
      {return message text for a given exit code}
   VAR
      Msg:    STRING;
   BEGIN
      CASE Code OF
           0: Msg := 'Normal Termination';
           1: Msg := 'Carrier Lost';
           2: Msg := 'Time Limit Exceeded';
           3: Msg := 'User Inactivity Timeout';
           4: Msg := 'Cannot Find Dorinfo1.def';
           5: Msg := 'Cannot Find ExitInfo.Bbs';
           6: Msg := 'Directory Change/Read Error';
           7: Msg := 'CTS Timeout';
           8: Msg := 'Forced Exit via RAXIT Semaphore';
           9: Msg := 'Cannot Find Door.Sys';
         ELSE STR(Code,Msg);
      END;
      Exit_Message := Msg;
   END;


   FUNCTION Itoh(W: Integer): STRING;
      {hex conversion}
   CONST
      Hex: ARRAY[0..15] OF CHAR = '0123456789ABCDEF';
   VAR
      H: STRING[4];
   BEGIN
      H[0] := CHR(4);
      H[1] := Hex[(W SHR 12) AND $0f];
      H[2] := Hex[(W SHR  8) AND $0f];
      H[3] := Hex[(W SHR  4) AND $0f];
      H[4] := Hex[W          AND $0f];
      Itoh := H;
   END;

BEGIN
   A1:=18;
   YE:=False;
   GetDate1(Month,day,year);
   IF ErrorAddr = NIL THEN
    Begin
     If ExitCode = 0 then
      Begin
       Terminate(0) ;
       Exit;
      End;

      { save player game HERE!!!! }
      if isitok = TRUE then
        saveInfo;


     if ShareInst=False then FileMode:=64;
     YE:=False;
     ASSIGN(ErrFile,'ERROR.LOG');
     IF FILE_EXISTS('ERROR.LOG') THEN
      Begin
       OpenAttempts:=1;
       Repeat
        {$I-}
        Append(ErrFile);
        {$I+}
        GoAhead:= (IOResult = 0);
        If Not GoAhead then OpenAttempts :=OpenAttempts+1;
       Until (GoAhead) or (OpenAttempts>15);
      End;
     IF NOT FILE_EXISTS('ERROR.LOG') THEN
      Begin
       OpenAttempts:=1;
       Repeat
        {$I-}
        Rewrite(ErrFile);
        {$I+}
        GoAhead:= (IOResult = 0);
        If Not GoAhead then OpenAttempts :=OpenAttempts+1;
       Until (GoAhead) or (OpenAttempts>15);
      End;
     If ProductName <> '' then
      Begin
       Writeln(ErrFile,' ');
       Writeln(ErrFile,'Error Log Generated by ',ProductName);
      End;
     WRITELN('Date : ',Month,'/',Day,'/',Year);
     WRITELN(' ');
     WRITELN('Program Termination');
     WRITELN(Exit_Message(Exitcode));
     WRITELN(ErrFile,'Date : ',Month,'/',Day,'/',Year);
     WRITELN(ErrFile,'Program Termination');
     WRITELN(ErrFile,Exit_Message(Exitcode));
     flush(ErrFile) ;
     Close(ErrFile);
     IF ShareInst=False then FileMode:=66;
     {be sure to uncomment this if using RipLink}
     {if RIP <> nil then
      Dispose(RIP, Done);}
     Terminate(ExitCode);
     Delay(1000);
     End ELSE
      BEGIN
     
     {Replace the next line with the name of YOUR save procedure}
     {This ones save my game information should something go wrong}
     {I have left it so you see what I did, although it IS commented out}
       
       {SaveGame(Player,PlayerFile,TempP,Country,CountryFile,Map1,MapFile);}
       
       ASSIGN(ErrFile,'ERROR.LOG');
       IF FILE_EXISTS('ERROR.LOG') THEN
        Begin
         OpenAttempts:=1;
         Repeat
          {$I-}
          Append(ErrFile);
          {$I+}
          GoAhead:= (IOResult = 0);
          If Not GoAhead then OpenAttempts :=OpenAttempts+1;
         Until (GoAhead) or (OpenAttempts>15);
        End;
       IF NOT FILE_EXISTS('ERROR.LOG') THEN
        Begin
         OpenAttempts:=1;
         Repeat
          {$I-}
          Rewrite(ErrFile);
          {$I+}
          GoAhead:= (IOResult = 0);
          If Not GoAhead then OpenAttempts :=OpenAttempts+1;
         Until (GoAhead) or (OpenAttempts>15);
        End;
      If ProductName <> '' then
       Begin
        Writeln(ErrFile,' ');
        Writeln(ErrFile,'Error Log Generated by ',ProductName);
       End;
       WRITELN('Date : ',Month,'/',Day,'/',Year);
       WRITELN('Run-time error occurred');
       WRITELN('Exitcode = ', exitcode);
       WRITELN(Error_Message(Exitcode));
       WRITELN('Address of error:');
       WRITELN('  Segment: ', ItoH(seg(erroraddr^)));
       WRITELN('  Offset:  ', ItoH(ofs(erroraddr^))) ;
       WRITELN(ErrFile,'Date : ',Month,'/',Day,'/',Year);
       WRITELN(ErrFile,'Run-time error occurred');
       WRITELN(ErrFile,'Exitcode = ', exitcode);
       WRITELN(ErrFile,Error_Message(Exitcode));
       WRITELN(ErrFile,'Address of error:');
       WRITELN(ErrFile,'  Segment: ', ItoH(seg(erroraddr^)));
       WRITELN(ErrFile,'  Offset:  ', ItoH(ofs(erroraddr^))) ;
       WRITELN(ErrFile,'------------------------------------------------');
       flush(ErrFile) ;
       Close(ErrFile);
       IF ShareInst=False then FileMode:=66;
      END ;
   ErrorAddr := NIL ;
   {be sure to uncomment this if using RipLink}
   {if RIP <> nil then
     Dispose(RIP, Done);}
  END;
{$F-}

{$F+} Procedure MyExit1; {$F-}
VAR SaveExitProc: POINTER;

Begin;
 TrapExit;
 SaveExitProc := Exitproc;
End;

END.

