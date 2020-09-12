{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V-,X+,Y+}
{$M 16384,0,655360}
program thieves_Editor;

uses dos, crt, tpprocs;

  type
    str80 = string[80];
    str55 = string[80];
    tUserI = array[1..26,1..45] of longint;
    tUserS = array[1..26,1..9] of string[40];

  var
    dataPath : str80;
    thievesPath : str80;
    eventsFile : str80;
    yEventsFile : str80;
    scoresFile : str80;
    mastersFile : str80;
    riddlesFile : str80;

    useri : tUserI;
    users : tUserS;
    THE,INFO,RANDCLOTH:String[255];
    CHOICE,GUILD,RIDDLE,BBS,DREAM,GMMSG,AFFIRM,FORST,BSTEAL,BDATE :Str55;
    ONETIME:Boolean;
    LDATE,PROG:longint;
    DUES,CL,CHOI:Integer;

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

function drandom : longint;

  begin
    drandom := random(47367);
  end;


Procedure UPCASEln(var LITTLE:Str55);
  Var
      COUNT:Integer;
  Begin
      For COUNT:=1 to ord(LITTLE[0]) do
        If (ord(LITTLE[COUNT]) > 96) and (ord(LITTLE[COUNT]) < 123) then
           LITTLE[COUNT]:=chr(ord(LITTLE[COUNT])-32)
  END;

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

function ENCNUM(KEY:Integer;PER:Integer;DO1:Boolean):Integer;

  begin
     If DO1=True then ENCNUM:=PER+KEY;
     If DO1=False then ENCNUM:=PER-KEY;
  end;


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

procedure pressReturn;

  var
    ch : char;

  begin
    writeln;
    write('Press <RETURN> to Continue.');
    repeat ch := readkey until ch = #13;
    writeln;
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

procedure what(var ch : char);

  begin
    repeat
      ch := upcase(readkey);
    until ch in ['Y','N'];
    if ch='Y' then writeln ('Yes.');
    if ch='N' then writeln ('No.');
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

procedure ASK(Var WHATSUP:Integer);

  Var
    WHO:Str55;

  Begin
    who := upcase(readkey);
    WHATSUP:= ord(WHO[1])-ord('A') + 1;
    If (who[1] in ['A'..'Z']) then
      If USERS[WHATSUP,3] <> 'EMPTY' then
        Writeln (USERS[WHATSUP,3])
      Else
        Begin
          If ord(WHO[1])=13 then
            Begin
              WHATSUP:=-1;
              Writeln ('NOBODY')
            End;
          If (ord(WHO[1]) <> 13) and (WHO <> '?') then
            Begin
              Writeln ('Thief does not exist!');
              WHATSUP:=0
            End
        End
    Else
      Begin
        If ord(WHO[1])=13 then
          Begin
            WHATSUP:=-1;
            Writeln ('NOBODY')
          End;
        If (ord(WHO[1]) <> 13) and (WHO <> '?') then
          Begin
            Writeln ('Thief does not exist!');
            WHATSUP:=0
          End
      End;
    If WHO = '?' then
      Begin
        Writeln ('LIST THIEVES.');
        WHATSUP:=-2;
        DISPLAY;
      end;
  end;


(**************************************************************************)

procedure readFileLine(var ff : text; var line : str80);

  begin
    {$I-}
    readln(ff,line);
    {$I+}
    if ioresult <> 0 then
      begin
        {$I-}
        close(ff);
        {$I+}
        if ioresult = 0 then ;
        writeln;
        writeln('Error reading THIEVES.SET');
        writeln;
        halt(1);
      end;
  end;


procedure initializeData;

  var
    i : integer;

  begin
    for i := 1 to 26 do
      goodbye(i);
    dues := 0;
    bsteal := '';
    bdate := '';
    gmmsg := '';
    prog := 10000;
    dream := 'an old man with a strange amulet about his neck...';
  end;



procedure loadData;

  Var
      N,SN,SD,A,B,CN:Integer;
      D:longint;
      NAME,FNAME:Text;
      ch : char;

  begin
    n:=0; sn:=0; d:=0; sd:=0; a:=0; b:=0; cn:=0;
    ch := 's';
    assign(name,'thieves.dat');
    {$I-}
    reset(name);
    {$I+}
    if ioresult <> 0 then
      begin
        writeln;
        writeln('I couldn''t find THIEVES.DAT, this program must be run from');
        writeln('the same directory as the THIEVES.SET & THIEVES.DAT files.');
        writeln;
        write('Do you want to create a new THIEVES.DAT file in this directory? ');
        what(ch);
        if ch = 'Y' then
          begin
            initializeData;
            writeln;
            writeln('Ok, there is a THIEVES.DAT file in memory.  It will be saved');
            writeln('when you exit this editor with the [Q]uit command...');
            pressReturn;
          end
        else
          begin
            halt(2);
          end;
      end;
    if ch <> 'Y' then
      begin
        repeat
          N:=N+1;
          SN:=SN+1;
          D:=1;
          SD:=1;
          Readln (NAME,USERI[N,D]);
          D:=D+1;
          For A:=1 to 2 do
            begin
              Readln (NAME,USERS[SN,SD]);
              SD:=SD+1
            end;
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
      end;
  end;


procedure saveData;

  var
    N,SN,D,SD,A,B:Integer;
    TEMP:Str55;
    NAME:Text;

  begin
    N:=0;SN:=0;D:=0;SD:=0;A:=0;B:=0;
    GETEMGONE(True);
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
  end;


procedure getSetDefaults;

  begin
    dataPath := 'DATA\';
    thievesPath := '';
    eventsFile := 'EVENTS.TXT';
    yEventsFile := 'YEVENTS.TXT';
    scoresFile := 'SCORES.TXT';
    mastersFile := 'MASTERS.TXT';
    riddlesFile := 'RIDDLES.TXT';
  end;


procedure loadSettings;

  var
    ff : text;
    ch : char;

  begin
    assign(ff,'thieves.set');
    {$I-}
    reset(ff);
    {$I+}
    if ioresult <> 0 then
      begin
        clrscr;
        writeln;
        writeln;
        textcolor(cyan);
        write('No THIEVES.SET file found... Shall I create the defaults? ');
        repeat ch := upcase(readkey) until ch in ['Y','N'];
        if ch = 'N' then
          begin
            textcolor(red);
            writeln('Nay.');
            writeln;
            textcolor(lightgray);
            halt(0);
          end;

        getSetDefaults;
        writeln;
        writeln('Note:  You must exit with ''Q'' to save settings...');
        writeln;
        writeln('Press any key to continue.');
        readkey;
      end
    else
      begin
        readFileLine(ff,dataPath);
        readFileLine(ff,thievesPath);
        readFileLine(ff,eventsFile);
        readFileLine(ff,yEventsFile);
        readFileLine(ff,scoresFile);
        readFileLine(ff,mastersFile);
        readFileLine(ff,riddlesFile);
        close(ff);
      end;
  end;


procedure resetGame;

  var
    affirm : char;

  begin
    writeln;
    write('                Reset the game in progress, are you sure? ');
    what(affirm);
    if affirm='Y' then
      begin
        dues := 0;
        bsteal := '';
        bdate := '';
        gmmsg := '';
        dream := 'an old man with a strange amulet about his neck...';
        for cl := 1 to 26 do
          goodbye(cl);
        prog := 10000;
        writeln;
        writeln('Done!  The THIEVES.DAT file has been reset, be sure to exit');
        writeln('this program with [Q] from the main menu so it gets saved...');
      end;
    pressReturn;
  end;




procedure getDataFile;

  var
    ch : integer;

  begin
    gotoxy(1,15);
    textcolor(cyan);
    write('Enter data path: ');
    getStr(dataPath, 15,18,40,'',TRUE, white, blue, ch);
    if dataPath[length(dataPath)] <> '\' then dataPath := dataPath + '\';
  end;

procedure getThievesPath;

  var
    ch : integer;

  begin
    gotoxy(1,15);
    textcolor(cyan);
    write('Enter data path: ');
    getStr(thievesPath, 15,18,40,'',TRUE, white, blue, ch);
    if thievesPath[length(thievesPath)] <> '\' then thievesPath := thievesPath + '\';
  end;


procedure getTextFiles;

  var
    ch : integer;

  begin

    writeln('Enter the following files are miscelleneous text files created by Thieves''s');
    writeln('Guild.  You may want to make these files viewable on your BBS.');
    gotoxy(1,17);
    textcolor(cyan);
    textbackground(black);
    write('Enter events file:');
    getStr(eventsFile,17,30,40,'',TRUE,white,blue,ch);

    gotoxy(1,18);
    textcolor(cyan);
    textbackground(black);
    write('Enter yesterday Events file:');
    getStr(yEventsFile,18,30,40,'',TRUE,white,blue,ch);

    gotoxy(1,19);
    textcolor(cyan);
    textbackground(black);
    write('Enter scores file:');
    getStr(scoresFile,19,30,40,'',TRUE,white,blue,ch);

    gotoxy(1,20);
    textcolor(cyan);
    textbackground(black);
    write('Enter Riddles Masters file:');
    getStr(riddlesFile,20,30,40,'',TRUE,white,blue,ch);

    gotoxy(1,21);
    textcolor(cyan);
    textbackground(black);
    write('Enter Guild Masters file:');
    getStr(mastersFile,21,30,40,'',TRUE,white,blue,ch);

  end;

procedure displayTextFiles;

  var
    ch : integer;

  begin
    writeln;
    writeln('The following files are miscelleneous text files created by Thieves''');
    writeln('Guild.  You may want to make these files viewable on your BBS.');
    writeln('Press ESC to commit changes, Return or Arrow to change fields.');
    gotoxy(1,20);
    textcolor(cyan);
    textbackground(black);
    write('Enter events file:');
    getStr(eventsFile,20,30,40,'',FALSE,white,blue,ch);

    gotoxy(1,21);
    textcolor(cyan);
    textbackground(black);
    write('Enter yesterday Events file:');
    getStr(yEventsFile,21,30,40,'',FALSE,white,blue,ch);

    gotoxy(1,22);
    textcolor(cyan);
    textbackground(black);
    write('Enter scores file:');
    getStr(scoresFile,22,30,40,'',FALSE,white,blue,ch);

    gotoxy(1,23);
    textcolor(cyan);
    textbackground(black);
    write('Enter Riddles Masters file:');
    getStr(riddlesFile,23,30,40,'',FALSE,white,blue,ch);

    gotoxy(1,24);
    textcolor(cyan);
    textbackground(black);
    write('Enter Guild Masters file:');
    getStr(mastersFile,24,30,40,'',FALSE,white,blue,ch);

  end;

procedure testit;

  var
    ch : char;
    lastkey : integer;
    state : integer;

  begin
    state := 0;
    repeat
      case state of
        0 : begin displayTextFiles; end;
        1 : getStr(eventsFile,20,30,40,'',TRUE,white,blue,lastkey);
        2 : getStr(yEventsFile,21,30,40,'',TRUE,white,blue,lastkey);
        3 : getStr(scoresFile,22,30,40,'',TRUE,white,blue,lastkey);
        4 : getStr(riddlesFile,23,30,40,'',TRUE,white,blue,lastkey);
        5 : getStr(mastersFile,24,30,40,'',TRUE,white,blue,lastkey);
      end;
      if state = 0 then
        inc(state)
      else if ((lastkey = enterSC) or (lastkey = dnSC)) then
        begin
          if state < 5 then inc(state);
        end
      else if ((lastkey = upSC)) then
        begin
          if state > 1 then dec(state);
        end
      else if ((lastkey = escSC)) then
      else
        begin
          write(chr(7));
        end;
    until lastkey = escSC;
  end;

procedure editPlayer;

  var
    who : integer;
    sure, well : str55;
    theCh : char;
    which : char;
    code : integer;

  begin
    clrscr;
    repeat
      sure := ' ';
      writeln;
      write('Edit/Modify/Delete who? [?=List] [Return Aborts]: ');
      ask(who);
      if who > 0 then
        begin
          write(USERS[WHO,3],' [Y/N]? ');
          what(theCh)
        end;
    until (who = -1) or (theCh = 'Y');
    if who > 0 then
      begin
        repeat
          clrscr;
          writeln('');
          writeln('           Player: ',USERS[WHO,3]);
          writeln('Password/BBS Name: ',USERS[WHO,2]);
          writeln;
          writeln('Last played ',LDATE-USERI[WHO,2],' day(s) ago...');
          writeln;
          writeln('Days in jail: ',useri[who,7]);
          writeln('Time left today: ',useri[who,6]);
          writeln('Gold: ',useri[who,4]);
          writeln;
          writeln('[P]layer name change  [B]BS Name/Password Change');
          writeln('[D]elete Player       [S]et Last Play Day to Today''s Date');
          writeln('[R]eset todays time   [J]ail set to 0');
          writeln('[G]old');

          writeln('[Q]uit Editor...');
          writeln;
          write('Your Choice [ ]',CHR(8),CHR(8));
          repeat
            which := upcase(readkey);
          until (which in ['P','B','D','S','Q','R','J','G']);
          writeln(which);
          if which = 'S' then
            begin
              writeln;
              write('Set player''s last play day to ');
              make_date;
              write(' ? ');
              what(theCh);
              if theCh = 'Y' then
                begin
                  USERI[WHO,2]:=LDATE;
                  Writeln;
                  Writeln('Last play day reset!');
                  pressReturn;
                end;
            end;
          if which = 'R' then
            begin
              writeln;
              write('Reset this players time for today? ');
              what(theCh);
              if theCh = 'Y' then
                begin
                  useri[who,6] := 24;
                  Writeln;
                  Writeln('Todays time reset!');
                  pressReturn;
                end;
            end;
          if which = 'G' then
            begin
              writeln;
              write('Change this players gold? ');
              what(theCh);
              if theCh = 'Y' then
                begin
                  write('How much should this player have? ');
                  readln(sure);
                  val(sure,useri[who,4],code);
                  Writeln;
                  Writeln('Gold changed!');
                  pressReturn;
                end;
            end;
          if which = 'J' then
            begin
              writeln;
              write('Set this player''s jail sentance to 0? ');
              what(theCh);
              if theCh = 'Y' then
                begin
                  useri[who,7] := 0;
                  Writeln;
                  Writeln('Player''s jail sentence cleared!');
                  pressReturn;
                end;
            end;
          if which = 'D' then
            begin
              writeln;
              write('Delete ',USERS[WHO,3],'? ');
              what(theCh);
              If theCh='Y' then
                begin
                  GOODBYE(WHO);
                  Writeln;
                  Writeln('It is done!');
                  pressReturn;
                end;
            end;
          if WHICH='B' then
            begin
              well:='';
              repeat
                writeln;
                writeln('Be sure to use same format as above, or TG will not recognize their BBS name.');
                writeln;
                write('Enter new Password/BBS Name: ');
                readln(sure);
                upcaseln(SURE);
                write(SURE,', Correct? ');
                what(theCh);
              until theCh='Y';
              USERS[WHO,2]:=SURE;
              Writeln;
              Writeln('It it done!');
              pressReturn;
            End;
          If WHICH='P' then
            begin
              WELL:='';
              Repeat
                Repeat
                  Writeln;
                  Write('Enter Player''s New Name: ');
                  Readln(SURE);
                  If ord(SURE[0])>25 then Writeln ('25 Char. Maximum Please...');
                  If SURE[ord(SURE[0])]=' ' then Writeln ('A blank space at the end of a name is not allowed.');
                  If SURE[1]=' ' then Writeln ('A blank space at the beginning of a name is not allowed.');
                  If ord(SURE[0])<4 then Writeln ('4 Char. Minimum Please...');
                  UPCASEln(SURE);
                Until (SURE[1]<>' ') and (SURE[ord(SURE[0])]<>' ') and (ord(SURE[0])<26) and (ord(SURE[0])>3) and
                      (SURE<>'EMPTY');
                Write (SURE,', Correct [Y/N] ');
                WHAT(theCh);
              Until (theCh='Y');
              USERS[WHO,3]:=SURE;
              Writeln;
              Writeln('Name Changed!!');
              pressReturn;
            end;
        until (WHICH='Q') or (USERS[WHO,3]='EMPTY');
      end;
  end;





procedure createClock;

  var
    ff : text;

  begin
    assign(ff,'thieves.clk');
    {$I-}
    rewrite(ff);
    {$I+}
    if ioresult <> 0 then
      begin
        writeln('Unable to create thieves.clk in current directory... halting...');
        halt(2);
      end;
    writeln(ff,'0');
    writeln(ff,'0');
    close(ff);
  end;


procedure displayAllSetFiles;

  var
    ch : integer;

  begin

    clrscr;
    writeln;
    writeln('      Enter the following files or paths.  Defaults have been assumed.');
    writeln('      You will need to change these to fit your system needs.  Press');
    writeln('      [ESC] when completed.  Use the arrow keys for moving between');
    writeln('      fields.');

    { thieves.exe directory }
    gotoxy(3,7);
    textcolor(cyan);
    textbackground(black);
    write('Enter path to THIEVES.EXE:');
    getStr(thievesPath,7,32,40,'',FALSE,white,blue,ch);



    { data path }
    gotoxy(3,9);
    textcolor(cyan);
    textbackground(black);
    write('The data path is for all player individual messages and data.');
    gotoxy(3,10);
    write('Enter data path:');
    getStr(dataPath,10,32,40,'',FALSE,white,blue,ch);





    gotoxy(3,12);
    textcolor(cyan);
    textbackground(black);
    write('The following are files that can be put on a bulletin.');
    gotoxy(3,13);
    write('They ARE required for normal game play but they can also');
    gotoxy(3,14);
    write('be displayed as text files to the callers.');

    gotoxy(3,15);
    textcolor(cyan);
    textbackground(black);
    write('Enter events file:');
    getStr(eventsFile,15,32,40,'',FALSE,white,blue,ch);

    gotoxy(3,16);
    textcolor(cyan);
    textbackground(black);
    write('Enter yesterday Events file:');
    getStr(yEventsFile,16,32,40,'',FALSE,white,blue,ch);

    gotoxy(3,17);
    textcolor(cyan);
    textbackground(black);
    write('Enter scores file:');
    getStr(scoresFile,17,32,40,'',FALSE,white,blue,ch);

    gotoxy(3,18);
    textcolor(cyan);
    textbackground(black);
    write('Enter Riddles Masters file:');
    getStr(riddlesFile,18,32,40,'',FALSE,white,blue,ch);

    gotoxy(3,19);
    textcolor(cyan);
    textbackground(black);
    write('Enter Guild Masters file:');
    getStr(mastersFile,19,32,40,'',FALSE,white,blue,ch);

  end;



procedure editEntireSetFile;

  var
    ch : char;
    lastkey : integer;
    state : integer;
    otherLastKey : integer;

  begin
    state := 0;
    repeat
      case state of
        0 : begin displayAllSetFiles; end;
        1 : begin
              getStr(thievesPath,7,32,40,'',TRUE,white,blue,lastkey);
              if ((length(thievesPath) > 0) and (thievesPath[length(thievesPath)] <> '\')) then
                begin
                  thievesPath := thievesPath + '\';
                  getStr(thievesPath,7,32,40,'',FALSE,white,blue,otherLastKey);
                end;
            end;
        2 : begin
              getStr(dataPath,10,32,40,'',TRUE,white,blue,lastkey);
              if ((length(dataPath) > 0) and (dataPath[length(dataPath)] <> '\')) then
                begin
                  dataPath := dataPath + '\';
                  getStr(dataPath,10,32,40,'',FALSE,white,blue,otherLastKey);
                end;
            end;
        3 : getStr(eventsFile,15,32,40,'',TRUE,white,blue,lastkey);
        4 : getStr(yEventsFile,16,32,40,'',TRUE,white,blue,lastkey);
        5 : getStr(scoresFile,17,32,40,'',TRUE,white,blue,lastkey);
        6 : getStr(riddlesFile,18,32,40,'',TRUE,white,blue,lastkey);
        7 : getStr(mastersFile,19,32,40,'',TRUE,white,blue,lastkey);
      end;
      if state = 0 then
        inc(state)
      else if ((lastkey = enterSC) or (lastkey = dnSC)) then
        begin
          if state < 7 then inc(state);
        end
      else if ((lastkey = upSC)) then
        begin
          if state > 1 then dec(state);
        end
      else if ((lastkey = escSC)) then
      else
        begin
          write(chr(7));
        end;
    until lastkey = escSC;

  end;


procedure saveSettings;

  var
    ff : text;
    ch : char;

  begin
    writeln;
    gotoxy(1,23);
    textcolor(lightgreen);
    textbackground(black);
    writeln('Saving settings...');
    assign(ff,'thieves.set');
    {$I-}
    rewrite(ff);
    {$I+}
    if ioresult <> 0 then
      begin
        clrscr;
        writeln;
        writeln;
        textcolor(cyan);
        writeln('Unable to create thieves.set in current directory...');
        repeat ch := upcase(readkey) until ch in ['Y','N'];
        writeln;
        writeln('Press any key to exit continue.');
        readkey;
      end
    else
      begin
        writeln(ff,dataPath);
        writeln(ff,thievesPath);
        writeln(ff,eventsFile);
        writeln(ff,yEventsFile);
        writeln(ff,scoresFile);
        writeln(ff,mastersFile);
        writeln(ff,riddlesFile);
        close(ff);
      end;
  end;



procedure checkFirstTime;

  var
    ff : text;
    notFound : integer;
    ch : char;

  begin
    notFound := 0;
    assign(ff,'thieves.set');
    {$I-}
    reset(ff);
    {$I+}
    if ioresult <> 0 then
      inc(notFound)
    else
      close(ff);

    assign(ff,'thieves.dat');
    {$I-}
    reset(ff);
    {$I+}
    if ioresult <> 0 then
      inc(notFound)
    else
      close(ff);

    assign(ff,'thieves.clk');
    {$I-}
    reset(ff);
    {$I+}
    if ioresult <> 0 then
      inc(notFound)
    else
      close(ff);

    if notFound = 3 then
      begin
        textcolor(green);
        write('This is your first time running TGEDIT.  Shall we begin? ');
        textcolor(red);
        what(ch);
        textcolor(green);
        if ch = 'N' then halt(0);
        initializeData;
        saveData;
        createClock;
        getSetDefaults;
        editEntireSetFile;
        saveSettings;
        { make scores file }
        assign(ff,scoresFile); rewrite(ff); close(ff);
        { make events file }
        assign(ff,eventsFile); rewrite(ff); close(ff);
        assign(ff,yeventsFile); rewrite(ff); close(ff);
      end
    else if notFound > 0 then
      begin
        clrscr;
        textcolor(white+128);
        writeln('Some data files not found...');
        textcolor(white);
        writeln('We need to recreate these files.');
        textcolor(lightgreen);
        writeln;
        writeln('Press any key to create these files.');
        readkey;
        { we need to recreate the missing files... }
      end;
  end;



procedure mainMenu;

  var
    ch : char;

  begin
    checkFirstTime;

    loadSettings;
    loadData;

    repeat
      textbackground(black);
      textcolor(green);
      clrscr;
      writeln('               Thieves'' Guild Editor');
      writeln;
      write('             Today''s Date: '); make_date;
      writeln;
      writeln;
      writeln('  1)  Reset current game in progress');
      write('  2)  Location of THIEVES.EXE: '''); textcolor(white);
        write(thievesPath); textcolor(green); writeln('''');
      writeln('  3)  Events and Score file paths');
      write('  4)  Location of data files: '''); textcolor(white);
        write(dataPath); textcolor(green); writeln('''');
      writeln('  5)  Modify/Edit a player');
      writeln;
      writeln('  Q)  Quit (and save settings)');
      writeln('  A)  Abort changes (don''t save)');
      writeln;
      write('  --> ');
      ch := upcase(readkey);
      case(ch) of
        '1' : begin writeln('Reset Game in progress...'); resetGame; end;
        '2' : begin writeln('Thieves.Exe path...'); getThievesPath; end;
        '3' : begin writeln('Events and Score files'); testit; {getTextfiles;} end;
        '4' : begin writeln('Data file'); getDataFile; end;
        '5' : begin writeln('Modify/Edit'); editPlayer; end;
        'Q' : writeln(ch);
      end;  { case statement }
    until ch in ['A','Q'];
    if ch = 'A' then
      begin
        writeln;
        writeln('Exiting without saving changes...');
        writeln;
      end;
    if ch = 'Q' then
      begin
        saveSettings;
        saveData;
      end;
  end;





begin
  textbackground(black);
  textcolor(green);
  clrscr;
  mainMenu;
  textbackground(black);
  textcolor(lightgray);
  clrscr;
  writeln('Thank you for using the Thieves'' Guild Game Editor...');
  textcolor(lightred);
  writeln('(c) 1995 by Mythyn Software');
  writeln;
  textcolor(cyan);
  writeln('Support BBS:');
  writeln('  Deathmatch BBS (801) 371-9132');
  writeln('  Conference # 9 (''J 9'' at main menu)');
  textcolor(lightgray);
  writeln;
end.

