# Knockout Arcade

## GML Style Guide

## Table of Contents
* [Source Code Layout](#source-code-layout)
* [Syntax](#syntax)
* [Naming](#naming)
* [Comments](#comments)

## Source Code Layout
Tabs Vs Spaces: I don't care what you do in your spare time, use tabs here for consistency.
* Use hard tabs.
```c
// bad - four spaces
if(something)
{
    do_things();
}

// bad - two spaces
if(something)
{
  do_things();
}

// good (uses a tab, I know you can't tell)
if(something)
{
    do_things();
}
```

* Don't use `;` to seperate statements and expressions on a single line. Use one expression per line.
```c
// bad
update_image(); handle_gravity();

// good
update_image();
handle_gravity();
```

## Syntax
* **Conditionals** (`if/else/else if`) use the same block structure. The `{` & `}`  are used to explicitly state the enclosing body.
  * The condition should ***always*** be enclosed within `(` `)`
```c
// bad
if(test_truthy)
  {
  ...
  }

// bad
if test_truthy doSomething();

// good
if(truthiness)
{
  ...
}
```
* Use `!` instead of `== false`
```c
// bad
if(jumping == false)
{
  ...
}

// good
if(!jumping)
{
  ...
}
```
* Similarly never use `== true`
```c
// bad
if(falling == true)
{
  ...
}

// good
if(falling)
{
  ...
}
```

* **Simple Operations** (i=i+1, i+=1, i++) should always use the optimal pattern.
```c
// bad
i = i + 1; // should only be used for complex arithmatic that cannot be reduced to a more efficient pattern.

// good
i += 1; // best used when adding a single constant or variable other than 1 

// better
i++; // optimal when incrementing a variable by one.
```
* The same applies for subtraction (i=i-1, i-=1, and i--);

## Naming
* **variables** should be camelcase with a leading lowercase.
  * Names should be descriptive, ***no abbreviations ever, under any circumstances***
```c
// bad
tablename
tblname
tblnm

// bad
table_name
tbl_nm

// good
tableName
```

* **functions** should be named using mixed case (camelcase with leading upper case)
```c
// bad
function thisfunction()
{
    ...
}

// good
function ThisFunction()
{
    ...
}
```

* **objects** should be named with `o` prefix, camelcasing with the variable name
```c
// bad
o_box
object_box
box
obj_box

// good
oBox
```

* **sprites** should be named with `s` prefix, camelcasing with the variable name
```c
// bad
s_box
sprite_box
box
spr_box

// good
sBox
```

* **backgrounds** should be named with `b` prefix, camelcasing with the variable name
```c
// bad
b_box
background_box
box
bg_box

// good
bBox
```


* **macros** whose value is fixed for the duration of the program, should be named using all caps.
```c
// bad
out_of_memory = 1
outofmemory = 1

// good
OUTOFMEMORY = 1
```

* **enumerators** should be named like macros, using all caps. The enumeration name should use mixed case. 
```c
// bad
enum rainbowColors
{
  red = 1,
  blue = 2
}

// good
enum RainbowColors
{
  RED = 1,
  BLUE = 2
}
```

## Comments

* Write self-documenting code!!
* Write comments in English
* Use one space between the leading `//` and the comment text
* Avoid superfulous comments
```c
// bad
counter += 1 // increment counter by 1
```
* Keep comments up-to-date. An outdated comment is worse than no comment at all
* Avoid writing comments to explain bad code. Refactor the code to make it self-explanatory