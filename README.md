This is a homework from the course computer-science basics of Mr. Benoist at the Berne Univercity of applied science in Switzerland.

The following  is the official description from our teacher Mr. Benoist (http://www.benoist.ch)

<h1>Homework, Assembly Language</h1>


<h2>REMARK</h2>
  One is not allowed to use 128-bit registers XMM0 to XMM7!
<h2>A library for long long unsigned integers </h2>  
The goal of this work is to provide a library that
implements very long unsigned integers (128-bit) in assembly language. You will also provide a program that tests the procedures from another file.<br /> 

The idea is to provide a library for working with very large unsigned
numbers (we call them long long integers). You will provide procedures
for all the basic functionalities expected for such elements. You have
to write procedures for addition, multiplication, and subtraction. You
also have to write two procedures for reading from the standard input
and writing to the standard output a number in hexadecimal form.<br />

Numbers are written in memory (on 16 bytes) using the "little endian"
convention. The arguments for the procedures will always be the
addresses of the numbers (the numbers are too large to be written in a
register).

<h2>Work to be done</h2>

You need to provide a file <code>mylongintlib.asm</code> that is
written in Assembly language for 64 bit linux. This file will contain
the following features:

<ul>
  <li>A procedure <code>addition</code>, that implements the 
  addition of two long long integers. Input: the addresses of 
  two long long numbers in RDI and RSI. Output: the result is written 
  in the long long number at address in RDI. </li>
  <li>A procedure <code>subtraction</code>, that implements the 
  subtraction of two long long integers. If the second number is larger
  than the first, the result is 0. Input: the addresses of 
  two long long numbers in RDI and RSI. Output: the result is written 
  in the long long number at address in RDI.  </li>
  <li>A procedure <code>multiplication</code>, that implements the 
  multiplication of two long long integers. Input: the addresses of 
  two long long numbers in RDI and RSI. Output: the result is written 
  in the long long number at address in RDI. If the size of the output should
  be larger than 128 bits, you will only use the 128-bits (lowest
  weight) and set the overflow flag (<code>OF</code>).</li>
<li>A procedure <code>readlonglong</code> that reads on the standard
  input (stdin) an hexadecimal number and writes it inside the
  memory. The input <code>RDI</code> of the procedure contains the address in
  memory where to write the number. This procedure uses a 64-bit
  <code>syscall</code> (not the C library).</li>
  
<li>A procedure <code>writelonglong</code> writes a long long number on the
  standard output in hexadecimal form. The input of the procedure is
  the value in <code>RDI</code>, it contains the address of the long
  long integer to be written. This procedure contains also a 64-bit
  <code>syscall</code> and not the C library.</li>

  <li>A procedure <code>copylonglong</code> that copies a long long
  number into another place in memory. This procedures receives as an
  input <code>RDI</code> and <code>RSI</code>. In <code>RDI</code> you
  have the address of the original number. In <code>RSI</code> you
  have the address of the copy. You copy the original number into the
  copy.</li>
  
</ul> 
In this file, the procedures will be made <code>global</code> to be
accessed from another file.<br />

You also need to write a file containing a test program <code>testlonglong.asm</code>. In this file
you need to declare the different procedures of your library as
<code>extern</code> in order to use them. You need to test your
library within your program. You have to implement the following
features. The outputs will be written using the C function
<code>printf</code>.
<br />
Your test program should do the following tasks:
<ul>
  <li>Reserve place in memory (BSS) for the following long long
  numbers (each time 128-bit numbers): X, Y, Z, R, S, T.</li>
  <li>Ask the user to enter a long long number X</li>
  <li>Ask the user to enter a long long number Y</li>
  <li>Ask the user to enter a long long number Z</li>
  <li>Copy X into a long long number R</li>
  <li>Copy Y into a long long number S</li>
  <li>Copy Z into a long long number T</li>
  <li>Do the following computations:
<pre>
X = X + Y
print X and Y
X = X - Y  
print X and Y  
R = R - S
print R and S
T = T * Z
print T and Z
</pre>
  </li>
</ul>

You need to compile both assembly language files into .o files and
then, you need to link them together.


<h2>Exercise</h2>

You have to write the two assembly language files: one for the library
and one for testing the library.
<br />
The output is written in the standard output (also like in all our
exercises)
<br />

This exercise is to be done in a group of two students. If a class has
an odd number of students, one student will work alone.
<br />
The program must be written in Assembly language, the only exception
is the use of the C function <code>printf()</code>, and maybe <code>scanf()</code>, inside the test
program (the functions are not allowed inside the library).

<br />
Deadline: 23rd of December 2016, the students must send to the
professor a zip file containing a directory with the two assembly files and
a makefile for compiling them. 
