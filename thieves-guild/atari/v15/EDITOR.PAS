Program EDITOR;
 {$I auxsubs.pas}
  Type
   Str255=String[80];
   I=Array[1..26,1..37] of Long_Integer;
   S=Array[1..26,1..9] of String[40];
  Var
   USERI:I;
   USERS:S;
   CHOICE,DATA,THIEVES,EVENTS,SCORES,GUILD,RIDDLE,BBS,DREAM,GMMSG,AFFIRM,FORST:Str255;
   LDATE,PROG:Long_Integer;
   DUES,CL:Integer;
(**** DATE GET ************************************************************)
  Function GETDATE:Integer;
    GEMDOS($2a);
(**** MODEM - CHARACTER INPUT *********************************************)
  Function bconin(device:Integer):Integer;
    BIOS(2);
(**************************************************************************)
Function Dayz(Mo, Yr: Long_Integer): Long_Integer;
Begin
	If Mo=2 Then Begin
		If (Yr Mod 4) = 0 Then Dayz := 29 Else Dayz := 28 End
	Else
		Dayz := 30 + ((Mo + (Mo Div 8)) Mod 2)
End;
(**************************************************************************)
Function Since(Mo,Yr: Long_Integer): Long_Integer;
Begin
	If Mo=1 Then Since := 0 Else Since:=Since(Mo-1,Yr)+Dayz(Mo-1,Yr)
End;
(**************************************************************************)
Function Da_te(Yr,Mo,Dy: Long_Integer): Long_Integer;
Begin
	Da_te := (Yr*365) + (Yr Div 4) + Since(Mo,Yr) + Dy
End;
(**************************************************************************)
 Procedure MAKE_DATE;
   Var
     O,D,G:Long_Integer;
   Begin
     O:=Getdate mod 32;
     D:=(Getdate mod 512) div 32;
     G:=(Getdate div 512)+1980;
     LDATE:=DA_TE(G-1900,D,O);
     Write (D div 10,D mod 10,'/',O div 10,O mod 10,'/',G);
   End;
(******MAKE UPPER CASE*****************************************************)
  Procedure UPCASE(var LITTLE:Str255);
    Var
      COUNT:Integer;
    Begin
      For COUNT:=1 to ord(LITTLE[0]) do
        If (ord(LITTLE[COUNT]) > 96) and (ord(LITTLE[COUNT]) < 123) then
           LITTLE[COUNT]:=chr(ord(LITTLE[COUNT])-32)
    END;
(**************************************************************************)
 Procedure bconout(device,H:Integer);
   BIOS(3);
(**************************************************************************)
 Function bconstat(device:Integer):Boolean;
   BIOS(1);
(**************************************************************************)
  Function ENCNUM(KEY:Integer;PER:Integer;DO1:Boolean):Integer;
    Begin
     If DO1=True then ENCNUM:=PER+KEY;
     If DO1=False then ENCNUM:=PER-KEY;
     End;
(**************************************************************************)
 Procedure ENCRYPT(Var INFORM:Str255;DO2:Boolean);
  Var
    KEY:String[80];
    COUNT,COUNT1,COUNT3:Integer;
  Begin
    KEY:='Gytwdy6666357t672^%$^&T#HujBDY%7uG@YGX&D^&*STYGHUH@IHDLS(*@++FIOS|';
    COUNT1:=Ord(KEY[0]);
    COUNT:=0;COUNT3:=0;
    Repeat
     COUNT3:=COUNT3+1;
     COUNT:=COUNT+1;
     INFORM[COUNT]:=Chr(ENCNUM(ord(KEY[COUNT3]),ord(INFORM[COUNT]),DO2));
     If COUNT3=COUNT1 then COUNT3:=0
    Until COUNT=Ord(INFORM[0]);
  End;
(**************************************************************************)
  Procedure GETEMGONE(DO3:Boolean);
    Var
      CO1,CO2,CO3:Integer;
      DUMB:Str255;
    Begin
      CO1:=0;CO2:=0;CO3:=0;
      For CO1:=1 to 26 do
        For CO2:=1 to 9 do Begin
         DUMB:=USERS[CO1,CO2];
         ENCRYPT(DUMB,DO3);
         USERS[CO1,CO2]:=DUMB
        End;
    End;
(**************************************************************************)
  Procedure SAVEINFO;
    Var
      N,SN,D,SD,A,B:Integer;
      TEMP:Str255;
      NAME:Text;
    Begin
      N:=0;SN:=0;D:=0;SD:=0;A:=0;B:=0;GETEMGONE(True);
      Rewrite (NAME,'THIEVES.DAT');
       Repeat
          N:=N+1;
          SN:=SN+1;
          D:=1;
          SD:=1;
          Writeln (NAME,USERI[N,D]);
          D:=D+1;
          For A:=1 to 2 do
           Begin
             Writeln (NAME,USERS[SN,SD]);
             SD:=SD+1
           End;
          Writeln (NAME,USERI[N,D]);
          D:=D+1;
          Writeln (NAME,USERS[SN,SD]);
          SD:=SD+1;
          A:=0;
          For A:=1 to 5 do
           Begin
             Writeln (NAME,USERI[N,D]);
             D:=D+1
           End;
          For A:=1 to 4 do
           Begin
             Writeln (NAME,USERS[SN,SD]);
             SD:=SD+1
           End;
          Writeln (NAME,USERI[N,D]);
          D:=D+1;
          A:=0;
          For A:=1 to 7 do
           Begin
             Writeln (NAME,USERI[N,D]);
             D:=D+1
           End;
          Writeln (NAME,USERS[SN,SD]);
          SD:=SD+1;
          Writeln (NAME,USERS[SN,SD]);
          SD:=SD+1;
          For A:=1 to 22 do
           Begin
             Writeln (NAME,USERI[N,D]);
             D:=D+1
            End;
       Until N=26;
       Writeln(NAME,DUES);
       Writeln(NAME,DREAM);
       Writeln(NAME,PROG);
       If GMMSG<>'' then Writeln(NAME,GMMSG)
      End;
(****** GETS A RETURN FROM THE PLAYER - PAUSE *****************************)
  Procedure STOP;
    Var
      QUICK:Integer;
    Begin
      Writeln;
      Write('Press ',Chr(27),'c1<RETURN>',Chr(27),'c4 to Continue.');
      Repeat
        Repeat
        Until bconstat(2);
        If bconstat(2) then QUICK:=bconin(2)
      Until QUICK=13;
      Writeln
    End;
(**************************************************************************)
  Procedure LOADSTUFF;
    Var
      N,SN,SD,A,B,Y:Integer;
      D:Long_Integer;
      NAME,FNAME:Text;
    Begin
      N:=0;SN:=0;D:=0;SD:=0;A:=0;B:=0;Y:=0;
      IO_CHECK(False);
      Reset (NAME,'THIEVES.DAT');
      Y:=IO_Result;
      If (Y=-33) or (Y=-34) then Begin
       Writeln;Writeln('I could''nt find THIEVES.DAT, this program must be run from');
       Writeln('the same directory as the THIEVES.SET & THIEVES.DAT files.');
       STOP;HALT
      End;
      IO_CHECK(True);
       Repeat
          N:=N+1;
          SN:=SN+1;
          D:=1;
          SD:=1;
          Readln (NAME,USERI[N,D]);
          D:=D+1;
          For A:=1 to 2 do
           Begin
             Readln (NAME,USERS[SN,SD]);
             SD:=SD+1
           End;
          Readln (NAME,USERI[N,D]);
          D:=D+1;
          Readln (NAME,USERS[SN,SD]);
          SD:=SD+1;
          A:=0;
          For A:=1 to 5 do
           Begin
             Readln (NAME,USERI[N,D]);
             D:=D+1
           End;
          For A:=1 to 4 do
           Begin
             Readln (NAME,USERS[SN,SD]);
             SD:=SD+1
           End;
             Readln (NAME,USERI[N,D]);
             D:=D+1;
          A:=0;
          For A:=1 to 7 do
           Begin
             Readln (NAME,USERI[N,D]);
             D:=D+1
           End;
             Readln (NAME,USERS[SN,SD]);
             SD:=SD+1;
             Readln (NAME,USERS[SN,SD]);
             SD:=SD+1;
          A:=0;
          For A:=1 to 22 do
            Begin
             Readln (NAME,USERI[N,D]);
             D:=D+1
            End;
        Until N=26;
      Readln(NAME,DUES);
      Readln(NAME,DREAM);
      Readln(NAME,PROG);
      If not eof(NAME) then Readln(NAME,GMMSG);
      GETEMGONE(False)
    End;
(**************************************************************************)
  Procedure GOODBYE(NUM:Integer);
    Var
      V,COND,CO,COUNT:Integer;
      SAVED:Boolean;
      NAMED:Str255;
    Begin
        CO:=0;
        For CO:=22 to 37 do Begin
          USERI[NUM,CO]:=0
         End;
        USERS[NUM,2]:='EMPTY';
        USERI[NUM,2]:=0;
        USERI[NUM,3]:=25;
        USERI[NUM,4]:=250;
        USERI[NUM,5]:=0;
        USERI[NUM,6]:=24;
        USERI[NUM,7]:=0;
        USERI[NUM,8]:=0;
        USERS[NUM,3]:='EMPTY';
        USERS[NUM,4]:='Cheap Brown Hat';
        USERS[NUM,5]:='Cheap Brown Shirt';
        USERS[NUM,6]:='Cheap Brown Pants';
        USERS[NUM,7]:='Cheap Brown Sandals';
        USERS[NUM,9]:='NONE';
        USERS[NUM,8]:='NONE';
        USERI[NUM,14]:=1;
        USERI[NUM,15]:=3;
        USERI[NUM,9]:=5;
        USERI[NUM,10]:=25;
        USERI[NUM,11]:=25;
        USERI[NUM,12]:=25;
        USERI[NUM,13]:=0;
        For COUNT:=22 to 36 do USERI[NUM,COUNT]:=0;
        USERI[NUM,16]:=0;USERI[NUM,21]:=15;
        USERI[NUM,17]:=0;USERI[NUM,19]:=0;
        USERI[NUM,18]:=0;USERI[NUM,20]:=15;
        USERI[NUM,37]:=5000
    End;
(**** GET A CHARACTER *****************************************************)
  Procedure SOMETHING(Var WELL:Str255);
   Var
    dummy,event,what_key:integer;
    Key_Wait:Str255;
   Begin
     Key_wait[0]:=Chr(1);
     Repeat
     Until Bconstat(2);
     If Bconstat(2) then what_key:=bconin(2);
     Key_wait[1]:=chr(what_key);
     WELL:=Key_Wait;
     UPCASE(WELL)
   end;
(*****GET KEY**************************************************************)
  Procedure WHAT(Var WELL:Str255);
   Var
    dummy,event,what_key:integer;
    Key_Wait:Str255;
   Begin
   Repeat
     Key_wait[0]:=Chr(1);
     Repeat
     Until Bconstat(2);
     If Bconstat(2) then what_Key:=bconin(2);
     Key_wait[1]:=chr(what_key);
      WELL:=Key_Wait;
      UPCASE(WELL);
      If WELL='Y' then Writeln (Chr(27),'b2Yes.',Chr(27),'b3');
      If WELL='N' then Writeln (Chr(27),'b1No.',Chr(27),'b3');
    Until(WELL='Y') or (WELL='N')
   End;
(**************************************************************************)
  Procedure DISPLAY;
    Var
      A,B:Integer;
    Begin
     Writeln('');
     Writeln ('          ++ List of Guild Members ++');
     Writeln('');
     Writeln ('#  Name                       Skill  Faith  Score');
     Writeln ('--------------------------------------------------');
     A:=0;B:=0;
      Repeat
        A:=A+1;
        If USERS[A,3] <> 'EMPTY' then
         Begin
           Write (USERS[A,1]);
           Write('  ');
           Write(USERS[A,3]);
           For B:=1 to (28-(ord(USERS[A,3][0]))) do
             Write (' ');
           Write(USERI[A,3]);
           If USERI[A,3] < 1000 then Write (' ');
           If USERI[A,3] < 100 then Write (' ');
           If USERI[A,3] < 10 then Write (' ');
           Write('   ');
           If USERI[A,19]=0 then Write('   ');
           If USERI[A,19]=5 then Write('[B]');
           If USERI[A,19]=11 then Write('[C]');
           If USERI[A,19]=21 then Write('[S]');
           Write('   ');
           Write(USERI[A,5]);Writeln('')
         End;
      Until A=26;
    End;
(**************************************************************************)
  Procedure ASK(Var WHATSUP:Integer);
    Var
      WHO:Str255;
    Begin
      SOMETHING(WHO);
      WHATSUP:=ord(WHO[1])-64;
      If (WHATSUP > 0) and (WHATSUP < 27) then
      If USERS[WHATSUP,3] <> 'EMPTY' then
           Writeln (USERS[WHATSUP,3])
      Else Begin
        If ord(WHO[1])=13 then Begin
          WHATSUP:=-1;
          Writeln ('NOBODY')
       End;
        If (ord(WHO[1]) <> 13) and (WHO <> '?') then Begin
          Writeln ('Thief does not exist!');
          WHATSUP:=0
        End
      End
     Else Begin
        If ord(WHO[1])=13 then Begin
          WHATSUP:=-1;
          Writeln ('NOBODY')
       End;
        If (ord(WHO[1]) <> 13) and (WHO <> '?') then Begin
          Writeln ('Thief does not exist!');
          WHATSUP:=0
         End
      End;
    If WHO='?' then Begin
      Writeln ('LIST THIEVES.');
      WHATSUP:=-2;
      DISPLAY;
     End
    End;
(**************************************************************************)
 Procedure FERSURE;
   Var
     SURE:Str255;
     ONE:Text;
   Begin
    Writeln;
    Write('                    Save all changed information? [Y/N] ');
    WHAT(SURE);
    If SURE='Y' then Begin
      Rewrite(ONE,'THIEVES.SET');
      Writeln(ONE,DATA);
      Writeln(ONE,THIEVES);
      Writeln(ONE,EVENTS);
      Writeln(ONE,SCORES);
      Writeln(ONE,GUILD);
      Writeln(ONE,RIDDLE);
      Writeln(ONE,BBS);
      Writeln(ONE,FORST);
      Close(ONE);
      SAVEINFO;
      Write(Chr(27),'E');
      Writeln('If you edited your THIEVES.SET file, be sure to make a copy of');
      Writeln('it in the same directory that your BBS program is run from...');
      STOP;
     End;
    End;
(**************************************************************************)
 Procedure EDIT;
   Var
     WHO:Integer;
     SURE,WHICH,WELL:Str255;
   Begin
    Write(Chr(27),'E');
    Repeat
     SURE:='';
     Writeln;Write('Edit/Modify/Delete who? [?=List] [Return Aborts]: ');
     ASK(WHO);
     If WHO>0 then Begin
      Write(USERS[WHO,3],' [Y/N]? ');
      WHAT(SURE)
     End;
    Until (WHO=-1) or (SURE='Y');
    If WHO>0 then Begin
     Repeat
      Write(Chr(27),'E');
      Writeln('');
      Writeln('           Player: ',Chr(27),'b1',USERS[WHO,3],Chr(27),'b3');
      Writeln('Password/BBS Name: ',Chr(27),'b1',USERS[WHO,2],Chr(27),'b3');
      Writeln;
      Writeln('[',Chr(27),'b1P',Chr(27),'b3]layer name change  [',Chr(27),'b1B',Chr(27),'b3]BS Name/Password Change');
      Writeln('[',Chr(27),'b1D',Chr(27),'b3]elete Player       [',Chr(27),'b1S',Chr(27),'b3]et Last Play Day to Today''s Date');
      Writeln('[',Chr(27),'b1Q',Chr(27),'b3]uit Editor...');
      Writeln;
      Write('Your Choice [',Chr(27),'j ]',Chr(27),'k');
      Repeat
        SOMETHING(WHICH);
      Until (WHICH='P') or (WHICH='B') or (WHICH='D') or (WHICH='S') or (WHICH='Q');
      Writeln(WHICH);
      If WHICH='S' then Begin
         Writeln;Write('Set player''s last play day to ');
         MAKE_DATE;
         Write(' ? ');
         WHAT(SURE);
         If SURE='Y' then Begin
           USERI[WHO,2]:=LDATE;
           Writeln;Writeln('Last play day reset!');
           STOP
         End;
        End;
      If WHICH='D' then Begin
        Writeln;Write('Delete ',USERS[WHO,3],'? ');
        WHAT(SURE);
        If SURE='Y' then Begin
          GOODBYE(WHO);
          Writeln;Writeln('It is done!');
          STOP
        End;
       End;
      If WHICH='B' then Begin
        WELL:='';
        Repeat
          Writeln;Writeln('Be sure to use same format as above, or TG will not recognize their BBS name.');
          Writeln;Write('Enter new Password/BBS Name: ');
          Readln(SURE);
          UPCASE(SURE);
          Write(SURE,', Correct? ');
          WHAT(WELL);
        Until WELL='Y';
        USERS[WHO,2]:=SURE;
        Writeln;Writeln('It it done!');
        STOP
       End;
      If WHICH='P' then Begin
       WELL:='';
      Repeat
       Repeat
        Writeln;Write('Enter Player''s New Name: ');
        Readln(SURE);
        If ord(SURE[0])>25 then Writeln ('25 Char. Maximum Please...');
        If SURE[ord(SURE[0])]=' ' then Writeln ('A blank space at the end of a name is not allowed.');
        If SURE[1]=' ' then Writeln ('A blank space at the beginning of a name is not allowed.');
        If ord(SURE[0])<4 then Writeln ('4 Char. Minimum Please...');
        UPCASE(SURE);
       Until (SURE[1]<>' ') and (SURE[ord(SURE[0])]<>' ') and (ord(SURE[0])<26) and (ord(SURE[0])>3) and
             (SURE<>'EMPTY');
          Write (SURE,', Correct [Y/N] ');
          WHAT(WELL);
        Until (WELL='Y');
        USERS[WHO,3]:=SURE;
        Writeln;Writeln('Name Changed!!');
        STOP
       End;
      Until (WHICH='Q') or (USERS[WHO,3]='EMPTY');
     End;
    End;
(**************************************************************************)
 Procedure INQUIRE(WHICH:Integer);
   Var
     TEMP,SURE:Str255;
   Begin
     If WHICH<>7 then Writeln;
     Case WHICH of
       1:Begin Writeln('Thieves''s Guild creates a file for each player''s events.');
               Writeln('This is the PATH/FOLDER where they will be stored.')
          End;
       2:Begin Writeln('This is the PATH/FOLDER where ALL of the Thieves''s Guild files will be');
               Writeln('placed besides the events files in the DATA path...')
          End;
       3:Begin Writeln('This is the PATH & FILENAME for the EVENTS file, you will want to make');
               Writeln('this file available to the users to view on your BBS.');
          End;
       4:Begin Writeln('This is the PATH & FILENAME for the SCORE LIST file, you will want to make');
               Writeln('this file accessable for the users to view on your BBS.');
          End;
       5:Begin Writeln('This is the PATH & FILENAME for the GUILDMASTERS list, the players that had');
               Writeln('the highest score for each month.  You will also want to make this file view');
               Writeln('able by the users...');
          End;
       6:Begin Writeln('This is the PATH & FILENAME for the RIDDLEMASTERS list, the players that have');
               Writeln('completed Thieves''s Guild''s final quest.  This file should also be accessable');
               Writeln('to the users for viewing.');
          End;
       8:Begin Writeln('This is the PATH & FILENAME for Forem''s DORINFO1.DEF file, if you are not');
               Writeln('using Forem then it doesn''t matter what you have this set to, as long as');
               Writeln('something is here...');
          End;
      End; {Case}
     Writeln;
     Write('Currently set at: ');
     Case WHICH of
       1:Writeln(DATA);
       2:Writeln(THIEVES);
       3:Writeln(EVENTS);
       4:Writeln(SCORES);
       5:Writeln(GUILD);
       6:Writeln(RIDDLE);
       7:Writeln(BBS);
       8:Writeln(FORST)
      End;
      Writeln;
     If WHICH<>7 then Begin
      Repeat
       Write('Change to? ==> ');
       Readln(TEMP);
       UPCASE(TEMP);
       Writeln;Write(TEMP,' Correct? ');
       WHAT(SURE);
      Until SURE='Y';
      Case WHICH of
        1:DATA:=TEMP;
        2:THIEVES:=TEMP;
        3:EVENTS:=TEMP;
        4:SCORES:=TEMP;
        5:GUILD:=TEMP;
        6:RIDDLE:=TEMP;
        8:FORST:=TEMP
       End; {Case}
       Writeln;Writeln('Done!');STOP
      End;
     If WHICH=7 then Begin
       Write('Your BBS Software? [F]orem, [E]xpress, or [O]ther -> ');
       Repeat
         SOMETHING(SURE)
       Until (SURE='F') or (SURE='E') or (SURE='O');
       If SURE='F' then Writeln('Forem...');
       If SURE='E' then Writeln('Express...');
       If SURE='O' then Writeln('Other...');
       Case SURE[1] of
         'F':BBS:='FOREM';
         'E':BBS:='EXPRESS';
         'O':BBS:='OTHER'
        End; {Case}
       Writeln;Writeln('Thank You!!');STOP
       End;
    End;
(**************************************************************************)
 Procedure INIT;
  Var
   A:Integer;
   ONE:Text;
  Begin
    Writeln(Chr(27),'EOne Moment...');GMMSG:='';
    IO_CHECK(False);
    Reset (ONE,'THIEVES.SET');
    A:=IO_Result;
    If (A=-33) or (A=-34) then Begin
     Writeln;Writeln('I could''nt find THIEVES.SET, this program must be run from');
     Writeln('the same directory as the THIEVES.SET & THIEVES.DAT files.');
     STOP;HALT
    End;
    IO_CHECK(True);
    Readln(ONE,DATA);
    Readln(ONE,THIEVES);
    Readln(ONE,EVENTS);
    Readln(ONE,SCORES);
    Readln(ONE,GUILD);
    Readln(ONE,RIDDLE);
    Readln(ONE,BBS);
    Readln(ONE,FORST);
    UPCASE(BBS);
    Close(ONE);
    LOADSTUFF
   End;
(**************************************************************************)
 Procedure FIRST;
   Var
     SURE:Str255;
     MANY:Integer;
     FNAME:Text;
   Begin
    Writeln(Chr(27),'E');
    Writeln('Use this option for First-Time installations only...');
    Writeln;Write('Execute "First-Time" Installation, are you sure? ');
    WHAT(SURE);
    If SURE='Y' then Begin
      INQUIRE(1);
      INQUIRE(2);
      INQUIRE(3);
      INQUIRE(4);
      INQUIRE(5);
      INQUIRE(6);
      INQUIRE(7);
      If BBS='FOREM' then INQUIRE(8);
      For MANY:=1 to 26 do GOODBYE(MANY);
      Rewrite(FNAME,EVENTS);Close(FNAME);
      Rewrite(FNAME,SCORES);Close(FNAME);
      Rewrite(FNAME,'THIEVES.CLK');
      Writeln(FNAME,'0');
      Writeln(FNAME,'0');
      Close(FNAME);
      Writeln;
      Writeln('Be sure to exit with the [Q] option from the main menu, and save the');
      Writeln('changed information!  Thieves'' Guild should run fine now, Enjoy!');
      STOP
     End;
    End;
(**************************************************************************)
 Procedure D_MENU;
  Var
    SIZE,COUNT:Integer;
  Begin
    Writeln(Chr(27),'E');
    Write('                               ');
    Write(Chr(27),'b4',Chr(27),'c1T',Chr(27),'c3h',Chr(27),'c1i',Chr(27),'c3e',Chr(27),'c1v');
    Write(Chr(27),'c3e',Chr(27),'c1s',Chr(27),'c3''',Chr(27),'c1 ',Chr(27),'c3G',Chr(27),'c1u');
    Writeln(Chr(27),'c3i',Chr(27),'c1l',Chr(27),'c3d',Chr(27),'c4',Chr(27),'b3');
    Write('                           ');
    Writeln(Chr(27),'c3',Chr(27),'b2',Chr(189),' 1991 Mythyn Software',Chr(27),'b3',Chr(27),'c4');
    Writeln;
    Writeln('                /-------------------------------------------\');
    Writeln('               * [',Chr(27),'b1I',Chr(27),'b3]nitialize System (For first time set-up) *');
    Writeln('               | [',Chr(27),'b1C',Chr(27),'b3]reate new game. (Reset game in progress) |');
    Writeln('               | [',Chr(27),'b1M',Chr(27),'b3]odify/Edit a player...                   |');
    Writeln('        /------*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*------\');
    Write('       * [',Chr(27),'b1D',Chr(27),'b3]ata File Path ||',Chr(27),'c3',Chr(27),'b1',DATA);
    SIZE:=41;
    SIZE:=SIZE-Ord(DATA[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Write(Chr(27),'c4',Chr(27),'b3');
    Writeln('*');
    Write('       | [',Chr(27),'b1T',Chr(27),'b3]hieves'' Path  ||',Chr(27),'c3',Chr(27),'b1',THIEVES);
    SIZE:=41;
    SIZE:=SIZE-Ord(THIEVES[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Write(Chr(27),'c4',Chr(27),'b3');
    Writeln('|');
    Write('       | [',Chr(27),'b1E',Chr(27),'b3]vents File    ||',Chr(27),'c3',Chr(27),'b1',EVENTS);
    SIZE:=41;
    SIZE:=SIZE-Ord(EVENTS[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Write(Chr(27),'c4',Chr(27),'b3');
    Writeln('|');
    Write('       | [',Chr(27),'b1S',Chr(27),'b3]core File     ||',Chr(27),'c3',Chr(27),'b1',SCORES);
    SIZE:=41;
    SIZE:=SIZE-Ord(SCORES[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Write(Chr(27),'c4',Chr(27),'b3');
    Writeln('|');
    Write('       | [',Chr(27),'b1G',Chr(27),'b3]uild Masters  ||',Chr(27),'c3',Chr(27),'b1',GUILD);
    SIZE:=41;
    SIZE:=SIZE-Ord(GUILD[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Write(Chr(27),'c4',Chr(27),'b3');
    Writeln('|');
    Write('       | [',Chr(27),'b1R',Chr(27),'b3]iddle Masters ||',Chr(27),'c3',Chr(27),'b1',RIDDLE);
    SIZE:=41;
    SIZE:=SIZE-Ord(RIDDLE[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Write(Chr(27),'c4',Chr(27),'b3');
    Writeln('|');
    Write('       | [',Chr(27),'b1B',Chr(27),'b3]BS Software   ||',Chr(27),'c3',Chr(27),'b1',BBS);
    SIZE:=41;
    SIZE:=SIZE-Ord(BBS[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Write(Chr(27),'c4',Chr(27),'b3');
    Writeln('|');
    Write('       | [',Chr(27),'b1F',Chr(27),'b3]orem Data File||',Chr(27),'c3',Chr(27),'b1',FORST);
    SIZE:=41;
    SIZE:=SIZE-Ord(FORST[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Write(Chr(27),'c4',Chr(27),'b3');
    Writeln('|');
    Writeln('       |                  **=========================================*');
    Write('       * [',Chr(27),'b1Q',Chr(27),'b3]uit Editor    ||  ');
    Writeln(Chr(27),'b2Changed Information is not saved until',Chr(27),'b3');
    Writeln('        \_________________||        ',Chr(27),'b2you [Q]uit this program...',Chr(27),'b3');
    Writeln;
    Write('                              Your Choice? [');
    Write(Chr(27),'j ]',Chr(27),'k');
    Repeat
      SOMETHING(CHOICE);
    Until (CHOICE='I') or (CHOICE='C') or (CHOICE='M') or (CHOICE='D') or (CHOICE='T')
          or (CHOICE='E') or (CHOICE='S') or (CHOICE='G') or (CHOICE='R') or (CHOICE='B')
          or (CHOICE='F') or (CHOICE='Q');
    Writeln(CHOICE);
   End;
(**************************************************************************)
  Begin
    INIT;
   Repeat
    D_MENU;
    If CHOICE='I' then FIRST;
    If CHOICE='Q' then FERSURE;
    If CHOICE='M' then EDIT;
    If CHOICE='C' then Begin
     Writeln;
     Write('                Reset the game in progress, are you sure? ');
     WHAT(AFFIRM);
     If AFFIRM='Y' then Begin
       DUES:=0;
       GMMSG:='';DREAM:='an old man with a strange amulet about his neck...';
       For CL:=1 to 26 do GOODBYE(CL);PROG:=10000;
       Writeln;Writeln('Done!  The THIEVES.DAT file has been reset, be sure to exit');
       Writeln('this program with [Q] from the main menu so it gets saved...');
       End;
      STOP;
     End;
    Case CHOICE[1] of
      'D':INQUIRE(1);
      'T':INQUIRE(2);
      'E':INQUIRE(3);
      'S':INQUIRE(4);
      'G':INQUIRE(5);
      'R':INQUIRE(6);
      'B':INQUIRE(7);
      'F':INQUIRE(8)
     End; {Case}
   Until CHOICE='Q';
    Writeln(Chr(27),'c4',Chr(27),'b3')
   End.

