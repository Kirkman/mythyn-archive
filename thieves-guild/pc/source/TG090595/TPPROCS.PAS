{ Unit to use with SoftCode generated programs for Turbo Pascal           }
{    The SoftCode Pascal Data Entry, Database Template Set. Version 3.00  }
{    (c) Copyright 1992, BottleWorks Development Corp                     }
{        All rights reserved.                                             }

UNIT tpprocs;

INTERFACE

USES dos,crt;

{$V-,R-}

CONST



       MaxExitKeysSC  = 60;       { This is the maximum number of exit keys allowed for the program }
                                  { Increase this value if you need more }

       LeftSC       =  $4b00;     { Scan code/Ascii code key definitions }
       RightSC      =  $4d00;
       UpSC         =  $4800;
       DnSC         =  $5000;
       EscSC        =  $11b;
       EnterSC      =  $1c0d;
       HomeSC       =  $4700;
       EndSC        =  $4f00;

     CtrlEndSC    =  $7500;
     CtrlHomeSC   =  $7700;
        CtrlPgUpSC   =  -31744;   { $8400, cannot be used in CASE...END as $8400}
     CtrlPgDnSC   =  $7600;
     PgUpSC       =  $4900;
     PgDnSC       =  $5100;
     ShftTabSC    =  $f00;
     CtrlLeftSC   =  $7300;
     NoKeySC      =  $ffff;
     TabSC        =  $f09;
     CtrlRightSC  =  $7400;
     NULSC        =  $0;
     DelSC        =  $5300;
     InsertSC     =  $5200;
     PeriodSC     =  $342e;
     BackSC       =  $e08;

     F1SC       =  $3b00;         { F1 to F10 key }
     F2SC       =  $3c00;
     F3SC       =  $3d00;
     F4SC       =  $3e00;
     F5SC       =  $3f00;
     F6SC       =  $4000;
     F7SC       =  $4100;
     F8SC       =  $4200;
     F9SC       =  $4300;
     F10SC      =  $4400;

     ShftF1SC   =  $5400;          { F1 to F10 Shifted }
     ShftF2SC   =  $5500;
     ShftF3SC   =  $5600;
     ShftF4SC   =  $5700;
     ShftF5SC   =  $5800;
     ShftF6SC   =  $5900;
     ShftF7SC   =  $5a00;
     ShftF8SC   =  $5b00;
     ShftF9SC   =  $5c00;
     ShftF10SC  =  $5d00;

     CtrlF1SC   =  $5e00;            { F1 to F10 with Ctrl pressed }
     CtrlF2SC   =  $5f00;
     CtrlF3SC   =  $6000;
     CtrlF4SC   =  $6100;
     CtrlF5SC   =  $6200;
     CtrlF6SC   =  $6300;
     CtrlF7SC   =  $6400;
     CtrlF8SC   =  $6500;
     CtrlF9SC   =  $6600;
     CtrlF10SC  =  $6700;

     AltF1SC    =  $6800;          { F1 to F10 with Alt pressed }
     AltF2SC    =  $6900;
     AltF3SC    =  $6a00;
     AltF4SC    =  $6b00;
     AltF5SC    =  $6c00;
     AltF6SC    =  $6d00;
     AltF7SC    =  $6e00;
     AltF8SC    =  $6f00;
     AltF9SC    =  $7000;
     AltF10SC   =  $7100;

     CtrlASC    =  $1e01;
     CtrlBSC    =  $3002;
     CtrlCSC    =  $2e03;
     CtrlDSC    =  $2004;
     CtrlESC    =  $1205;
     CtrlFSC    =  $2106;
     CtrlGSC    =  $2207;
     CtrlHSC    =  $2308;
     CtrlISC    =  $1709;
     CtrlJSC    =  $240a;
     CtrlKSC    =  $250b;
     CtrlLSC    =  $260c;
     CtrlMSC    =  $320d;
     CtrlNSC    =  $310e;
     CtrlOSC    =  $180f;
     CtrlPSC    =  $1910;
     CtrlQSC    =  $1011;
     CtrlRSC    =  $1312;
     CtrlSSC    =  $1f13;
     CtrlTSC    =  $1414;
     CtrlUSC    =  $1615;
     CtrlVSC    =  $2f16;
     CtrlWSC    =  $1117;
     CtrlXSC    =  $2d18;
     CtrlYSC    =  $1519;
     CtrlZSC    =  $2c1a;

     AltASC   =  $1e00;
     AltBSC   =  $3000;
     AltCSC   =  $2e00;
     AltDSC   =  $2000;
     AltESC   =  $1200;
     AltFSC   =  $2100;
     AltGSC   =  $2200;
     AltHSC   =  $2300;
     AltISC   =  $1700;
     AltJSC   =  $2400;
     AltKSC   =  $2500;
     AltLSC   =  $2600;
     AltMSC   =  $3200;
     AltNSC   =  $3100;
     AltOSC   =  $1800;
     AltPSC   =  $1900;
     AltQSC   =  $1000;
     AltRSC   =  $1300;
     AltSSC   =  $1f00;
     AltTSC   =  $1400;
     AltUSC   =  $1600;
     AltVSC   =  $2f00;
     AltWSC   =  $1100;
     AltXSC   =  $2d00;
     AltYSC   =  $1500;
        AltZSC   =  $2c00;

        startcursorSC : Integer = 1; { Default initial cursor position in field }
        hiddenSC : Boolean = False;  { True to not display a field }
                               { Is always reset back to false after exiting
                                 a GETxxx field procedure }


TYPE

{$IFOPT N-}
       double = real;   { No 8087 calculations. Default }
{$ELSE}
       real = single;   { 8087 mode }
{$ENDIF}

       str255SC       = STRING[255];
       str80SC        = STRING[80];
       str8SC         = STRING[8];
       dateSC         = str8SC;
       eurodateSC     = str8SC;
       videopointerSC = ARRAY[1..4000] OF Char;    {ARRAY[1..3840] OF Char;}
       videoaddrSC    = ^videopointerSC;
       keyarrSC       = ARRAY[1..MaxExitKeysSC] OF Integer;

       lnSC           = ARRAY[0..128, 1..3] OF Byte;
       lincolarrSC    = ^lnSC;


VAR

  { Variables set by various functions to control screen display and entry }

  msuppSC      : Boolean;      { If True, suppresses error message display }
  screenmsgSC  : str80SC;      { Message to be shown at screen line 25 }

  videoSC      : VideoaddrSC;  { Video monitor address  =  $B800 or  =  $B000 }
  screenSC     : Integer;      { Current Screen number }
  numfieldSC   : Integer;      { Number of fields in current screen }
  fieldnumSC   : Integer;      { Current field number }
  inpmodeSC    : Boolean;      { TRUE if we are inputing in to a field
                                 FALSE if we are displaying only }
  lastkeySC    : Integer;      { Last key pressed to exit a field }
  exitSC       : Boolean;      { TRUE to exit the current screen }
  exitcursorSC : Integer;      { Last cursor position when exiting GETITEM }

  rSC          : registers;    { Register variable declaration }
  clear25SC    : Boolean;      { TRUE if line 25 has a message on it }
  beeponSC     : Boolean;      { TRUE if you wish to have beeping for errors }
  snowSC       : Boolean;      { True if monitor card makes snow. Determined
                                 by GETVIDEO procedure below }
  speedSC      : Text;         { Used if calling Flashup or Speed Screen }
  flashSC      : Text;
  displaySC    : Text;
  lincolSC     : lincolarrSC;
  okSC         : Boolean;
  autohelpSC   : Boolean;      { Display associated help automatically
                                 if using Flash-Up }
  helpcountSC  : Word;         { Number of help windows up. See display_help
                                 and clear_help procedures in main program }
  critsearchSC : Boolean;      { True, if in Criteria screen }
  dmethodSC    : str80SC;      { Display method used }
  clrfgrSC     : Byte;         { Color used in clearing the message/menu line }
  clrbgrSC     : Byte;
  printmsgSC   : Boolean;      { Indicates if screenmsgSC is to be redisplayed }

  { Define the array used to hold the field exit keys }
  ExitKeysSC : record
         Count : Integer;
         Keys  : KeyArrSC;
  end;



    { Comments on the procedures below may be found at the start of
      each implementation }
    FUNCTION inarray(key : Integer; VAR k : keyarrSC) : Boolean;
    PROCEDURE beep(beepon : Boolean);
    PROCEDURE color(foregr, backgr : Byte);
    PROCEDURE setbordercolor(bordercolor : Byte);
    PROCEDURE cursoron;
    PROCEDURE cursoroff;
    PROCEDURE cursorhalf;
    PROCEDURE cursornormal;
    PROCEDURE dispmessage(message : str80SC);
    PROCEDURE replicate(VAR varname : str80SC; num : Integer; achar : Char);
    PROCEDURE clearmessage;
    PROCEDURE clearmessage2;
    PROCEDURE getvideo(VAR video : videoaddrSC);
    PROCEDURE videooff;
    PROCEDURE videoon;
    FUNCTION uppercase(str : STRING) : STRING;
    PROCEDURE display_screen(screen_name : str80SC; video : videoaddrSC;
              VAR exist : Boolean; disptype : CHAR; bdrcolor : Byte;
              dmethod : str80SC; x1,y1,x2,y2 : Byte);
    PROCEDURE inkey(VAR key : Integer);
    PROCEDURE clearkbd;
    PROCEDURE fixnum(VAR temp_item : str80SC);
    FUNCTION date_check(datevar : dateSC) : Boolean;
    FUNCTION checkdate(datefield, date_low, date_high : dateSC) : Boolean;
    FUNCTION checkeurodate(datefield, datelow, datehigh : eurodateSC) : Boolean;
    PROCEDURE getfield(
                    ftype : Char;
                    VAR field : str80SC;
                    lin, col, len : Integer;
                    pict : str80SC;
                    inpmode : Boolean;
                    fgr, bgr : Byte;
                    VAR lastkey : Integer
                    );
    PROCEDURE getstr(VAR fieldname : str80SC; lin, col, len : Integer;
              picture : str80SC; inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer);
    PROCEDURE getmemo(VAR fieldname : str80SC; lin, col, len : Integer;
              picture : str80SC; inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer);
    PROCEDURE getdt(VAR fieldname : dateSC; lin, col : Integer;
              inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer);
    PROCEDURE geteurodate(VAR fieldname : eurodateSC; lin, col : Integer;
              inpmode : Boolean;
              fgr, bgr : Byte; VAR lastkey : Integer);
    PROCEDURE getint(VAR fieldname : Integer; lin, col, len : Integer;
              inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer);
    PROCEDURE getlong(VAR fieldname : Longint; lin, col, len : Integer;
              inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer);
    PROCEDURE getreal(VAR fieldname : Real; lin, col, len, decimal : Integer;
              inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer);
    PROCEDURE getdouble(VAR fieldname : Double; lin, col, len, decimal : Integer;
              inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer);
    PROCEDURE getyn(VAR fieldname : Boolean; lin, col : Integer;
              inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer);
    PROCEDURE critgetyn(VAR fieldname : Char; lin, col : Integer;
              inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer);
    FUNCTION get_value(fieldname : str255SC; nthstring : Integer) : str80SC;
    PROCEDURE getupfield(lincol: lincolarrSC);
    PROCEDURE getdownfield(lincol: lincolarrSC);
    PROCEDURE getleftfield(lincol: lincolarrSC);
    PROCEDURE getrightfield(lincol: lincolarrSC);
    PROCEDURE AddExitKey(key :Integer);
    Procedure SendCmd (cmd:string);

IMPLEMENTATION
  {---------------------------------------------------------------------------}
  {* FUNCTION inarray(key : Integer; VAR k : keyarrSC) : Boolean; *}
  FUNCTION inarray;
    { True if "key" is in "k" array else return false. }
    { Last elment in "k" must be 0 }
  VAR
    i : Integer;
  BEGIN
  i := 1;
  WHILE (k[i] <> 0) AND (k[i] <> key) DO i := i+1;
  inarray := (k[i] <> 0);
  END;

  {---------------------------------------------------------------------------}
  {* PROCEDURE beep(beepon : Boolean); *}
  PROCEDURE beep;
  BEGIN
  IF beepon THEN BEGIN
      sound(900);
      delay(100);
      nosound;
  END
  END;

  {---------------------------------------------------------------------------}
  {* PROCEDURE color(foregr, backgr : Byte); *}
  PROCEDURE color;
    { Select current color by setting Foreground and Background
    Any values between 0 and 15 are acceptable. See Tech Ref Manual
    }
  BEGIN
  IF backgr > 7 THEN foregr := foregr+16;
  TextColor(foregr); TextBackground(backgr);
  END;

  {---------------------------------------------------------------------------}
  {* PROCEDURE setbordercolor(bordercolor : Byte); *}
  PROCEDURE setbordercolor;
  BEGIN
    rSC.bl := bordercolor;
    rSC.bh := 0;
    rSC.ah := 11;
    Intr($10,rSC);
  END;

  {---------------------------------------------------------------------------}
  PROCEDURE cursoron;
    { Turn cursor on }
  BEGIN
  rSC.ah := 3;                  { get cursor type in rSC.cx }
  Intr($10, rSC);
  rSC.ah := 1;
  rSC.ch := rSC.ch AND $0f;
  Intr($10, rSC);
  END;

  {---------------------------------------------------------------------------}
  PROCEDURE cursoroff;
    { Turn cursor off }
  BEGIN
  rSC.ah := 3;
  Intr($10, rSC);               { get cursor type in rSC.cx }
  rSC.ah := 1;
  rSC.ch := rSC.ch AND $0f;
  rSC.ch := rSC.ch OR $30;        { set cursor blink bits to no cursor }
  Intr($10, rSC);
  END;

  {---------------------------------------------------------------------------}
  PROCEDURE cursorhalf;
    { Set cursor to half size }
  VAR
    monitortype : Byte;
  BEGIN
  rSC.ah := 15;
  Intr($10, rSC);
  monitortype := rSC.al;
  rSC.ah := 3;
  Intr($10, rSC);
  IF monitortype = 7 THEN
    BEGIN
    rSC.cl := $0c;              { Monochrome monitor }
    rSC.ch := rSC.ch AND $f0;
    rSC.ch := rSC.ch OR  $06;
  END ELSE
    BEGIN
    rSC.cl := $07;              { Graphics monitor }
    rSC.ch := rSC.ch AND $f0;
    rSC.ch := rSC.ch OR  $03;
    END;
  rSC.ah := 1;
  Intr($10, rSC);
  END;

  {---------------------------------------------------------------------------}
  PROCEDURE cursornormal;
    { Set cursor to normal size }
  VAR
    monitortype : Byte;
  BEGIN
  rSC.ah := 15;
  Intr($10, rSC);
  monitortype := rSC.al;
  rSC.ah := 3;
  Intr($10, rSC);
  IF monitortype = 7 THEN
    BEGIN
    rSC.cl := $0c;              { Monochrome monitor }
    rSC.ch := rSC.ch AND $f0;
    rSC.ch := rSC.ch OR  $0b;
  END ELSE
    BEGIN
    rSC.cl := $07;              { Graphics monitor }
    rSC.ch := rSC.ch AND $f0;
    rSC.ch := rSC.ch OR  $06;
    END;
  rSC.ah := 1;
  Intr($10, rSC);
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE dispmessage(message : str80SC); }
  { Display a message on line 25 and set the Clear25SC flag to true }
  PROCEDURE dispmessage;
  VAR
    center : Integer;
  BEGIN
    beep(beeponSC);
    clear25SC := True;
    center := (80-Length(message)) DIV 2;
    color(0, 7);
    cursoroff;
    GoToXY(center, 25);
    Write(message);
{    Write(' ', message, ' ');}
    clearkbd;
    cursoron;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE replicate(VAR varname : str80SC; num : Integer; achar : Char); }
  { Replicate the "achar", "num" times }
  PROCEDURE replicate;
  BEGIN
  varname := '';
  WHILE (num > 0) DO
    BEGIN
    varname := varname+achar;
    num := num-1;
    END;
  END;

  {---------------------------------------------------------------------------}
  PROCEDURE clearmessage;
    { If "clear25SC" is TRUE clear line 25 }
  VAR
    blanks : str80SC;
  BEGIN
  IF clear25SC THEN
    BEGIN
    clear25SC := False;
    Color(clrfgrSC, clrbgrSC);
    GoToXY(1,25);
    DelLine;
    END;
  END;

  {---------------------------------------------------------------------------}
  PROCEDURE ClearMessage2;
  { Clears line 25 unconditionally }
  BEGIN
    Color(clrfgrSC,clrbgrSC);
    GotoXY(1,25);
    DelLine;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE getvideo(VAR video : videoaddrSC); }
  { Determine the type of video by returning the video address in video }
  { Also set "snowSC" to True if CGA, False if EGA  or Monochrome }
  PROCEDURE getvideo;
  BEGIN
  rSC.ah := 15;
  Intr($10, rSC);
  IF rSC.al = 7 THEN
    BEGIN
    video := Ptr($b000, 0);
    snowSC := False;
  END ELSE
    IF rSC.al IN [2, 3] THEN
      BEGIN
      video := Ptr($b800, 0);
      { -- Check if EGA to avoid checking for snow }
      rSC.ah := $12;
      rSC.cx := 0;
      rSC.bl := $10;
      Intr($10, rSC);
      IF rSC.cx = 0 THEN
        snowSC := True        { Regular Graphics card }
      ELSE
        snowSC := False;      { EGA card }
    END ELSE
      BEGIN
      WriteLn; WriteLn('Invalid mode'); Halt;
      END;
  END;

  {---------------------------------------------------------------------------}
  PROCEDURE videooff;
    { Turn video off if a graphics with snow card }
  BEGIN
  IF snowSC THEN Port[$3d8] := 1;
  END;

  {---------------------------------------------------------------------------}
  PROCEDURE videoon;
    { Turn video on if a graphics with snow card }
  VAR
    vonSC : Byte;
  BEGIN
  IF snowSC THEN
    BEGIN
    vonSC := Mem[$40:$65];
    Port[$3d8] := vonSC;
    END;
  END;

  {---------------------------------------------------------------------------}
  {FUNCTION uppercase(str : STRING) : STRING;}
  FUNCTION uppercase;
  { Converts a string into its uppercase equivalent }
  VAR i : Integer;
  BEGIN
    FOR i := 1 TO Length(str) DO
      str[i] := UpCase(str[i]);
    uppercase := str;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE display_screen(screen_name : str80SC; video : videoaddrSC;
              VAR exist : Boolean; disptype : CHAR; bdrcolor : Byte;
              dmethod : str80SC; x1,y1,x2,y2 : Byte); }
  PROCEDURE display_screen;
  { Display screen from disk. The screen must be an SCR file. }
    { See below if using Speed Screen(tm). }
  VAR
    bload : ARRAY[1..3968] OF Char;
    scrname : FILE;
    y,offs,len : integer;
    tempstr, temp : STR80SC;
  CONST
    BIOS = $10;
  VAR
    regs  : Registers;
    count : Byte;

  BEGIN

    CASE disptype OF
      'S' : BEGIN { Use speed screen if 'S' }
              GoToXY(1, 1);
              tempstr := '~x:s='+screen_name+', M('+dmethod+'), A(';
              str(x1,temp);
              tempstr := tempstr+temp+':';
              str(y1,temp);
              tempstr := tempstr+temp+':';
              str(x2,temp);
              tempstr := tempstr+temp+':';
              str(y2,temp);
              tempstr := tempstr+temp+')';
              IF uppercase(dmethod) <> 'INSTANT' THEN
                tempstr := tempstr+',t(1)';
              tempstr := tempstr+'/';
              sendcmd(tempstr);
              exist := True;
              setbordercolor(bdrcolor);
            END;
      'D' : BEGIN { screen_name must not have a file extension }
              GoToXY(1, 1);
              tempstr := screen_name + '.SCR';
              Assign(scrname, tempstr);
              {$I-} Reset(scrname,1);     {$I+}
              exist := False;
              IF IOResult = 0 THEN BEGIN
                Close(scrname);
                exist := True;
                tempstr := '~x:d='+screen_name+'/';
                sendcmd(tempstr);
              END;
            END;
    ELSE    { block read will be used in displaying screen }
      BEGIN
        Assign(scrname, screen_name);
        {$I-} Reset(scrname,1);     {$I+}
        exist := False;
        IF IOResult = 0 THEN BEGIN
          exist := True;
          BlockRead(scrname, bload[1], 7);
          BlockRead(scrname, bload[1], FileSize(scrname)-7);
          Close(scrname);
          videooff;
          FOR y:=y1 to y2 DO BEGIN
            offs:=((y-1)*160)+((x1-1)*2+1);
            len:=((x2-x1+1)*2);
            move(bload[offs],video^[offs],len);
          END;
          videoon;
          setbordercolor(bdrcolor);
        END;
      END;
    END;

  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE inkey(VAR key : Integer); }
  PROCEDURE inkey;
    { Get a keystroke. "key" contains the scan,ascii code. }
  BEGIN
  rSC.ah := 0;
  Intr($16, rSC);               { call BIOS to get key }
  key := rSC.ax;
  END;

  {---------------------------------------------------------------------------}
  PROCEDURE clearkbd;
    { Clear keyboard buffer }
  VAR
    clear : Boolean;
  BEGIN
  REPEAT
  rSC.ah := 1;
  Intr($16, rSC);               { call BIOS to check for a key }
  IF (rSC.flags AND  $0040) = 0 THEN
    clear := True             { clear the keyboard }
  ELSE
    clear := False;           { no keys to clear }
  IF clear THEN
    BEGIN
    rSC.ah := 0;                { pull key from buffer }
    Intr($16, rSC);
    END;
  UNTIL NOT clear;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE fixnum(VAR temp_item : str80SC); }
  PROCEDURE fixnum;
    { Strip blanks on both sides of temp_item. Called onlly for numerics. }
  VAR
    i, j : Byte;
  BEGIN
  IF temp_item <> '' THEN
    BEGIN
    j := Length(temp_item);
    { Strip Leading Blanks }
    i := 0;
    WHILE (temp_item[i+1] = ' ') AND (i < j) DO i := i+1; { strip leading blanks }
    IF (i > 0) AND (i < j) THEN temp_item := Copy(temp_item, i+1, j-i)
    ELSE IF (i = j) AND (temp_item[j] = ' ') THEN temp_item := '';
    i := Pos(' ', temp_item); { strip trailing blanks }
    IF i <> 0 THEN temp_item := Copy(temp_item, 1, i-1);
    IF temp_item[Length(temp_item)] = '.' THEN temp_item := temp_item+'0';
    END;
  END;                        { fixnum procedure }

  {---------------------------------------------------------------------------}
  { FUNCTION date_check(datevar : dateSC) : Boolean; }
  FUNCTION date_check;
    { Checks For Date Validity including leap year
    IF datevar is correct THEN date_check is True }
    CONST
      month_days:ARRAY[1..12] OF Integer = (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  VAR mm, dd, yy : STRING[2];
    mmi, ddi, yyi : Integer;
    error : Integer;
    ch_date : Boolean;
    year : Integer;
  BEGIN
  IF Ord(datevar[0]) <> 8 THEN
    BEGIN
    date_check := False
  END ELSE
    BEGIN
    ch_date := True;
    mm := Copy(datevar, 1, 2);
    dd := Copy(datevar, 4, 2);
    yy := Copy(datevar, 7, 2);
    Val(mm, mmi, error);
    IF (error <> 0) OR (mmi < 1) OR (mmi > 12) THEN ch_date := False;
    IF ch_date THEN
      BEGIN
      Val(dd, ddi, error);
      IF (error <> 0) OR (ddi < 1) OR (ddi > month_days[mmi]) THEN ch_date := False;
      END;
    IF ch_date THEN
      BEGIN
      Val(yy, yyi, error);
      IF error <> 0 THEN ch_date := False;
      END;
    IF ch_date THEN
      IF (mmi = 2) AND (ddi > 28) THEN { Check for leap year }
        BEGIN
        year := 1900+yyi;
        IF NOT((year MOD 4 = 0) AND
        (year MOD 100 <> 0) OR (year MOD 400 = 0)) THEN
          ch_date := False;
        END;
    date_check := ch_date;
    END;
  END;                        { PROCEDURE DATE_CHECK }

  {---------------------------------------------------------------------------}
  { FUNCTION checkdate(datefield, date_low, date_high : dateSC) : Boolean; }
  FUNCTION checkdate;
    { Check Validity If Date and whether it falls between low and high }
    { If low range date is higer than high range date then we assume }
    { we crossed centuries eg. 09/09/84 to 01/01/10 }
    { Also a null date is ignored }
  VAR
    ch_date : Boolean;
  CONST
    datenull = '  /  /  ';
  BEGIN
  IF datefield <> datenull THEN ch_date := date_check(datefield) ELSE ch_date := True;
  IF ch_date AND (datefield <> datenull) AND (date_low <> datenull) AND (date_high <> datenull) THEN
    BEGIN
    IF ch_date THEN ch_date := date_check(date_low);
    IF ch_date THEN ch_date := date_check(date_high);
    IF ch_date THEN
      BEGIN
      datefield := Copy(datefield, 7, 2)+Copy(datefield, 1, 6);
      date_low := Copy(date_low, 7, 2)+Copy(date_low, 1, 6);
      date_high := Copy(date_high, 7, 2)+Copy(date_high, 1, 6);
      IF (date_low <= date_high) THEN { Low Date < High Date }
        BEGIN
        IF (datefield < date_low) OR (datefield > date_high) THEN ch_date := False
      END ELSE                { Low Date  > High Date }
        IF (datefield < date_low) AND (datefield > date_high) THEN ch_date := False;
      END;
    END;
  checkdate := ch_date;
  END;


  {---------------------------------------------------------------------------}
  { FUNCTION checkeurodate(datefield, datelow, datehigh : eurodateSC) : Boolean;}
  { Check European style date. DD/MM/YY }
  FUNCTION checkeurodate;
  VAR tempchar : Char;
  BEGIN
  datefield := Copy(datefield, 4, 3)+Copy(datefield, 1, 3)+Copy(datefield, 7, 2);
  datelow := Copy(datelow, 4, 3)+Copy(datelow, 1, 3)+Copy(datelow, 7, 2);
  datehigh := Copy(datehigh, 4, 3)+Copy(datehigh, 1, 3)+Copy(datehigh, 7, 2);
  checkeurodate := checkdate(datefield, datelow, datehigh);
  END;

  {---------------------------------------------------------------------------}
  {===========================================================================}
  (* Displays the current value of "field" at "lin" and "col" using "bgr" and
  "fgr" for color.
  Allows data entry if inpmode is TRUE.
  The default starting cursor position is specified in "startcursorSC"
  Uses all editing keys as defined in the "editkeyarrSC" array.
  Checks for picture masks as defined by "pict" while typing.
  Cannot exit the "len" of the field.
  Returns "lastkey" pressed on exit.
  Set the global "exitcursorSC" to the last cursor position on exit.

  PROCEDURE getfield(
                  ftype : Char;            { Type: S,R,G,B,I,L,D,E }
                  VAR field : str80SC;     { Field name }
                  lin, col, len : Integer; { line, column and length of field}
                  pict : str80SC;          { picture mask }
                  inpmode : Boolean;       { TRUE to allow data entry}
                  fgr, bgr : Byte;         { fore abd background color }
                  VAR lastkey : Integer    { lastkey pressed to exit }
                  );
  *)
  PROCEDURE getfield;

  TYPE
    pict_type = SET OF Char;

  CONST
    pict_elements : pict_type = ['X', '!', 'Y', '#', '9', 'A', 'N', 'L'];
    hidchar = #254;

  VAR
    endcol,                   { end column within field }
    startcol,                 { start column within field }
    hcol,                     { horizontal column of cursor on screen }
    pcol,                     { cursor position in field }
    i, j, ilen : Byte;        { Assorted temp variables }

    decimal,                  { decimal position from the right }
    keycode : Integer;        { temp variable for keys pressed }

    insert_mode,              { True if in insert mode }
    end_of_field, begin_of_field, {True if try to move cursor past
                                  end or begin of field }
    modified,                 { True if field was modified }
    int_flag,                 { True if this is an number with no decimals }
    dec_flag,                 { True if this is a number with decimals }
    special : Boolean;        { True if key pressed was an exiting or help key
                              Note: All keys in the keyarrays above exit
                              except for the editing keys. }

    temp_item,
    wfield : str80SC;         { Work field for item }

    kchar : Char;             { Temporary character field }

    { Function to get a key from the keyboard. Checks allowable
    key according to picture mask before returning. If not allowed
    then prints error message on line 25 }
    FUNCTION getchar(ctype : Char; VAR keycode : Integer) : Boolean;
      { If getchar=true on return then keycode is in "keySC"}
      { If getchar=false on return then keycode is alpha numeric}
      { ctype must be one of the following:
        'X', '!', 'Y', '#', '9', 'A', 'N', 'L'}
    VAR
      tempp, tempc, tempm, ascii : Char;
      scan : Byte;
      correct, c25, beep : Boolean;
    BEGIN
    keycode := 0;

    REPEAT

    getchar := False;
    correct := False;
    inkey(keycode);

    { Clear Line 25 if a message was there }
    c25 := clear25SC;
    clearmessage;
    IF (screenmsgSC <> '') and c25 THEN
      BEGIN
      beep     := beeponSC;
      beeponSC := False;
      dispmessage(screenmsgSC);
      beeponSC := beep;
      clear25SC := False;
      printmsgSC := False;
      END;
    GoToXY(hcol, lin);
    color(fgr, bgr);

       IF inarray(keycode, ExitKeysSC.Keys) THEN
      BEGIN
      correct := True;        { Exit Getchar }
      getchar := True;        { TRUE means it is a special key }
    END ELSE
      BEGIN
      scan := keycode DIV 256;
      ascii := Chr(keycode AND $00ff);
      IF (ascii >= ' ') AND (ascii <= '~') AND (scan <> 0) THEN
        CASE ctype OF
          'X' : correct := True;
          '!' : BEGIN
                IF ascii IN ['a'..'z'] THEN ascii := Chr(Ord(ascii) AND $df);
                keycode := scan*256+Ord(ascii);
                correct := True;
                END;
          'Y' : BEGIN
                IF ascii IN ['Y', 'N', 'y', 'n'] THEN
                  BEGIN
                  ascii := Chr(Ord(ascii) AND  $df);
                  keycode := scan*256+Ord(ascii);
                  correct := True;
                END
                ELSE IF NOT msuppSC THEN BEGIN
                  clear25SC := True;
                  clearmessage;
                  dispmessage('Only Y,N');
                  END;
                END;
          'L' : BEGIN
                IF ascii IN ['T', 'F', 't', 'f', 'Y', 'N', 'y', 'n'] THEN
                  BEGIN
                  ascii := Chr(Ord(ascii) AND  $df);
                  keycode := scan*256+Ord(ascii);
                  correct := True;
                END
                ELSE IF NOT msuppSC THEN BEGIN
                  clear25SC := True;
                  clearmessage;
                  dispmessage('Only T,F,Y,N');
                  END;
                END;
          '#' : BEGIN
                tempp := #0;
                tempc := #0;
                tempm := #0;
                IF dec_flag OR (ftype IN ['S','M']) THEN tempp := '.';
                IF (len-decimal >= 3) OR ((decimal = 0) AND (len >= 2))
                  OR (ftype IN ['M','S']) THEN
                  BEGIN
                  tempc := '-';
                  tempm := '+';
                  END;
                IF ascii IN ['0'..'9', tempc, tempm, ' ', tempp] THEN correct := True
                ELSE IF NOT msuppSC THEN BEGIN
                  clear25SC := True;
                  clearmessage;
                  IF tempc <> #0 THEN
                    dispmessage('Only 0 thru 9, spaces and (-,+) allowed')
                  ELSE
                    dispmessage('Only 0 thru 9 and spaces allowed');
                  END;
                END;
          '9' : BEGIN
                tempp := #0;
                tempc := #0;
                tempm := #0;
                IF dec_flag OR int_flag THEN
                  BEGIN
                  IF dec_flag THEN tempp := '.';
                  IF (len-decimal >= 3) OR ((decimal = 0) AND (len >= 2)) THEN
                    BEGIN
                    tempc := '-';
                    tempm := '+';
                    END;
                  END;
                IF ascii IN ['0'..'9', tempp, tempc, tempm] THEN correct := True
                ELSE IF NOT msuppSC THEN BEGIN
                  clear25SC := True;
                  clearmessage;
                  IF tempc <> #0 THEN
                    dispmessage('Only 0 thru 9 and (-,+) allowed')
                  ELSE
                    dispmessage('Only 0 thru 9 allowed');
                  END;
                END;
          'A' : IF ascii IN ['a'..'z', 'A'..'Z', ' '] THEN correct := True
                ELSE IF NOT msuppSC THEN BEGIN
                  clear25SC := True;
                  clearmessage;
                  dispmessage('Only alpha characters allowed');
                  END;
          'N' : IF ascii IN ['a'..'z', 'A'..'Z', '0'..'9', ' '] THEN correct := True
                ELSE IF NOT msuppSC THEN BEGIN
                  clear25SC := True;
                  clearmessage;
                  dispmessage('Only alphanumeric characters allowed');
                  END;
        END;
      END;
    GoToXY(hcol, lin);
    UNTIL correct;
    END;                      { getchar function }

    PROCEDURE decrcol;
      { Positions Cursor At the previous Non Edit Character }
    VAR
      elem_end : Boolean;
      i : Byte;
    BEGIN
    IF hcol <> (col+startcol-1) THEN
      BEGIN
      i := pcol;
      elem_end := False;
      REPEAT
      i := i-1;
      IF (pict[i] IN pict_elements) OR (i < 1)
      OR (dec_flag AND (pict[pcol+i-1] = '.')) THEN elem_end := True;
      UNTIL elem_end;
      IF i >= 1 THEN
        BEGIN
        hcol := hcol-(pcol-i);
        pcol := i;
        END;
    END ELSE
      begin_of_field := True;
    END;                      { decrcol procedure }

    PROCEDURE incrcol;
      { positions Cursor At the Next Non Edit Character }
    VAR
      elem_end : Boolean;
      i : Byte;
    BEGIN
    IF hcol <> (col+len-1) THEN
      BEGIN
      i := 1; elem_end := False;
      REPEAT
      i := i+1;
      IF (pict[pcol+i-1] IN pict_elements) OR (pcol+i > len)
      OR (dec_flag AND (pict[pcol+i] = '.')) THEN elem_end := True;
      UNTIL elem_end;
      IF i <= len THEN
        BEGIN
        hcol := hcol+i-1;
        pcol := pcol+i-1;
        END;
    END ELSE
      end_of_field := True;
    END;                      { incrcol procedure }

  BEGIN                       { Main Procedure Of getfield }

  wfield := field;            { Store Actual wfield In A Work Variable }
  end_of_field := False;      { We havent moved past the start or end of field }
  begin_of_field := False;
  modified := False;          { Numeric field has not been modified }
  insert_mode := False;       { insert mode is off }
  cursornormal;               { Cursor is normal size }
  keycode := 0;

  pcol := startcursorSC;      { Initialize to starting cursor position }

  i := Length(wfield);
  { If picture and/or wfield size is less than length than
  make them as big as length }
  WHILE i < len DO
    BEGIN
    wfield := wfield+' ';
    i := i+1;
    END;

  IF (pict = '') THEN pict := 'X';
  i := Length(pict);
  kchar := pict[i];
  WHILE i < len DO
    BEGIN
    pict := pict+kchar;
    i := i+1;
    END;

  { Determine if the picture is a numeric picture with a decimal point. }
  dec_flag := False;
  int_flag := False;
  decimal := 0;
  IF ftype IN ['I', 'R', 'G', 'B'] THEN
    BEGIN
    j := Pos('.', pict);
    IF j > 0 THEN
      BEGIN
      decimal := len-j;
      dec_flag := True;
    END ELSE
      int_flag := True;
    END;

  {- Copy edit characters to wfield -}
  FOR i := 1 TO len DO
    IF NOT(pict[i] IN pict_elements) THEN wfield[i] := pict[i];

  {- Display The wfield on the screen -}
  color(fgr, bgr);
  cursoroff;
  GoToXY(col, lin);
  IF NOT hiddenSC THEN Write(wfield);
  GoToXY(col, lin);
  cursoron;

  {- Get Data From Screen If inpmode is True -}
  IF inpmode THEN
    BEGIN
    { Determine the start and end column by skiping over
    the hard coded picture elements e.g.  (999)  start=2 end=4 }
    startcol := 1;
    WHILE (NOT(pict[startcol] IN pict_elements)) AND (pcol <= len) DO
      startcol := startcol+1;

    endcol := len;
    WHILE (NOT(pict[endcol] IN pict_elements)) AND (endcol > startcol) DO
      endcol := endcol-1;
    ilen := len;              { Save length to reset before exiting getfield }
    len := endcol;            { Get the lengt between col and end col}
    pcol := startcol;
    hcol := col+pcol-1;
    j := startcursorSC;       { Get starting cursor global variable }
    IF j > len THEN j := len; { If start out of field adjust to length }

    i := pcol;
    WHILE i <= (j-1) DO       { Move cursor from startcol to startcursor }
      BEGIN
      IF NOT end_of_field THEN incrcol;
      i := i+1;
      END;

    IF (len >= startcol) THEN { if room between and end then get field }
      BEGIN
      hcol := col+pcol-1;
      GoToXY(hcol, lin);      {* Go to location on screen*}
      REPEAT
      end_of_field := False;
      begin_of_field := False;
      special := False;

      IF NOT getchar(pict[pcol], keycode) THEN
        BEGIN
        { if it is not a period and not a numeric field }
        IF (keycode <> periodSC) OR NOT dec_flag THEN
          BEGIN
          kchar := Chr(Lo(keycode));
          IF NOT insert_mode THEN
            BEGIN
            IF NOT hiddenSC THEN Write(kchar);
            wfield[pcol] := kchar;
          END ELSE
            BEGIN
            j := pcol+1;
            WHILE (pict[j] IN pict_elements) AND (j <= len) DO
              j := j+1;
            j := j-1;
            FOR i := j DOWNTO pcol+1 DO wfield[i] := wfield[i-1];
            wfield[pcol] := kchar;
            cursoroff;
            GoToXY(col, lin);
            IF NOT hiddenSC THEN Write(wfield);
            END;
          incrcol;
          GoToXY(hcol, lin);
          cursoron;
          modified := True;
        END ELSE
          BEGIN
          { decimal point allowed only on left side of decimal point}
          { otherwise it is ignored }
          IF pcol <= (len-decimal) THEN
            BEGIN
            temp_item := Copy(wfield, 1, pcol-1); { get integer }
            wfield := Copy(wfield, (len-decimal+1), decimal); { get decimal }

            fixnum(temp_item);
            IF temp_item = '' THEN temp_item := '0'; { at least a digit }
            i := (len-decimal-1); { fill blanks on left }
            WHILE Length(temp_item) < i DO
              temp_item := ' '+temp_item;
            cursoroff;
            GoToXY(col, lin);
            IF NOT hiddenSC THEN Write(temp_item); { display wfield }

            wfield := temp_item+'.'+wfield; { add to decimal side }
            pcol := endcol-decimal+1; { set cursor columns }
            hcol := col+pcol-1;
            GoToXY(hcol, lin);
            cursoron;
            END;
          END;
      END ELSE
        CASE keycode OF
          leftSC : BEGIN
                   decrcol;
                   GoToXY(hcol, lin);
                   END;       {Left}
          rightSC : BEGIN
                    incrcol;
                    GoToXY(hcol, lin);
                    END;      {Right}
          delSC,
          backSC : BEGIN      {Delete}
                   IF keycode = backSC THEN
                     BEGIN
                     decrcol;
                     begin_of_field := False;
                     END;
                   j := pcol+1; {FInd where the next edit char starts}
                   WHILE (pict[j] IN pict_elements) AND (j <= len) DO
                     j := j+1;
                   j := j-1;  { i=start, j:=end}
                   { Move chars left }
                   FOR i := pcol TO j-1 DO
                     BEGIN
                     wfield[i] := wfield[i+1];
                     END;
                   { & put blank at end}
                   wfield[j] := ' ';
                   {rewrite the wfield}
                   cursoroff;
                   GoToXY(col, lin);
                   IF NOT hiddenSC THEN Write(wfield);
                   GoToXY(hcol, lin);
                   cursoron;
                   END;
          insertSC : BEGIN       {Insert}
                  insert_mode := NOT insert_mode;
                  IF insert_mode THEN cursorhalf ELSE cursornormal;
                  END;
          homeSC : BEGIN
                   hcol := col+startcol-1;
                   pcol := startcol;
                   GoToXY(hcol, lin);
                   END;
          endSC : BEGIN
                  i := endcol;
                  WHILE (wfield[i] = ' ') AND (i >= startcol) DO
                    i := i-1;
                  IF i < len THEN i := i+1;
                  pcol := i;
                  hcol := col+pcol-1;
                  GoToXY(hcol, lin);
                  WHILE (NOT(pict[pcol] IN pict_elements)) AND (pcol > 1) DO
                    pcol := pcol-1;
                  END;
        ELSE
        special := True;
        END { Case keycode } ;
      UNTIL end_of_field OR begin_of_field OR special;
      END;
    len := ilen;              { Put original length back }
    END;

  { Strip Trailing Blanks for String types only }
  IF ftype IN ['S','M'] THEN
    BEGIN
    i := len;
    WHILE (wfield[i] = ' ') AND (i > 0) DO i := i-1;
    wfield[0] := Chr(i);
    END;

  { Fixup the number ofr numeric types only }
  IF (ftype IN ['I', 'R', 'G', 'B']) AND modified THEN
    BEGIN
    i := pcol;
    IF end_of_field THEN i := pcol ELSE i := pcol -1;
    temp_item := Copy(wfield, 1, i);
    fixnum(temp_item);
    IF temp_item <> '' THEN wfield := temp_item;
    END;

  cursornormal;

  exitcursorSC := pcol;       { Last cursor column in field }

  field := wfield;            { Return result Back To witem }
  if (inpmode) THEN lastkey := keycode; { Stuff the last key pressed }

  msuppSC := False;           { Turn any error message suppression off }

  END;                        { getfield procedure}

  {===========================================================================}
  { In the following procedures the parameters have the following meanings:

  ( Not all procedures have these parameters, because they make assumptions
  about certain types of fields. All procedures however do call GETFIELD
  which expects all the parameters.)

  fieldname = the variable name for the field
  lin,col,len = line, column, length of the field on screen
  picture = the picture of the field
  inpmode = TRUE if to display and get a field, FALSE to display only
  fgr,bgr = The attribute foreground and background colors (0-15) of the field
  lastkey = The Integer scan/ascii code OF the last key pressed
  }

  {---------------------------------------------------------------------------}
  { PROCEDURE getstr(VAR fieldname : str80SC; lin, col, len : Integer;
        picture : str80SC; inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer); }
  { Gets a field of type string }
  PROCEDURE getstr;
  BEGIN
  IF Length(fieldname) > len THEN fieldname := Copy(fieldname, 1, len);
  getfield('S', fieldname, lin, col, len, picture, inpmode, fgr, bgr, lastkey);
  hiddenSC := False;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE getmemo(VAR fieldname : str80SC; lin, col, len : Integer;
        picture : str80SC; inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer); }
  PROCEDURE getmemo;
  BEGIN
  IF Length(fieldname) > len THEN fieldname := Copy(fieldname, 1, len);
  getfield('S', fieldname, lin, col, len, picture, inpmode, fgr, bgr, lastkey);
  hiddenSC := False;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE getdt(VAR fieldname : dateSC; lin, col : Integer;
        inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer); }
  PROCEDURE getdt;
  VAR
    okdate : Boolean;
  CONST
    datenull = '  /  /  ';
  BEGIN
  REPEAT
  getfield('D', fieldname, lin, col, 8, '99/99/99', inpmode, fgr, bgr, lastkey);
  IF inpmode THEN
    BEGIN
    IF fieldname = '  /  /' THEN fieldname := datenull;
    okdate := checkdate(fieldname, fieldname, fieldname);
    IF NOT okdate THEN
      BEGIN
      clear25SC := True;
      clearmessage;
      dispmessage('Invalid Date Entered');
      END;
  END ELSE okdate := True;
  UNTIL okdate;
  hiddenSC := False;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE geteurodate(VAR fieldname : eurodateSC; lin, col : Integer;
        inpmode : Boolean; fgr, bgr : Byte; VAR lastkey : Integer); }
  PROCEDURE geteurodate;
  VAR
    okdate : Boolean;
  CONST
    datenull = '  /  /  ';
  BEGIN
  REPEAT
  getfield('D', fieldname, lin, col, 8, '99/99/99', inpmode, fgr, bgr, lastkey);
  IF inpmode THEN
    BEGIN
    IF fieldname = '  /  /' THEN fieldname := datenull;
    okdate := checkeurodate(fieldname, fieldname, fieldname);
    IF NOT okdate THEN
      BEGIN
      clear25SC := True;
      clearmessage;
      dispmessage('Invalid European Date Entered');
      END;
  END ELSE okdate := True;
  UNTIL okdate;
  hiddenSC := False;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE getint(VAR fieldname : Integer; lin, col, len : Integer;
        inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer); }
  PROCEDURE getint;
  VAR picture : STRING[25];
    tempfield : STRING[25];
    tempreal : Real;
    err : Integer;
  BEGIN
  Str(fieldname:len, tempfield);
  IF length(tempfield) > len THEN
    BEGIN
    replicate(tempfield,len,'*');
    END;
  IF inpmode THEN
    BEGIN
    replicate(picture, len, '#');
    REPEAT
    getfield('I', tempfield, lin, col, len, picture, inpmode, fgr, bgr, lastkey);
    fixnum(tempfield);
    Val(tempfield, tempreal, err);
    err := 0;
    IF (tempreal < -32768.0) OR (tempreal > 32767.0) THEN
      BEGIN
      clear25SC := True;
      clearmessage;
      dispmessage(' Number must be within -32768 and 32767 range. ');
      err := 1;
      END;
    UNTIL err = 0;
    Val(tempfield, fieldname, err);
    Str(fieldname:len, tempfield);
    END;
  color(fgr, bgr);
  cursoroff;
  GoToXY(col, lin);
  IF NOT hiddenSC THEN Write(tempfield);
  GoToXY(col, lin);
  cursoron;
  hiddenSC := False;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE getlong(VAR fieldname : Longint; lin, col, len : Integer;
        inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer); }
  PROCEDURE getlong;
  VAR picture : STRING[25];
    tempfield : STRING[25];
    err : Integer;
    tempreal : Real;
  BEGIN
  Str(fieldname:len, tempfield);
  IF length(tempfield) > len THEN
    BEGIN
    replicate(tempfield,len,'*');
    END;
  IF inpmode THEN
    BEGIN
    replicate(picture, len, '#');
    REPEAT
    getfield('G', tempfield, lin, col, len, picture, inpmode, fgr, bgr, lastkey);
    fixnum(tempfield);
    Val(tempfield, tempreal, err);
    err := 0;
    IF (tempreal < -2147483648.0) OR (tempreal > 2147483647.0) THEN
      BEGIN
      clear25SC := True;
      clearmessage;
      dispmessage(' Number must be within -2147483648 and 2147483647 range. ');
      err := 1;
      END;
    UNTIL err = 0;
    Val(tempfield, fieldname, err);
    Str(fieldname:len, tempfield);
    END;
  color(fgr, bgr);
  cursoroff;
  GoToXY(col, lin);
  IF NOT hiddenSC THEN Write(tempfield);
  GoToXY(col, lin);
  cursoron;
  hiddenSC := False;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE getreal(VAR fieldname : Real; lin, col, len, decimal : Integer;
        inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer); }
  PROCEDURE getreal;
  VAR picture : STRING[25];
    tempfield : STRING[25];
    err : Integer;
  BEGIN
  Str(fieldname:len:decimal, tempfield);
  IF length(tempfield) > len THEN
    BEGIN
    replicate(tempfield,len,'*');
    END;
  IF inpmode THEN
    BEGIN
    replicate(picture, len, '#');
    IF decimal > 0 THEN picture[len-decimal] := '.';
    getfield('R', tempfield, lin, col, len, picture, inpmode, fgr, bgr, lastkey);
    fixnum(tempfield);
    Val(tempfield, fieldname, err);
    Str(fieldname:len:decimal, tempfield);
    END;
  color(fgr, bgr);
  cursoroff;
  GoToXY(col, lin);
  IF NOT hiddenSC THEN Write(tempfield);
  GoToXY(col, lin);
  cursoron;
  hiddenSC := False;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE getdouble(VAR fieldname : Double; lin, col, len, decimal : Integer;
        inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer); }
  PROCEDURE getdouble;
  VAR picture : STRING[25];
    tempfield : STRING[25];
    err : Integer;
  BEGIN
  Str(fieldname:len:decimal, tempfield);
  IF length(tempfield) > len THEN
    BEGIN
    replicate(tempfield,len,'*');
    END;
  IF inpmode THEN
    BEGIN
    replicate(picture, len, '#');
    IF decimal > 0 THEN picture[len-decimal] := '.';
    getfield('B', tempfield, lin, col, len, picture, inpmode, fgr, bgr, lastkey);
    fixnum(tempfield);
    Val(tempfield, fieldname, err);
    Str(fieldname:len:decimal, tempfield);
    END;
  color(fgr, bgr);
  cursoroff;
  GoToXY(col, lin);
  IF NOT hiddenSC THEN Write(tempfield);
  GoToXY(col, lin);
  cursoron;
  hiddenSC := False;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE getyn(VAR fieldname : Boolean; lin, col : Integer;
        inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer); }
  PROCEDURE getyn;
  VAR yn: STRING[1];                  
  BEGIN
  IF fieldname THEN yn := 'Y' ELSE yn := 'N';
  getfield('Y', yn, lin, col, 1, 'Y', inpmode, fgr, bgr, lastkey);
  fieldname := (yn = 'Y');
  hiddenSC := False;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE critgetyn(VAR fieldname : Char; lin, col : Integer;
        inpmode : Boolean; fgr, bgr : Integer; VAR lastkey : Integer); }
  PROCEDURE critgetyn;
  VAR yn: STRING[1];                  
  BEGIN
  CASE fieldname OF
    'Y' : yn := 'Y';
    'N' : yn := 'N';
    ' ' : yn := ' ';
  END;
  getfield('Y', yn, lin, col, 1, 'Y', inpmode, fgr, bgr, lastkey);
  IF yn = 'Y' THEN fieldname := 'Y'
  ELSE IF yn = 'N' THEN fieldname := 'N'
  ELSE IF yn = ' ' THEN fieldname := ' ';
  hiddenSC := False;
  END;

  {---------------------------------------------------------------------------}
  { FUNCTION get_value(fieldname : str255SC; nthstring : Integer) : str80SC; }
  FUNCTION get_value;
    { Find the nth string in field name by counting the delimiters }
    { the string must be of the form '*xxx*yyy*abc*' so the 3rd string is 'abc' }
  VAR i, j : Integer;
    delim : Char;
  BEGIN
  i := 1;
  delim := fieldname[1];
  j := Pos(delim, fieldname); { is string empty ? }
  IF j > 0 THEN fieldname[j] := #0; { 0 out the first delimiter }

  WHILE (i < nthstring) AND (j > 0) DO
    BEGIN
    j := Pos(delim, fieldname);
    IF j > 0 THEN fieldname[j] := #0;
    IF (Pos(delim, fieldname)-j) > 1 THEN i := i+1; { if the item is not null }
    END;

  IF j > 0 THEN
    BEGIN
    i := Pos(delim, fieldname);
    get_value := Copy(fieldname, j+1, i-j-1);
  END ELSE
    BEGIN
    get_value := '';
    END;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE getupfield(lincol: lincolarrSC); }
  PROCEDURE getupfield;
    { Gets the Moves to the field in the above line. Uses logic to determine
    which is the best field to goto }
  VAR bestfld, i : Integer;
    curcol, curlin, curlen : Byte;
    numfields : Byte;
  BEGIN
  curlin := lincol^[fieldnumSC, 1]; { Set current field line, col, and len}
  curcol := lincol^[fieldnumSC, 2]+exitcursorSC-1;
  curlen := lincol^[fieldnumSC, 3]-exitcursorSC+1;
  numfields := lincol^[0, 1];
  bestfld := 0;
  FOR i := 1 TO numfields DO
    IF (lincol^[i, 1] <>  $FF) THEN
      IF bestfld = 0 THEN
        BEGIN                 {Get first acceptable field}
        IF lincol^[i, 1] < curlin THEN bestfld := i;
        END
      ELSE
        IF (lincol^[i, 1] > lincol^[bestfld, 1]) {If new field line is closer}
        AND (lincol^[i, 1] < curlin) THEN
          bestfld := i
        ELSE                  {If field are on same line}
          IF lincol^[i, 1] = lincol^[bestfld, 1] THEN
            IF (lincol^[i, 2] <= curcol) AND (lincol^[bestfld, 2] <= curcol) THEN
              BEGIN
              IF lincol^[i, 2] > lincol^[bestfld, 2] THEN bestfld := i;
              END
            ELSE
              IF (lincol^[i, 2] >= curcol) AND (lincol^[bestfld, 2] >= curcol) THEN
                BEGIN
                IF lincol^[i, 2] < lincol^[bestfld, 2] THEN bestfld := i;
                END
              ELSE
                IF (lincol^[i, 2] < lincol^[bestfld, 2]) THEN
                  BEGIN
                  IF ((lincol^[i, 2]+lincol^[i, 3]) > curcol)
                  OR ((curcol+curlen-1) < lincol^[bestfld, 2]) THEN bestfld := i;
                  END
                ELSE
                  IF ((lincol^[bestfld, 2]+lincol^[bestfld, 3]-1) < curcol)
                  AND ((curcol+curlen-1) > lincol^[i, 2]) THEN bestfld := i;
  IF bestfld <> 0 THEN fieldnumSC := bestfld;
  END;

  {---------------------------------------------------------------------------}
  {PROCEDURE getdownfield(lincol : lincolarrSC);}
  PROCEDURE getdownfield;
    { Gets the fieldnumSC of the field in line below. Uses logic to determine.
    which is the best field to goto }
  VAR bestfld, i : Integer;
    curcol, curlin, curlen : Byte;
    numfields : Byte;
  BEGIN
  curlin := lincol^[fieldnumSC, 1]; { Set current field line, col, and len}
  curcol := lincol^[fieldnumSC, 2]+exitcursorSC-1;
  curlen := lincol^[fieldnumSC, 3]-exitcursorSC+1;
  numfields := lincol^[0, 1];
  bestfld := 0;
  FOR i := 1 TO numfields DO
    IF (lincol^[i, 1] <>  $ff) THEN
      IF bestfld = 0 THEN
        BEGIN
        IF lincol^[i, 1] > curlin THEN bestfld := i;
        END
      ELSE
        IF (lincol^[i, 1] < lincol^[bestfld, 1]) {If new field line is closer}
        AND (lincol^[i, 1] > curlin) THEN
          bestfld := i
        ELSE
          IF lincol^[i, 1] = lincol^[bestfld, 1] THEN {If fields on same line}
            IF (lincol^[i, 2] >= curcol) AND (lincol^[bestfld, 2] >= curcol) THEN
              BEGIN
              IF lincol^[i, 2] < lincol^[bestfld, 2] THEN bestfld := i;
              END
            ELSE
              IF (lincol^[i, 2] <= curcol) AND (lincol^[bestfld, 2] <= curcol) THEN
                BEGIN
                IF lincol^[i, 2] > lincol^[bestfld, 2] THEN bestfld := i;
                END
              ELSE
                IF (lincol^[i, 2] < lincol^[bestfld, 2]) AND
                ((lincol^[i, 2]+lincol^[i, 3]-1) >= curcol) THEN bestfld := i
                ELSE
                  IF (lincol^[bestfld, 2]+lincol^[bestfld, 3]-1) < curcol THEN
                    bestfld := i;
  IF bestfld <> 0 THEN fieldnumSC := bestfld;
  END;

  {---------------------------------------------------------------------------}
  {PROCEDURE getleftfield(lincol : lincolarrSC);}
  PROCEDURE getleftfield;
  { Gets the fieldnumSC to the left of the current one on the same line.
  Uses logic to determine which is the best field to goto. }
  VAR
    bestfld, i : Integer;
    curcol, curlin : Byte;
    numfields : Byte;
  BEGIN
  curlin := lincol^[fieldnumSC, 1]; { Set current field line, col, and len}
  curcol := lincol^[fieldnumSC, 2];
  numfields := lincol^[0, 1];
  bestfld := 0;
  FOR i := 1 TO numfields DO
    IF (lincol^[i, 1] <>  $ff) THEN
    IF bestfld = 0 THEN
      BEGIN
      IF (lincol^[i, 1] < curlin) OR ((lincol^[i, 1] = curlin)
      AND (lincol^[i, 2] < curcol)) THEN bestfld := i;
      END
    ELSE
      BEGIN
      IF (lincol^[i, 1] < curlin) OR ((lincol^[i, 1] = curlin)
      AND (lincol^[i, 2] < curcol)) THEN

        IF (lincol^[i, 1] > lincol^[bestfld, 1]) THEN
          bestfld := i
        ELSE
          IF (lincol^[i, 1] = lincol^[bestfld, 1]) AND
          (lincol^[i, 2] > lincol^[bestfld, 2]) THEN
            bestfld := i;
      END;
  IF bestfld <> 0 THEN fieldnumSC := bestfld;
  END;

  {---------------------------------------------------------------------------}
  { PROCEDURE getrightfield(lincol: lincolarrSC); }
  { Gets the fieldnumSC to the right on the same line. Uses logic to determine
  which is the best field to goto. }
  PROCEDURE getrightfield;
  VAR
    bestfld, i : Integer;
    curcol, curlin : Byte;
    numfields : Byte;
  BEGIN
  curlin := lincol^[fieldnumSC, 1]; { Set current field line, col, and len}
  curcol := lincol^[fieldnumSC, 2];
  numfields := lincol^[0, 1];
  bestfld := 0;
  FOR i := 1 TO numfields DO
    IF (lincol^[i, 1] <>  $ff) THEN
      IF bestfld = 0 THEN
        BEGIN
        IF (lincol^[i, 1] > curlin) OR ((lincol^[i, 1] = curlin)
        AND (lincol^[i, 2] > curcol)) THEN bestfld := i;
        END
      ELSE
        BEGIN
        IF (lincol^[i, 1] > curlin) OR ((lincol^[i, 1] = curlin)
        AND (lincol^[i, 2] > curcol)) THEN

          IF (lincol^[i, 1] < lincol^[bestfld, 1]) THEN
            bestfld := i
          ELSE
            IF (lincol^[i, 1] = lincol^[bestfld, 1]) AND
            (lincol^[i, 2] < lincol^[bestfld, 2]) THEN
              bestfld := i;
        END;
  IF bestfld <> 0 THEN fieldnumSC := bestfld;
  END;

{-----------------------------------------------------------------------------}
procedure AddExitKey(key :Integer);
{-----------------------------------------------------------------------------}
    VAR ikey :integer;
begin

    { Adds a new key to the list of "exit keys" -- keys that exit from a }
       { getfield routine.  This array always terminates its key list with a 0 }
       { So it can be used with the function inarray().  The actual number of
       { keys it can therefore hold is really MaxExitKeysSC - 1}

       if ExitKeysSC.Count < MaxExitKeysSC -1 then begin
        inc(ExitKeysSC.Count);
           ExitKeysSC.Keys[ExitKeysSC.Count]   := key;
           ExitKeysSC.Keys[ExitKeysSC.Count+1] := 0
    END
    ELSE BEGIN
        { If this message occurs, you should increase the size   }
        { of the keysSC[] array by a defining a larger value for }
        { MaxExitKeysSC.  This is in TPPROCS.PAS                 }
        dispmessage('AddExitKey : Too many field exit keys, increase size of keysSC[]');
        inkey(ikey);
        clearmessage;
    END
end;

Procedure SendCmd (cmd:string);
var
  r:registers;
  i:byte;
begin
  fillchar(r,sizeof(r),0);   {initialize to 0}
  r.bx:=7;
  for i:=1 to length(cmd) do
  begin
    r.ax:=9*256+ord(cmd[i]);
    r.cx:=1;
    intr($10,r);
  end
end;



{---------------------------------------------------------------------------}
BEGIN
        { Perform some initializations }
        ExitKeysSC.Count := 0;

        { Initialize the ExitKeysSC array with the Keys that will cause a }
        { field exit. If you wish to add to this list, follow the pattern.}
        { You can also add to this list from the Main Program. }
        AddExitKey(escSC);
        AddExitKey(LeftSC);
        AddExitKey(HomeSC);
        AddExitKey(PgUpSC);
        AddExitKey(ShftTabSC);
        AddExitKey(UpSC);
        AddExitKey(RightSC);
        AddExitKey(EndSC);
        AddExitKey(CtrlPgDnSC);
        AddExitKey(EnterSC);
        AddExitKey(TabSC);
        AddExitKey(DnSC);
        AddExitKey(PgDnSC);
        AddExitKey(PgUpSC);
        AddExitKey(LeftSC);
        AddExitKey(RightSC);
        AddExitKey(DelSC);
        AddExitKey(InsertSC);
        AddExitKey(HomeSC);
        AddExitKey(BackSC);
        AddExitKey(AltCSC);
        AddExitKey(CtrlHomeSC);

END.
