# Imp

TARGET=eval
COMPILE=ocamlc
BUILD=ocamlbuild
FLAGS=-use-menhir -cflags "-w -8"

.PHONY: clean all mrproper

all : 
	$(BUILD) $(FLAGS) $(TARGET).native

clean :
	rm -f a.out
	rm -f parser.conflicts
	rm -f parser.mli
	rm -f parser.ml
	rm -f *.a
	rm -f *.cma
	rm -f *.cmo
	rm -f *.cmi
	rm -f *.cmx
	rm -f *.cmxa
	rm -f *.o
	rm -rf _build/

mrproper : clean
	rm -f *.native
	rm -f *.byte


# The following rules should not be used apart from test purpose

ast : 
	$(COMPILE) -c ast.ml

lexer.ml :
	ocamllex lexer.mll

lexer : lexer.ml parser
	$(COMPILE) -c lexer.ml

lex :
	$(BUILD) $(FLAGS) lex.native

parser.ml : ast
	menhir --infer --explain parser.mly

parser : parser.ml
	$(COMPILE) -intf parser.mli -c parser.ml
