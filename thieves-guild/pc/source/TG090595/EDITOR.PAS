program editor;

uses crt,dos;

  Type
   Str55=String[80];
   I=Array[1..26,1..45] of LongInt;
   S=Array[1..26,1..9] of String[40];
  Var
   USERI:I;
   USERS:S;
   THE,INFO,RANDCLOTH:String[255];
   CHOICE,DATA,THIEVES,EVENTS,SCORES,GUILD,RIDDLE,BBS,DREAM,GMMSG,AFFIRM,FORST,BSTEAL,BDATE,
   YEVENTS:Str55;
   ONETIME:Boolean;
   LDATE,PROG:longint;
   DUES,CL,CHOI:Integer;


(**** MODEM - CHARACTER INPUT *********************************************)
Function bconin(device:Integer):Integer;
  begin
    bconin := ord(readkey);
  end;
(**************************************************************************)
Function Dayz(Mo, Yr: longint): longint;
Begin
	If Mo=2 Then Begin
		If (Yr Mod 4) = 0 Then Dayz := 29 Else Dayz := 28 End
	Else
		Dayz := 30 + ((Mo + (Mo Div 8)) Mod 2)
End;
(**************************************************************************)
Function Since(Mo,Yr: longint): longint;
Begin
	If Mo=1 Then Since := 0 Else Since:=Since(Mo-1,Yr)+Dayz(Mo-1,Yr)
End;
(**************************************************************************)
Function Da_te(Yr,Mo,Dy: longint): longint;
Begin
	Da_te := (Yr*365) + (Yr Div 4) + Since(Mo,Yr) + Dy
End;
(**************************************************************************)
 Procedure MAKE_DATE;
   Var
     O,D,G:longint;
     year,mnth,dy,dayofweek : word;
   Begin
      GetDate(Year, Mnth, Dy, DayOfWeek);
      O:=dy;
      D:=mnth;
      G:=year;
     LDATE:=DA_TE(G-1900,D,O);
     If ONETIME=False then Write (D div 10,D mod 10,'/',O div 10,O mod 10,'/',G);
   End;
(******MAKE UPPER CASE*****************************************************)
  Procedure UPCASEln(var LITTLE:Str55);
    Var
      COUNT:Integer;
    Begin
      For COUNT:=1 to ord(LITTLE[0]) do
        If (ord(LITTLE[COUNT]) > 96) and (ord(LITTLE[COUNT]) < 123) then
           LITTLE[COUNT]:=chr(ord(LITTLE[COUNT])-32)
    END;
(**************************************************************************)
procedure bconout(H:Integer);
  begin
    write(chr(h));
  end;
(**************************************************************************)
function bconstat:Boolean;
  begin
    bconstat := keypressed;
  end;
(**** RANDOM GENERATOR ****************************************************)
Function DRANDOM:longint;
  begin
    drandom := random(47367);
  end;
(**************************************************************************)
  Procedure RAND_APPAREL(CPIECE:Integer);
    Var
      COLORS:Array[1..9] of String[6];
      APNAME:String[8];
      MAX:Integer;
    Begin
     COLORS[1]:='Black';COLORS[2]:='Brown';COLORS[3]:='Blue';COLORS[4]:='Black';
     COLORS[5]:='Gray';COLORS[6]:='Yellow';COLORS[7]:='Red';COLORS[8]:='Green';
     COLORS[9]:='White';
      RANDCLOTH:='Cheap ';
      If (CPIECE=1) or (CPIECE=2) then MAX:=9; {Bandana, Shirt}
      If CPIECE=3 then MAX:=5; {Pants}
      If CPIECE=4 then MAX:=2; {Sandals}
      INSERT(COLORS[(DRANDOM mod MAX)+1],RANDCLOTH,(ord(RANDCLOTH[0])+1));
      Case CPIECE of
         1:APNAME:=' Bandana';
         2:APNAME:=' Shirt';
         3:APNAME:=' Pants';
         4:APNAME:=' Sandals'
        End; {Case}
      INSERT(APNAME,RANDCLOTH,(ord(RANDCLOTH[0])+1));
     End;
(**************************************************************************)
  Function ENCNUM(KEY:Integer;PER:Integer;DO1:Boolean):Integer;
    Begin
     If DO1=True then ENCNUM:=PER+KEY;
     If DO1=False then ENCNUM:=PER-KEY;
     End;
(**************************************************************************)
 Procedure ENCRYPT(Var INFORM:Str55;DO2:Boolean);
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
      DUMB:Str55;
    Begin
      CO1:=0;CO2:=0;CO3:=0;
      For CO1:=1 to 26 do
        begin
          For CO2:=1 to 9 do Begin
           DUMB:=USERS[CO1,CO2];
           ENCRYPT(DUMB,DO3);
           USERS[CO1,CO2]:=DUMB
          end;
        end;
    End;
(**************************************************************************)
  Procedure SAVEINFO;
    Var
      N,SN,D,SD,A,B:Integer;
      TEMP:Str55;
      NAME:Text;
    Begin
      N:=0;SN:=0;D:=0;SD:=0;A:=0;B:=0;GETEMGONE(True);
      assign(name,'thieves.dat');
      rewrite(name);
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
          for a := 38 to 45 do
            begin
              writeln(name,useri[n,a]);
            end;
       Until N=26;
       Writeln(NAME,DUES);
       Writeln(NAME,DREAM);
       Writeln(NAME,PROG);
       Writeln(NAME,BSTEAL);
       Writeln(NAME,BDATE);
       If GMMSG<>'' then Writeln(NAME,GMMSG);
       close(name);
      End;

(****** GETS A RETURN FROM THE PLAYER - PAUSE *****************************)
procedure pressReturn;

  var
    ch : char;

  begin
    Writeln;
    Write('Press <RETURN> to Continue.');
    repeat ch := readkey until ch = #13;
    writeln
  end;

(**************************************************************************)
  Procedure GOODBYE(NUM:Integer);
    Var
      V,COND,CO,COUNT:Integer;
      SAVED:Boolean;
      NAMED:Str55;
    Begin
        CO:=0;
        For CO:=22 to 45 do Begin
          USERI[NUM,CO]:=0
         End;
        USERS[NUM,1]:=' ';
        USERS[NUM,1][1]:=Chr(64+NUM);
        USERI[NUM,1]:=NUM;
        USERS[NUM,2]:='EMPTY';
        USERI[NUM,2]:=0;
        USERI[NUM,3]:=25;
        USERI[NUM,4]:=250;
        USERI[NUM,5]:=0;
        USERI[NUM,6]:=24;
        USERI[NUM,7]:=0;
        USERI[NUM,8]:=0;
        USERS[NUM,3]:='EMPTY';
        RAND_APPAREL(1);USERS[NUM,4]:=RANDCLOTH;
        RAND_APPAREL(2);USERS[NUM,5]:=RANDCLOTH;
        RAND_APPAREL(3);USERS[NUM,6]:=RANDCLOTH;
        RAND_APPAREL(4);USERS[NUM,7]:=RANDCLOTH;
        USERS[NUM,9]:='NONE';
        USERS[NUM,8]:='NONE';
        USERI[NUM,14]:=1;
        USERI[NUM,15]:=3;
        USERI[NUM,9]:=5;
        USERI[NUM,10]:=25;
        USERI[NUM,11]:=25;
        USERI[NUM,12]:=25;
        USERI[NUM,13]:=0;COUNT:=0;
        For COUNT:=22 to 36 do USERI[NUM,COUNT]:=0;
        USERI[NUM,16]:=0;USERI[NUM,21]:=15;
        USERI[NUM,17]:=0;USERI[NUM,19]:=0;
        USERI[NUM,18]:=0;USERI[NUM,20]:=15;
        USERI[NUM,37]:=5000
    End;

(*****GET KEY**************************************************************)
procedure what(var well:str55);

  var
    ch : char;

  begin
    repeat
      ch := upcase(readkey);
    until ch in ['Y','N'];
    if ch='Y' then writeln ('Yes.');
    if ch='N' then writeln ('No.');
    well := ch;
  end;

(**************************************************************************)
  Procedure LOADSTUFF;
    Var
      N,SN,SD,A,B,CN:Integer;
      D:longint;
      NAME,FNAME:Text;
      FINDOUT:str55;
    Begin
      N:=0;SN:=0;D:=0;SD:=0;A:=0;B:=0;CN:=0;
      FINDOUT:='S';
      assign(name,'thieves.dat');
      {$I-}
      reset(name);
      {$I+}
      If ioresult <> 0 then Begin
       Writeln;Writeln('I could''nt find THIEVES.DAT, this program must be run from');
       Writeln('the same directory as the THIEVES.SET & THIEVES.DAT files.');
       Writeln;
       Write('Do you want to create a new THIEVES.DAT file in this directory? ');
       WHAT(FINDOUT);
       If FINDOUT='Y' then Begin
          DUES:=0;BSTEAL:='';BDATE:='';
          GMMSG:='';DREAM:='an old man with a strange amulet about his neck...';
          For CN:=1 to 26 do GOODBYE(CN);PROG:=10000;
          Writeln;Writeln('Ok, there is a THIEVES.DAT file in memory.  It will be saved');
                  Writeln('when you exit this editor with the [Q]uit command...');
         End;
      If FINDOUT='Y' then pressReturn;(*Show_Mouse*);If FINDOUT='N' then HALT
      End;
      If FINDOUT<>'Y' then Begin
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
          for a:=38 to 45 do
            begin
              readln(name,useri[n,a]);
            end;
        Until N=26;
      Readln(NAME,DUES);
      Readln(NAME,DREAM);
      Readln(NAME,PROG);
      Readln(NAME,BSTEAL);
      Readln(NAME,BDATE);
      If not eof(NAME) then Readln(NAME,GMMSG);
      GETEMGONE(False);
      close(name) ;
     End
    End;
(**** GET A CHARACTER *****************************************************)
  Procedure SOMETHING(Var WELL:Str55);
   Var
    dummy,event,what_key:integer;
    Key_Wait:Str55;
   Begin
     Key_wait[0]:=Chr(1);
     Repeat
     Until Bconstat;
     If Bconstat then what_key:=bconin(2);
     Key_wait[1]:=chr(what_key);
     WELL:=Key_Wait;
     UPCASEln(WELL)
   end;
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
      WHO:Str55;
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
     SURE:Str55;
     ONE:Text;
   Begin
    Writeln;
    Write('                    Save all changed information? [Y/N] ');
    WHAT(SURE);
    If SURE='Y' then Begin
      assign(one,'thieves.set');
      rewrite(one);
      Writeln(ONE,DATA);
      Writeln(ONE,THIEVES);
      Writeln(ONE,EVENTS);
      Writeln(ONE,YEVENTS);
      Writeln(ONE,SCORES);
      Writeln(ONE,GUILD);
      Writeln(ONE,RIDDLE);
      Writeln(ONE,BBS);
      Writeln(ONE,FORST);
      Close(ONE);
      SAVEINFO;
      clrscr;
      Writeln('If you edited your THIEVES.SET file, be sure to make a copy of');
      Writeln('it in the same directory that your BBS program is run from...');
      pressReturn;
     End;
    End;
(**************************************************************************)
 Procedure EDIT;
   Var
     WHO:Integer;
     SURE,WHICH,WELL:Str55;
  Begin
    clrscr;
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
      clrscr;
      Writeln('');
      Writeln('           Player: ',USERS[WHO,3]);
      Writeln('Password/BBS Name: ',USERS[WHO,2]);
      Writeln;
      Writeln('Last played ',LDATE-USERI[WHO,2],' day(s) ago...');
      Writeln;
      Writeln('[P]layer name change  [B]BS Name/Password Change');
      Writeln('[D]elete Player       [S]et Last Play Day to Today''s Date');
      Writeln('[Q]uit Editor...');
      Writeln;
      Write('Your Choice [ ]',CHR(8),CHR(8));
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
           pressReturn;
         End;
        End;
      If WHICH='D' then Begin
        Writeln;Write('Delete ',USERS[WHO,3],'? ');
        WHAT(SURE);
        If SURE='Y' then Begin
          GOODBYE(WHO);
          Writeln;Writeln('It is done!');
          pressReturn;
        End;
       End;
      If WHICH='B' then Begin
        WELL:='';
        Repeat
          Writeln;Writeln('Be sure to use same format as above, or TG will not recognize their BBS name.');
          Writeln;Write('Enter new Password/BBS Name: ');
          Readln(SURE);
          UPCASEln(SURE);
          Write(SURE,', Correct? ');
          WHAT(WELL);
        Until WELL='Y';
        USERS[WHO,2]:=SURE;
        Writeln;Writeln('It it done!');
        pressReturn;
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
        UPCASEln(SURE);
       Until (SURE[1]<>' ') and (SURE[ord(SURE[0])]<>' ') and (ord(SURE[0])<26) and (ord(SURE[0])>3) and
             (SURE<>'EMPTY');
          Write (SURE,', Correct [Y/N] ');
          WHAT(WELL);
        Until (WELL='Y');
        USERS[WHO,3]:=SURE;
        Writeln;Writeln('Name Changed!!');
        pressReturn;
       End;
      Until (WHICH='Q') or (USERS[WHO,3]='EMPTY');
     End;
    End;
(**************************************************************************)
 Procedure INQUIRE(WHICH:Integer);
   Var
     TEMP,SURE:Str55;
     surech : char;

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
       9:Begin Writeln('This is the PATH & FILENAME for the Yesterday Events file, this may');
               Writeln('be made available for view on your BBS.')
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
         end;
       10 : Begin Writeln('This is the PATH & FILENAME for PCBOARD 15.0''s DOOR.SYS file.');
               Writeln('This may be C:\PCB\DOOR.SYS for you.');
          End;
      End; {Case}
     Writeln;
     Write('Currently set at: ');
     Case WHICH of
       1  : writeln(DATA);
       2  : writeln(THIEVES);
       3  : writeln(EVENTS);
       4  : writeln(SCORES);
       5  : writeln(GUILD);
       6  : writeln(RIDDLE);
       7  : writeln(BBS);
       8  : writeln(FORST);
       9  : writeln(YEVENTS);
       10 : writeln(forst);
     End;
      Writeln;
     If WHICH<>7 then Begin
      Repeat
       Write('Change to? ==> ');
       Readln(TEMP);
       UPCASEln(TEMP);
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
        8:FORST:=TEMP;
        9:YEVENTS:=TEMP;
        10 : forst := temp;
       End; {Case}
       Writeln;
       Writeln('Done!');
       pressReturn;
      End;
     If WHICH=7 then Begin
       Writeln('Your BBS Software? [F]orem, [E]xpress, [P]CBoard 15.0 or ');
       write('[O]ther -> ');
       Repeat
         surech := upcase(readkey);
       Until (SUREch in ['F','E','O','P']);
       If SUREch='F' then Writeln('Forem...');
       If SUREch='E' then Writeln('Express...');
       If SUREch='P' then Writeln('PCBoard 15.0...');
       If SUREch='O' then Writeln('Other...');
       Case SUREch of
         'F':BBS:='FOREM';
         'E':BBS:='EXPRESS';
         'O':BBS:='OTHER';
         'P':BBS:='PCB150';
        End; {Case}
       Writeln;
       Writeln('Thank You!!');
       pressReturn;
      End;
    End;
(**************************************************************************)
 Procedure INIT;
  Var
   ONE:Text;
   IFER:Str55;
  Begin
    clrscr;
    Writeln('One Moment...');GMMSG:='';IFER:='';
    assign(one,'thieves.set');
    {$I-}
    reset(one);
    {$I+}
    If ioresult <> 0 then begin
     Writeln;Writeln('I could''nt find THIEVES.SET, this program must be run from');
     Writeln('the same directory as the THIEVES.SET & THIEVES.DAT files.');
     Writeln;
     Write('Would you like to just create a new THIEVES.SET? ');
     WHAT(IFER);
     If IFER='Y' then Begin
        DATA:='';THIEVES:='';EVENTS:='';YEVENTS:='';SCORES:='';
        GUILD:='';RIDDLE:='';BBS:='OTHER';FORST:=''
       End;
     (*Show_Mouse;*)If IFER='N' then HALT
    End;
    ONETIME:=True;MAKE_DATE;ONETIME:=False;
   If IFER='' then Begin
    Readln(ONE,DATA);
    Readln(ONE,THIEVES);
    Readln(ONE,EVENTS);
    Readln(ONE,YEVENTS);
    Readln(ONE,SCORES);
    Readln(ONE,GUILD);
    Readln(ONE,RIDDLE);
    Readln(ONE,BBS);
    Readln(ONE,FORST);
    UPCASEln(BBS);
    Close(ONE)
   End;
    LOADSTUFF
   End;
(**************************************************************************)

procedure first;

  var
    SURE:Str55;
    MANY:Integer;
    FNAME:Text;

  Begin
    clrscr;
    writeln('Use this option for First-Time installations only...');
    writeln;
    write('Execute "First-Time" Installation, are you sure? ');
    what(sure);
    if sure='Y' then
      begin
        INQUIRE(1);
        INQUIRE(2);
        INQUIRE(3);
        INQUIRE(9);
        INQUIRE(4);
        INQUIRE(5);
        INQUIRE(6);
        INQUIRE(7);
        If BBS='FOREM' then INQUIRE(8);
        if BBS='PCB150' then INQUIRE(10);
        For MANY:=1 to 26 do
          GOODBYE(MANY);
        assign(fname,events); rewrite(FNAME); close(FNAME);
        assign(fname,scores); rewrite(FNAME); close(FNAME);
        assign(fname,'thieves.clk'); rewrite(FNAME);
        writeln(fname,'0');
        writeln(fname,'0');
        close(fname);
        writeln;
        writeln('Be sure to exit with the [Q] option from the main menu, and save the');
        writeln('changed information!  Thieves'' Guild should run fine now, Enjoy!');
        pressReturn;
      end;
  end;

(**************************************************************************)
 Procedure D_MENU;
  Var
    SIZE,COUNT:Integer;
  Begin
    clrscr;
    Writeln('                               Thieves'' Guild');
    Writeln('                           (c) 1993 Mythyn Software');
    Writeln;
    Writeln('                /-------------------------------------------\');
    Writeln('               * [I]nitialize System (For first time set-up) *');
    Writeln('               | [C]reate new game. (Reset game in progress) |');
    Writeln('               | [M]odify/Edit a player...                   |');
    Writeln('        /------*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*------\');
    Write('       * [D]ata File Path ||',DATA);
    SIZE:=41;
    SIZE:=SIZE-Ord(DATA[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Writeln('*');
    Write('       | [T]hieves'' Path  ||',THIEVES);
    SIZE:=41;
    SIZE:=SIZE-Ord(THIEVES[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Writeln('|');
    Write('       | [E]vents File    ||',EVENTS);
    SIZE:=41;
    SIZE:=SIZE-Ord(EVENTS[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Writeln('|');
    Write('       | [Y]esterday Event||',YEVENTS);
    SIZE:=41;
    SIZE:=SIZE-Ord(YEVENTS[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Writeln('|');
    Write('       | [S]core File     ||',SCORES);
    SIZE:=41;
    SIZE:=SIZE-Ord(SCORES[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Writeln('|');
    Write('       | [G]uild Masters  ||',GUILD);
    SIZE:=41;
    SIZE:=SIZE-Ord(GUILD[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Writeln('|');
    Write('       | [R]iddle Masters ||',RIDDLE);
    SIZE:=41;
    SIZE:=SIZE-Ord(RIDDLE[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Writeln('|');
    Write('       | [B]BS Software   ||',BBS);
    SIZE:=41;
    SIZE:=SIZE-Ord(BBS[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Writeln('|');
    Write('       | [F]orem Data File||',FORST);
    SIZE:=41;
    SIZE:=SIZE-Ord(FORST[0]);
    For COUNT:=1 to SIZE do Write(' ');
    Writeln('|');
    Writeln('       |                  **=========================================*');
    Write('       * [Q]uit Editor    ||  ');
    Writeln('Changed Information is not saved until');
    Writeln('        \_________________||        you [Q]uit this program...');
    Writeln;
    Write('                              Your Choice? [ ]',chr(8),chr(8));
    Repeat
      SOMETHING(CHOICE);
    Until (CHOICE='I') or (CHOICE='C') or (CHOICE='M') or (CHOICE='D') or (CHOICE='T')
          or (CHOICE='E') or (CHOICE='S') or (CHOICE='G') or (CHOICE='R') or (CHOICE='B')
          or (CHOICE='F') or (CHOICE='Q') or (CHOICE='Y');
    Writeln(CHOICE);
   End;
(**************************************************************************)

begin
  clrscr;
  init;
  repeat
    D_MENU;
    If CHOICE='I' then FIRST;
    If CHOICE='Q' then FERSURE;
    If CHOICE='M' then EDIT;
    If CHOICE='C' then
      Begin
        Writeln;
        Write('                Reset the game in progress, are you sure? ');
        WHAT(AFFIRM);
        If AFFIRM='Y' then
          Begin
            DUES:=0;BSTEAL:='';BDATE:='';
            GMMSG:='';DREAM:='an old man with a strange amulet about his neck...';
            For CL:=1 to 26 do GOODBYE(CL);PROG:=10000;
            Writeln;Writeln('Done!  The THIEVES.DAT file has been reset, be sure to exit');
            Writeln('this program with [Q] from the main menu so it gets saved...');
          End;
        pressReturn;
      End;

    case choice[1] of
      'D' : INQUIRE(1);
      'T' : INQUIRE(2);
      'E' : INQUIRE(3);
      'S' : INQUIRE(4);
      'G' : INQUIRE(5);
      'R' : INQUIRE(6);
      'B' : INQUIRE(7);
      'F' : INQUIRE(8);
      'Y' : INQUIRE(9)
     end; {Case}

  until choice='Q';
end.
