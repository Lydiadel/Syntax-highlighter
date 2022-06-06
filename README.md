# Syntax highlighter

## Author
Lydia Delgado Uriarte

## Overview
Determine the lexical categories of different language programs, in this case **Python**,**C++** and **Javascript**.
Scan lexical elements by implementing a regular expression engine called **FLEX**. 

## Run the program
Compile the file lexico.l 
```
flex lexico.l
```
Then it generates a lexico.cpp so we run it with the main, lexico.cpp includes FlexLexer.h
```
g++ main.cpp lexico.cpp
```
This generates an a.out, this is the output of both files compiiled so we run it 
```
./a.out
```
With all off his we get the final result that is the page.html which includes the visual representation, using design.css to be more visual appealing.

## Technologies used
- Html
- Css
- C++
- Flex

