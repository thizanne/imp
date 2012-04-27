open Parser

let string_of_token = function
  | True -> "True"
  | False -> "False"
  | Not -> "Not"
  | And -> "And"
  | Or -> "Or"
  | Greater -> "Greater"
  | Equal -> "Equal"
  | LeftPar -> "LeftPar"
  | RightPar -> "RightPar"
  | LeftCurly -> "LeftCurly"
  | RightCurly -> "RightCurly"
  | Affect -> "Affect"
  | If -> "If"
  | While -> "While"
  | Print -> "Print"
  | Plus -> "Plus"
  | Times -> "Times"
  | Minus -> "Minus"
  | Int n -> "Int " ^ string_of_int n
  | Var v -> "Var " ^ v
  | Eof -> "Eof"

let lexbuf = Lexing.from_channel (open_in Sys.argv.(1))

let rec print_code lexbuf =
  let t = Lexer.lexer lexbuf in 
    print_endline (string_of_token t);
    if t <> Eof then print_code lexbuf

let () =  print_code lexbuf
