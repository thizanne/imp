type command = 
  | Affect of string * aexp
  | Print of aexp
  | If of bexp * command
  | While of bexp * command
  | Seq of command * command

and aexp =
  | Int of int
  | Var of string
  | Minus of aexp * aexp
  | Neg of aexp
  | Plus of aexp * aexp
  | Times of aexp * aexp


and bexp =
  | And of bexp * bexp
  | Equal of aexp * aexp
  | False
  | Greater of aexp * aexp
  | Not of bexp
  | Or of bexp * bexp
  | True
