%{
(* Here can come OCaml code *)
%}

%token True False Not And Or
%token Greater Equal
%token LeftPar RightPar LeftCurly RightCurly
%token Affect
%token If While Print
%token Plus Times Minus
%token <int> Int
%token <string> Var
%token Eof

%start <Ast.command> prgm

%left Or
%left And
%nonassoc Not
%left Plus Minus
%left Times
%nonassoc neg

%%

prgm:
| s = sequence Eof { s }

sequence:
| c = command { c }
| c = command s = sequence { Ast.Seq (c, s) }

command:
| v = Var Affect x = aexp { Ast.Affect (v, x) }
| Print x = aexp  { Ast.Print x }
| If b = bexp LeftCurly c = sequence RightCurly { Ast.If (b, c) }
| While b = bexp LeftCurly c = sequence RightCurly { Ast.While (b, c) }

aexp:
| x = Int { Ast.Int x }
| v = Var { Ast.Var v }
| x = aexp Plus y = aexp { Ast.Plus (x, y) }
| x = aexp Minus y = aexp { Ast.Minus (x, y) }
| x = aexp Times y = aexp { Ast.Times (x, y) }
| Minus x = aexp  { Ast.Neg x } %prec neg
| LeftPar x = aexp RightPar { x }

bexp:
| True { Ast.True }
| False { Ast.False }
| x = aexp Equal y = aexp { Ast.Equal (x, y) }
| x = aexp Greater y = aexp { Ast.Greater (x, y) }
| a = bexp And b = bexp { Ast.And (a, b) }
| a = bexp Or b = bexp { Ast.Or (a, b) }
| Not b = bexp { Ast.Not b }
| LeftPar b = bexp RightPar { b }
