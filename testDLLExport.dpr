program testDLLExport;

uses Windows, sysutils;

const
  DLL_PATH= '.\testDLLExport\bin\Debug\x86\testDLLExport.dll';

procedure TestReturnString(var stringDelphi: WideString); cdecl; external DLL_PATH;



type
  TProcCallback = procedure (p_int: integer);  cdecl;

//function DoSendCallbackFunction(ptr:Pointer): integer; cdecl; external 'DraminskiComLibrary.dll';
function DoSendCallbackFunction(ptr:TProcCallback): integer; cdecl; external DLL_PATH;


type
  TProcCallbackWithString = procedure (p_str: WideString);  cdecl;
function DoSendCallbackFunctionWithString(ptr:TProcCallbackWithString): integer; cdecl; external DLL_PATH;


var
  str: WideString;


procedure TestCallbacFunction(p_int: integer); cdecl;
begin
   Writeln('p_int = ',p_int);
end;


procedure TestCallback;
begin
  DoSendCallbackFunction(TestCallbacFunction);
end;


procedure TestCallbacFunctionWithString(p_str: WideString); cdecl;
begin
   Writeln('p_str = ',p_str);
end;



begin
  Allocconsole;
  Writeln('DELPHI->BEGIN');

  Writeln('DELPHI->Return string from c#');
  TestReturnString(str);
  Writeln('DELPHI->Str=',str);

  DoSendCallbackFunction(TestCallbacFunction);

  TestCallback;


  DoSendCallbackFunctionWithString(TestCallbacFunctionWithString);

  Writeln('DELPHI->END');
  readln;
end.