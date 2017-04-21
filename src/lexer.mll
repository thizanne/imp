{
  open Parser
  exception LexingError
}

let digits = ['0' - '9']
let alpha = ['a' - 'z' 'A' - 'Z']
let empty = ['\n' '\t' ' ']

rule lexer = parse
  | "//" [^'\n']* '\n'? { lexer lexbuf }
  | "/*" { comment 1 lexbuf }
  | eof { Eof }
  | empty+ { lexer lexbuf }
  | "true" { True }
  | "false" { False }
  | "not" { Not }
  | "and" { And }
  | "or" { Or }
  | "if" { If }
  | "while" { While }
  | "print" { Print }
  | "(" { LeftPar }
  | ")" { RightPar }
  | "{" { LeftCurly }
  | "}" { RightCurly }
  | "+" { Plus }
  | "*" { Times }
  | "-" { Minus }
  | ">" { Greater }
  | "=" { Equal }
  | ":=" { Affect }
  | digits+ as n { Int (int_of_string n) }
  | alpha (alpha | digits)* as v { Var v }

and comment depth = parse
  | "/*" { comment (depth + 1) lexbuf }
  | "*/" { 
    if depth = 1 then lexer lexbuf 
    else comment (depth - 1) lexbuf
  }
  | eof { raise LexingError }
  | _ { comment depth lexbuf }
