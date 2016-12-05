#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Ask the user to enter a long long number X
# Ask the user to enter a long long number Y
# Ask the user to enter a long long number Z
# Copy X into a long long number R
# Copy Y into a long long number S
# Copy Z into a long long number T
# X = X + Y
# print X and Y
# X = X - Y
# print X and Y
# R = R - S
# print R and S
# T = T * Z
# print T and Z

print "Enter x"
x=int(raw_input("input your hex number -> "),16)
print "Enter y"
y=int(raw_input("input your hex number -> "),16)
print "Enter z"
z=int(raw_input("input your hex number -> "),16)

def exercise(x,y,z):
    print "Copy X into a long long number R"
    r = x
    print "Copy Y into a long long number S"
    s = y
    print "Copy Z into a long long number T"
    t = z

    print("X = X + Y")
    x = x+y
    print "X: " + hex(x)
    print "Y: " + hex(y)

    print("X = X - Y")
    x = x-y
    print "X: " + hex(x)
    print "Y: " + hex(y)

    print "R = R - S"
    r = r-s
    print "R: " + hex(r)
    print "S: " + hex(s)

    print "T = T * Z"
    t = (t * z)%pow(2,128)
    print "T: " + hex(t)
    print "Z: " + hex(z)

    print "FINITO"
    return

exercise(x,y,z)
