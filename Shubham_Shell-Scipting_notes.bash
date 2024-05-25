we need to use 
#!/bin/bash      --> default shell so use 

1. echo "Hello" --- this used to print on terminal

How to run script:
------------------
ubuntu@ip-172-31-26-55:~/shell_practice$ ls -ltr
-rw-rw-r-- 1 ubuntu ubuntu 59 May 20 11:25 01_basic.sh

need to give execute permission to run it

run using
./script.sh
/path/script.sh

bash 01_basic.sh  ---> permission not give then we can use bash to run the script

**Comments:
===========
# --> use for single line Comments

==============================================================================================================================================================
####Variables:
===============
to use Variables us $ always

2. cat 02_variables_basic.sh 
--------------------------------
#!/bin/bash

#This is variable use case

a=10
name="Shubham"
age=29

<<comments
This is multiline comment.
so fot multine comment we use (<<)
comments

#Now we are using above vaiables

echo "My name is $name and my age is $age"

O/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 02_variables_basic.sh 
My name is Shubham and my age is 29

---> if you don't want to change the variable then use readonly before it

==============================================================================================================================================================

###Arrays:
===========
(if you want to store multiple values then many variables are req'd for that and it is not feasible at all so in this case we use Array to store multiple values)

3. vi 03_Array.sh 
--------------------
#!/bin/bash

#Array Practice:

#To create an Array use following. In array values should be space separated:

myArray=( 1 2 Hello 30.5 "hey bro!!" "You can do it" )

#To print all the values inside the array. syntax: ${name_of_array[*]}
echo "all values in array are : ${myArray[*]}"

#To print only 3rd value in array
echo "only print value of 3rd index : ${myArray[3]}"

#To check to find no of values in array we use # before the array name
echo "The lenth of the array is ${#myArray[*]}"

#To find specific values, range of values
echo "values from index 2 and 4 : ${myArray[*]:2:2}"

#updating the array with new values
myArray+=( New 30 40 )

echo "Values of New Array ${myArray[*]}"
==============================================================================================================================================================
	
4. vi 04_key-value.sh 
----------------------
#Array key-value pair:
ubuntu@ip-172-31-26-55:~/shell_practice$ cat 04_key-value.sh
#!/bin/bash

#How to store key-value pairs
declare -A myArray

myArray=( [name]="Shubham" [age]=29 [city]=Pachora)

echo "My name is ${myArray[name]}"
echo "My age is ${myArray[age]}"

O/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 04_key-value.sh 
My name is Shubham
My age is 29
==============================================================================================================================================================
*****STRING Oeration:
------------------------
5. vi 05_string_op.sh

#!/bin/bash

myArray="Hey Buddy, How are You?"

echo "length of the array is : ${#myArray}"

#To make Uppaer and lower case using string operation.
echo "Upper case is ----> ${myArray^^}"
echo "Lower case is ----> ${myArray,,}"

O/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 05_string_op.sh 
length of the array is : 23
Upper case is ----> HEY BUDDY, HOW ARE YOU?
Lower case is ----> hey buddy, how are you?
==============================================================================================================================================================
#awk command:
-------------
syntax: awk '{}' file_name
E.g
awk '{print $1,$2,$4}' app.log 
awk '/INFO/ {print $1,$2,$3,$5}' app.log --> to print INFO from the files

#to find out the count:
1. count of INFO word
ubuntu@ip-172-31-26-55:~/awk_practice$ awk '/INFO/ {count++} END {print count}' app.log 
72

2. count of ip address
awk '/INFO/ {count++} END {print "The count of INFO is", count}' app.log 
The count of INFO is 72

awk '/9.67.116.98/ {count++} END {print "The count of IP address is",count}' app.log 
The count of IP address is 5

3. Range find out:
awk '$2 >= "08:51:01" && $2 <= "08:52:50" {print $1,$2,$3}' app.log

4. No. of Rows NR>=2 && NR <=10 --> this will print rows between 2 to 10
Command 1:
awk 'NR >=2 && NR <=10' app.log 
 01 
03/22 08:51:01 INFO   :.main: *************** RSVP Agent started ***************
 02 
03/22 08:51:01 INFO   :...locate_configFile: Specified configuration file: /u/user10/rsvpd1.conf
03/22 08:51:01 INFO   :.main: Using log level 511
03/22 08:51:01 INFO   :..settcpimage: Get TCP images rc - EDC8112I Operation not supported on socket.
 03 
03/22 08:51:01 INFO   :..settcpimage: Associate with TCP/IP image name = TCPCS
03/22 08:51:02 INFO   :..reg_process: registering process with the system
----------------------------------------------------------------------------------------------------------------------------------------------------------
Command 2: this will print line no as well
awk 'NR >=2 && NR <=10 {print NR}' app.log 
2
3
4
5
6
7
8
9
10
----------------------------------------------------------------------------------------------------------------------------------------------------------
Command 3:
ubuntu@ip-172-31-26-55:~/awk_practice$ awk 'NR >=2 && NR <=10 {print NR,$2,$3}' app.log 
2  
3 08:51:01 INFO
4  
5 08:51:01 INFO
6 08:51:01 INFO
7 08:51:01 INFO
8  
9 08:51:01 INFO
10 08:51:02 INFO
----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------
*** sed command :
==================
for awk we need a formatted data, but sed (stream editor) --> we can edit real time straming data

Command 1: we need to use -n to limit the o/p
sed -n '/INFO/p' app.log 

diff 
1. syntyantical
2. awk work on structured data whereas sed work on line by line no matter whether it is structured or not

Command 2: we are replacing INFO with log by using the sed command
sed 's/INFO/LOG/g' app.log     						--> s/INFO/LOG/g means string (s) replace globally (g)

Command 3:to print line where INFO are appear. -e --> expression , /INFO/=  --> = to reprents the line no
sed -n -e '/INFO/=' app.log ---> print line no where INFO is apper
sed -n -e '/INFO/=' app.log ----> print line no where INFO is apper also it will print INFO line details

#now just want to replace INFO only for first 10 lines
sed '1,10 s/INFO/LOG/g' app.log 	

#in below command we are replacing first 10 lines (1,10 s/INFO/LOG/g;) then we print 1 to 10 lines (1,10p;) and then we are quitting at 11th line i.e 11q;
sed '1,10 s/INFO/LOG/g; 1,10p; 11q ' app.log 
----------------------------------------------------------------------------------------------------------------------------------------------------------
****grep command: global regular expression pattern
-i --> case insensitive
-c --> count 

grep -i info app.log 
grep -i -c info app.log 

#suppose we want only those process which are used by ubuntu user among from all the process
ps aux | grep ubuntu

ubuntu@ip-172-31-26-55:~/awk_practice$ ps aux | grep ubuntu
root        1016  0.0  1.1  16928 10752 ?        Ss   16:10   0:00 sshd: ubuntu [priv]
ubuntu      1361  0.0  0.9  17052  9472 ?        Ss   16:10   0:00 /lib/systemd/systemd --user
ubuntu      1362  0.0  0.5 103720  5408 ?        S    16:10   0:00 (sd-pam)
ubuntu      1462  0.0  0.8  17200  7956 ?        S    16:10   0:00 sshd: ubuntu@pts/0
ubuntu      1465  0.0  0.5   9284  5504 pts/0    Ss   16:10   0:00 -bash
ubuntu      1834  0.0  0.3  10464  3200 pts/0    R+   17:36   0:00 ps aux
ubuntu      1835  0.0  0.2   7008  2304 pts/0    S+   17:36   0:00 grep --color=auto ubuntu
---
ubuntu@ip-172-31-26-55:~/awk_practice$ ps aux | grep ubuntu | awk '{print $2}'
1016
1361
1362
1462
1465
1836
1837
1838
==============================================================================================================================================================
6.vi 06_string_2.sh
!/bin/bash
myArray="Hey Buddy, How are You?"

echo "length of the array is : ${#myArray}"

#to conver myArray in upper and lower case
echo "Upper case is : ${myArray^^}"
echo "Lower case is : ${myArray,,}"

#to replace a string - replacing Buddy with Sallu
echo "After Replace : ${myArray/Buddy/Sallu}"

#to slice a string
echo "After slice : ${myArray:4:5}"

O/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 06_string_2.sh 
length of the array is : 23
Upper case is : HEY BUDDY, HOW ARE YOU?
Lower case is : hey buddy, how are you?
After Replace : Hey Sallu, How are You?
After slice : Buddy
==============================================================================================================================================================
***User Interaction:
====================
Take input from user --> read <var_name> --> read -p "Your Name" Name
before using read use instruction for the same so it will more user friendly

7. vi 08_user_interaction.sh
#!/bin/bash

#taking i/p from user
read -p "User's name is :" name

echo "Your name is : $name"    

***Arithmatic Operations:
=========================
~~~by using #let command
let a++
let a=5*9

((a++))
((5*9))

ubuntu@ip-172-31-26-55:~/shell_practice$ cat 09_arthmatic_ops.sh 
#!/bin/bash

x=10
y=2

let mul=$x*$y
echo "$mul"

#by using (())
echo "Substraction is : $(($x-$y))"

o/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 09_arthmatic_ops.sh 
20
Substraction is : 8

==============================================================================================================================================================
***Conditional Statement:
---------------------------
Equal -eq / ==

Greaterthanorequalto -ge

Lessthanorequalto -le

Not Equal -ne / !=

Greater Than -gt

Less Than -lt
-------------------------------------------------------------------------------
10. vi 10_if-else.sh 
#!/bin/bash										--> This line tells the system that the script should be run using the Bash shell.

##Following line prompts the user to enter their marks. The read command takes the user's input and stores it in a variable called Marks.

read -p "Enter your Marks: " Marks				

##This line starts an if statement that checks if the value stored in Marks is greater than 40. The -gt stands for "greater than."
##also make sure when we are usiing [[  ]] after if Statement proper space should be there

if [[ $Marks -gt 40 ]]
then
        echo "You're Pass!!"
else
        echo "You're Fail!!!!"
fi

##The fi marks the end of the if statement.

O/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 10_if-else.sh 
Enter your Marks: 78
You're Pass!!
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 10_if-else.sh 
Enter your Marks: 39
You're Fail!!!!
---------------------------------------------
elif is used when we are having multiple Condition
11. vi 1_elif-demo.sh 
--------------------
#!/bin/bash

read -p "Enter your Marks: " marks

if [[ $marks -ge 80 ]]
then
        echo "1st Class!!"
elif [[ $marks -ge 60 ]]
then
        echo "2nd Class"
elif [[ $marks -ge 40 ]]
then
        echo "3rd Class"
else
        echo "You're Fail!!!!"
fi

O/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 11_elif-demo.sh 
Enter your Marks: 89
1st Class!!

ubuntu@ip-172-31-26-55:~/shell_practice$ bash 11_elif-demo.sh 
Enter your Marks: 55
3rd Class
	
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 11_elif-demo.sh 
Enter your Marks: 68
2nd Class

ubuntu@ip-172-31-26-55:~/shell_practice$ bash 11_elif-demo.sh 
Enter your Marks: 36
You're Fail!!!!
==============================================================================================================================================================
***Case :

#Case is used when we are having muktiple choice and conditions as elif becomes too much extra code if there are many Conditions

12. vi 12_case-demo.sh
------------------------
#!/bin/bash
 echo "Provide an options"
 echo "1 for print date"
 echo "2 for lists of scripts"
 echo "3 for current directory"

 read choice

 case $choice in
         1)
                 echo "Today's date is"
                 date
                 echo "Ending..."
                 ;;

         2)ls;;
         3)pwd;;
 esac
 
O/p: 
ubuntu@ip-172-31-26-55:~/shell_practice$ bash case-demo.sh 
Provide an options
1 for print date
2 for lists of scripts
3 for current directory
1
Today's date is
Wed May 22 07:23:59 UTC 2024
Ending...

ubuntu@ip-172-31-26-55:~/shell_practice$ bash case-demo.sh 
Provide an options
1 for print date
2 for lists of scripts
3 for current directory
2
01_basic.sh            03_Array.sh      05_string_op.sh  08_user_interaction.sh  10_if-else.sh    case-demo.sh
02_variables_basic.sh  04_key-value.sh  06_string_2.sh   09_arthmatic_ops.sh     11_elif-demo.sh

ubuntu@ip-172-31-26-55:~/shell_practice$ bash case-demo.sh 
Provide an options
1 for print date
2 for lists of scripts
3 for current directory
3
/home/ubuntu/shell_practice

==============================================================================================================================================================
***Logical Operators: &&, ||, !
================================
#AND Operator

13. ubuntu@ip-172-31-26-55:~/shell_practice$ cat 13_logical-ops.sh 
#!/bin/bash

read -p "Your age :" age
read -p "Your Country Name :" country

if [[ $age -ge 18 ]] && [[ $country == "India" ]]
then
        echo "You can Vote..."
else
        echo "You can't Vote....."
fi
------
O/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 13_logical-ops.sh 
Your age :18
Your Country Name :India
You can Vote...

ubuntu@ip-172-31-26-55:~/shell_practice$ bash 13_logical-ops.sh 
Your age :29
Your Country Name :USA
You can't Vote.....
ubuntu@ip-172-31-26-55:~/shell_practice$ 
-------------------------------------------------------------
##OR Operator
===================
14. vi 14_OR_logical-ops.sh
#!/bin/bash

#use of and && and OR || operator

age=18

[[ $age -ge 18 ]] && echo "Adult" || echo "Minor"

O/p:
bash 14_OR_logical-ops.sh 
Adult
==============================================================================================================================================================

***Loops:
=============

for loop:
=============

14. vi 15_forloop1.sh

for i in 1 2 3 4 5 6 7 8 9 10     #instead of this we can also for i in {1..10} -> wild card
do      
        echo "No is : $i"
done    

for x in Bhushya Pashya Shubham DK Mahi
do      
        echo "Name is --> $x"
done    

#O/p:
bash 15_forloop1.sh 
No is : 1
No is : 2
No is : 3
No is : 4
No is : 5
No is : 6
No is : 7
No is : 8
No is : 9
No is : 10
Name is --> Bhushya
Name is --> Pashya
Name is --> Shubham
Name is --> DK
Name is --> Mahi
--------------------------------------------------
#for loop with file.
#we have created a sample file emp_details.txt
/home/ubuntu/shell_practice/emp_details.txt

16. vi for_with_file.txt
#!/bin/bash
FILE="/home/ubuntu/shell_practice/emp_details.txt"

for name in $(cat $FILE)
do
	echo "Name is --> $name"
done

o/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 16_for_with_file.sh 
Name is --> Shubham
Name is --> 22089
Name is --> Pashy
Name is --> 17093
Name is --> Bhushya
Name is --> 78890
Name is --> DK
Name is --> 73210
Name is --> Alex
Name is --> 87641
=========================================================================================================================================================
***While loop: it will running till the condtion is true and will stop the while loop one Conditionis false
===============
17. vi 17_while_demo.sh
#!/bin/bash

count=0
num=12

while [[ $count -le $num ]]
do
        echo "Value is: $count"
        let count++
done 

o/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 17_while_demo.sh 
Value is: 0
Value is: 1
Value is: 2
Value is: 3
Value is: 4
Value is: 5
Value is: 6
Value is: 7
Value is: 8
Value is: 9
Value is: 10
Value is: 11
Value is: 12
===========================================================================================
***UNTIL loop: opposite to while loop, will run untill the condtion is true and once Condition is true the until loop stops
18. vi 18_until_loop.sh 
#!/bin/bash
 a=10

 until [[ $a -eq 1 ]]
 do
         echo "value is $a"
         let a--
 done
-----------------        
O/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 18_until_loop.sh 
value is 10
value is 9
value is 8
value is 7
value is 6
value is 5
value is 4
value is 3
value is 2
==================================================================================================
***INFINITE Loop:

#!/bin/bash

while true
do
        echo "Hey Keep it up. You're almost there!!"
        sleep 2s
done

##it wiil print Hey Keep it up. You're almost there!! continuously in every 2 seconds.
============================================================================================================================================================
while with file:

ubuntu@ip-172-31-26-55:~/shell_practice$ cat 20_while_with_file.sh 
#!/bin/bash
while read myFile
do
        echo "Value is: $myFile"
done < emp_details.txt

o/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 20_while_with_file.sh 
Value is: Shubham 22089
Value is: Pashy 17093
Value is: Bhushya 78890
Value is: DK 73210
Value is: Alex 87641
Value is: 

---------------------------------
***Read CSV file:
===================
To read content from a csv file
#use IFS --> Internal Field Seperator
while IFS="," read f1 f2 f3

do

echo $f1
echo $f2
echo $f3

done < file_name.csv

--------------------------------------------------------------------------
To read content from a csv file
Syn:
cat myfile.csv | awk '!NR=1 {print}'| while IFS="," read f1 f2 f3
---------
22. vi 22_while_awk_command.sh 
#!/bin/bash

cat details.csv | awk 'NR!=1 {print}' | while IFS="," read id name age
do
        echo "id is $id"
        #echo "name is $name"
        #echo "age is $age"
done
-------------------------------------------
o/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 22_while_awk_command.sh 
id is 1
id is 2
id is 3
id is 4
============================================================================================================================================================
***Functions:
-----------------
Block of code which perform some task and run when it is called.
Can be reuse many times in our program which lessen our lines of code.
We can pass arguments to the method.

Syntax:
function myfun {

echo "Hi"

}

-----------------------------------
To call the function
myfun

Example:
#!/bin/bash

#To create a function. Here function is keyword and welcomeNote is a function name.
function welcomeNote {
        echo "--------------------------------------------------"
        echo "                  WELCOME                         "
        echo "--------------------------------------------------"
}
#To call our function. Here we are calling our function for 3 times.
welcomeNote
welcomeNote
welcomeNote
~           
O/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 23_functions-demo.sh 
--------------------------------------------------
                        WELCOME
--------------------------------------------------
--------------------------------------------------
                        WELCOME
--------------------------------------------------
--------------------------------------------------
                        WELCOME
						
Another way to write function 
myfun() {

echo "Hello"

}

example:
#!/bin/bash

#To create a function. Here function is keyword and welcomeNote is a function name.
welcomeNote() {
        echo "--------------------------------------------------"
        echo "                  WELCOME                         "
        echo "--------------------------------------------------"
}
#To call our function. Here we are calling our function for 3 times.
welcomeNote
welcomeNote
welcomeNote
===========================================================================================================================================================
Functions with Aruguments:
HOW TO USE ARGUMENTS IN FUNCTIONS?

addition() {

local num1=$1
local num2=$2
let sum=$num1+$num2

echo “Sum of $num1 and $num2 is $sum”
}

--------------------------------------

myfun 12 13
======================
#!/bin/bash

#paasing the arguments
echo "The first name is $1"
echo "The last name is $2"

echo "All args are $@"
echo "No of args are $#"

#for loop for accessing values in argumen

for filename in $@
do
        echo "Copying file - $filename"
done
~       
==================================================
shift:
25. vi 25_shift.sh
------------
#!/bin/bash
#to crate user and provide user name and description
echo "Creating User"
echo "User Name $1"
shift
#shift will take other args except the first one $1
echo "Description $@"
#above line take all the values after 1st args i.e it is shifting from first arg to all other args values
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~       

O/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 25_shift.sh Vaishali She is doing a automation testing.
Creating User
User Name Vaishali
Description She is doing a automation testing.
===========================================================================================================================================================
***Break:
#!/bin/bash

#we need to find if no 6 is there or not. we use for loop for that and once we found the no6 we stop i.e break the for loop.

no=6

for i in {1..10}
do
        #break the loop if no. found
        if [[ $no -eq $i ]]
        then
                echo "$no is Found!!"
                break
        fi
        echo "Number is $i"
done

o/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 26_break.sh 
Number is 1
Number is 2
Number is 3
Number is 4
Number is 5
6 is Found!!
========================================================
***Continue:
finding odd no
#!/bin/bash
#example for continue loop
#suppose we need to put odd no only

for i in {1..10}
do      
        let a=$i%2
        if [[ $a -eq 0 ]]
        then    
                continue
        fi      
        echo "odd no is $i"
done    
~~~~~~~~~~~~~~
o/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 27_continue.sh 
odd no is 1
odd no is 3
odd no is 5
odd no is 7
odd no is 9
=============================
$? --> use to check status of the script

#!/bin/bash
#here we wre checking site connectivity status

read -p "Which site you want to visit ?" site
#we are storing value in site variable

ping -c 1 $site
#here ping command is used to check the connection
sleep 5s

#$? --> to check the the status
if [[ $? -eq 0 ]]
then
        echo "Successfully connected to $site"
else
        echo "Connetion refused to $site"
fi

o/p:
ubuntu@ip-172-31-26-55:~/shell_practice$ bash 28_connectivity_check.sh 
Which site you want to visit ?www.google.com
PING www.google.com (172.253.115.104) 56(84) bytes of data.
64 bytes from bg-in-f104.1e100.net (172.253.115.104): icmp_seq=1 ttl=58 time=1.53 ms

--- www.google.com ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 1.532/1.532/1.532/0.000 ms
Successfully connected to www.google.com

=================================
IMP:
----
realpath will give you the complete path pf the file whenever you want to find it
#here in below example it is giing full path of file test1 
ubuntu@ip-172-31-26-55:~/shell_practice$ realpath test1
/home/ubuntu/shell_practice/test1

~~~~~~~~~~~~~~~~~----------------------------
#if [ -d folder_name] If folder exists
#[ ! -d folder_name] If folder not exists
#if [ -f file_name] If file exists
#if [ ! -f file_name] If file not exists

vi file_exist-or-not.sh
#!/bin/bash

FILEPATH=/home/ubuntu/shell_practice/tst_10.csv

if [[ -f $FILEPATH ]]
then
        echo "File exists"
else
        echo "File not FOUND"
        exit 1
fi

o/p:
bash file_exist-or-not.sh 
File not FOUND
-----------------------------------------------
***UID

UID is 0 for root user always

ubuntu@ip-172-31-26-55:~/shell_practice$ cat 29_dice.sh 
#!/bin/bash

#checking dice no between 1 to 6

NO=$(($RANDOM%6 +1))
echo "The number is $NO"
ubuntu@ip-172-31-26-55:~/shell_practice$ cat 30_root_user_check.sh 
#/bin/bash

#we are checking if user is root or not
#UID for rot user is always a 0. so if UID=0 then its a root user same mention in script
if [[ $UID -eq 0 ]]
then
        echo "User is root"
else
        echo "User is not a root user"
fi
===========================================================================================================================================================
#######REDIRECTION IN SCRIPTS:
-~_~_~_~_~_~_~_~_~_~_~_~_~_~~_~_~_~_~_~_~_~_~_~_~_~_~_~~_

> --> MEANS OVERWRITE
>> --> APPEND

EX.
ping -c 1 www.google.com > redirect.log 		#o/p will be written in redirect.log file so you can check it later

===========================================================================================================================================================
If you want to maintain the logging for your script, you can use logger in your script.

You can find the logs under
/var/logs/messages

Example: #logger “Hey Buddy”
===========================================================================================================================================================
####Running scripts in backround --> we use nohup
nohup ./scrit_name &
nohup ./script.sh &
===========================================================================================================================================================
######AUTOMATION Scripts:At or Crontab
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For scheduling only one time, use AT

at 12:09 PM

<your_command>

Ctrl + D
------------
AT example:
ubuntu@ip-172-31-26-55:~/shell_practice$ date
Fri May 24 06:38:08 UTC 2024

ubuntu@ip-172-31-26-55:~/shell_practice$ at 06:40
warning: commands will be executed using /bin/sh
at Fri May 24 06:40:00 2024
at> bash /home/ubuntu/shell_practice/28_connectivity_check.sh
at> <EOT>				#here press ctrl+D to save 
job 3 at Fri May 24 06:40:00 2024

Ex no 2:
ubuntu@ip-172-31-26-55:~/shell_practice$ at 06:45 
warning: commands will be executed using /bin/sh
at Fri May 24 06:45:00 2024
at> /home/ubuntu/shell_practice/12_case-demo.sh > case-script.log    ##here we are redirecting our o/p to case-script.log file so that we can check it later
at> <EOT>
job 4 at Fri May 24 06:45:00 2024

ubuntu@ip-172-31-26-55:~/shell_practice$ atq    #to check schedule job
3       Fri May 24 06:40:00 2024 a ubuntu
-------------------------------------------------

atq to check scheduled job
atrm <id> to remove the schedule

####CRON TAB:
~~~~~~~~~~~~~~~~~~~~~~~~
To check the existing jobs - crontab -l
To add new job - crontab -e

* * * * * cd /home/paul/scripts && ./create_file.sh     #check crontab.guru for more understanding

“At every minute.”
 at 2024-05-24 12:23:00
*   *     *  		  * 	*
min hour day(month) month day(wk)

Ex:
30 13 26 * SUN ----> means will run at ---> “At 13:30 on day-of-month 26 and on Sunday.”  


===================================================
crontab -e 
 15 7 * * * /home/ubuntu/shell_practice/ && ./27_continue.sh       #it will run at 7:15 am everyday
 
 crontab -l --> to list schedule job on CRON
===========================================================================================================================================================
#####Find Command:
******MOST IMP:
11. How to find empty files in a given directory and at the same time delete them
find /path/ -empty -exec rm {} \;
ubuntu@ip-172-31-26-55:~/shell_practice/myScripts$ find . -empty
./a1

ubuntu@ip-172-31-26-55:~/shell_practice/myScripts$ find /home/ubuntu/shell_practice/myScripts  -empty -exec rm {} \;
ubuntu@ip-172-31-26-55:~/shell_practice/myScripts$ find . -empty

12. How to search files whose size in between 1-50 MB ?
find /path/ -size +1M -size 50M

13. How to search 15 days older files 
find /path/ -mtime 15

syntax: 
find /path/ -iname file_name

1. Case 1.
#How to search file based on their size ?
	find /path/ -size 50M
M for MB
k for KB
G for GB
c for bytes
------------------------
2. How to find only File or directory in a given path
 find /path/ -type f 
 
 f for File
 d for directory
 l for symblic link
 b for block device
 s for socket
 
3. file name  --> need to give exact name and spelling
find . -name 30_root_user_check.sh
./30_root_user_check.sh

4. how to ignore upper or lowecase while searching File use (-i)
ubuntu@ip-172-31-26-55:~/shell_practice/myScripts$ find . -iname 30_Root_user_check.sh
./30_root_user_check.sh

5. How to search file for a given user only 
find /path/ -user root

6. How to search file for inode
ls -li #			use to check inode
find . -inum 334231

7. files based on number of links 
find /path/ -links <no._of_links>
find . -links 2
.

8. search files based on their permissions
find /path/ -perm /u=r
find /path/ -perm 777
#Ex:
ubuntu@ip-172-31-26-55:~/shell_practice/myScripts$ find . -perm /u=x
.
./02_variables_basic.sh
./01_basic.sh
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ubuntu@ip-172-31-26-55:~/shell_practice/myScripts$ find . -perm 777
./02_variables_basic.sh
ubuntu@ip-172-31-26-55:~/shell_practice/myScripts$ 

9. search files which starts with a ?
find /path/ -iname a*

10 How to find empty files in a given directory
find /path/ -empty
ubuntu@ip-172-31-26-55:~/shell_practice/myScripts$ find . -empty
./a1

11. How to find empty files in a given directory and at the same time delete them
find /path/ -empty -exec rm {} \;