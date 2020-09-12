unit comunit;  { registered version }

interface


  CONST
    home    = 1;
    clrhome = 2;
    flushleft = 3;
    ShadyBrook = 8;

  TYPE
    str80 = string[80];

    ENCTYPE=String[185];
    FIXEDONE=String[160];
    I=Array[1..26,1..45] of longint;
    S=Array[1..26,1..9] of String[40];
    TI=Array[1..25,1..19] of Integer;
    TS=Array[1..25,1..14] of str80;
    AD=Array[1..30] of String[10];
    MO=Array[1..42] of String[12];
    WE=Array[1..21,1..2] of String[13];
    SY=Array[1..8] of String[80];
  VAR
    carcount : integer;
    USERI:I;
    USERS:S;
    TOWNI:TI;
    TOWNS:TS;
    ADJECTIVE:AD;
    MONSTER:MO;
    WEAPON:WE;
    S_STUFF:SY;
    CHEAT1:Byte;
    GMMSG,DEATH,DAYS,DAYSS,LOP,DPATH,TPATH,MASTERS,MONTH,CMONTH,DREAM,RIDDLES,
    RANDCLOTH,AB_WOR:str80;
    todayEventsFileName : str80;
    yesterdayEventsFileName : str80;
    CHEAT5:Byte;
    BSTEAL:String[40];
    CHEAT2:Byte;
    NUMTOT,NUMTOTO,LN1,LN1O,LN2,LN2O,LN3,LN3O:ENCTYPE;
    BDATE:String[10];
    CHEAT3:Byte;
    eventsFile : text;
    CHEAT6,CHEAT7:Byte;
    sysopm : integer;
    NUM,CAR,GM,RCOUNT,JDFH,NUNUM,C_MONSTER,C_ADJECTIVE,ELEMENT,HULL,WIND,TAVSTEAL,XXX:Integer;
    SUN,LDATE,COMP1,COMP2,PEOPLES,PROG,COMPTEST,DUES,PIRCHECK,STEALER:longint;
    GT,GTT,OVER,VT,UJAILL,SPCB,TOFF,SOFF,ABLE,TKILL,ISITOK,EMULATE,VIEWOK,MULT,TWISTY,LOCK,KEY,WATERS,
    HORN,FAIRY,LUCK,JOINED,MYSTIC,HALF,WON,PYRA,A_CRYPT,BOOGIE,DTREAS,OCE,WIZPOT,MAINP,MITCH,DOUBCHECK:Boolean;
    CHEAT4:Byte;
    bbsname : str80;
    ANSI, BOLD, FLASH : boolean;
    ansix, ansiy : integer;


    error : boolean;
    inTitle : boolean;
    registered : boolean;

implementation


begin
  registered := FALSE;  { set registered by default to false! }
end.