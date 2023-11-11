# Mike Compiler

- It comprised of two phases:
  - Lexical Analyzer
  - Parser

## Steps to run

Only `flex` and `bison` are required to be installed on your machine. The code has been tested last on Ubuntu 20.04.

```bash
sudo apt install flex
sudo apt install bison
```

Then run:

```bash
bison -d parser.y
flex lexical_analyzer.l
gcc -o compiler parser.tab.h parser.tab.c lex.yy.c -ll
./compiler
```

## Team Members

- Negar Nadian ([@negarndn](https://github.com/negarndn))
- Parisa Shahabi ([@parissashahabi](https://github.com/parissashahabi))
- Nafiseh Momeni ([@nafis-momeni](https://github.com/nafis-momeni))
