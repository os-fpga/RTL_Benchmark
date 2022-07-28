#!/bin/bash
# Xanthopoulos Constantinos
# Some useful function for my scripts

function cecho
{
	 echo -e "\033[1m\033[33m$1\033[0m"
}

function errormsg
{	
	echo -e "\033[1m\033[31mError: $1\033[0m\n";
	exit 1;
}

function readpass
{
        stty_orig=`stty -g`
        stty -echo
        read `echo $1`
        stty $stty_orig
}

function execcmd
{
        # Print Message
        echo -e "\033[35m$1\033[0m"
        # Execute command
        echo $2
        if [ $DEBUG -ne 1 ];
	then
		eval $2;
	fi;
        # Check Execution
        if [ $? -eq 0 ]
        then
                echo -e "\033[32mSuccessfully \"$1\"\033[0m\n";
        else
               	errormsg "$1"; 
                exit 1;

        fi
}

function changelinefile
{
        a=0;
        b=0;
        sed -e "s/$1/$2/" $3 > /tmp/changedfile;
        if [ $? -eq 0 ]
        then
                a=1;
        fi
        mv /tmp/changedfile $3;
        if [ $? -eq 0 ]
        then
                b=1;
        fi
        execcmd "Change file $3" "test $a -eq 1 -a $b -eq 1"
}

if [ $DEBUG -eq 1 ]
then
	cecho "Debug mode on! Nothing will actually run";
fi
