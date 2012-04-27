open Ast
type env = (string * int) list

let rec update (e : env) v x = match e with
  | [] -> [(v, x)]
  | (w, y) :: s -> 
    if v = w then (v, x) :: s
    else (w, y) :: update s v x


let rec eval_prgm env = function
  | Affect (v, x) -> update env v (eval_aexp env x)
  | Print x -> print_int (eval_aexp env x); print_newline (); env
  | If (b, c) -> 
    if eval_bexp env b then eval_prgm env c else env
  | While (b, c) as w -> 
    if eval_bexp env b then let e = eval_prgm env c in eval_prgm e w else env
  | Seq (c1, c2) -> let e = eval_prgm env c1 in eval_prgm e c2

and eval_bexp env = function
  | True -> true
  | False -> false
  | And (a, b) -> eval_bexp env a && eval_bexp env b
  | Or (a, b) -> eval_bexp env a || eval_bexp env b
  | Not a -> not (eval_bexp env a)
  | Equal (x, y) -> eval_aexp env x = eval_aexp env y
  | Greater (x, y) -> eval_aexp env x > eval_aexp env y

and eval_aexp env = function
  | Int x -> x
  | Var v -> List.assoc v env
  | Neg x -> - (eval_aexp env x)
  | Minus (x, y) -> eval_aexp env x - eval_aexp env y
  | Plus (x, y) -> eval_aexp env x + eval_aexp env y
  | Times (x, y) -> eval_aexp env x * eval_aexp env y


let _ = 
  eval_prgm [] (Parser.prgm Lexer.lexer (Lexing.from_channel (open_in Sys.argv.(1))))
