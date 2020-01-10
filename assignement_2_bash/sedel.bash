#!/bin/bash
argv=("$@")

num=$#
if [ -d ~/trash ]
then
        echo "file exit"
else
        mkdir ~/trash
fi

if [ $# = 0 ]
then
        echo "pleas write file name file"
        #find ~/trash -type f -mmin +2 -exec rm -r {}  \;
        find ~/trash -mtime +2 -type f -exec rm -r {}  \;
else
        for i in ${argv[@]}
        do 
                file1=$i
                echo $file1
                if [ -e $file1.tar.gz ]
                then
                                echo "file exit compersed"
                elif [ -d $file1 ]
                then
                                tar -czf $file1.tar.gz $file1
                                echo "dirctory compresed "
                                mv $file1.tar.gz ~/trash
                                rm -r $file1
                                
                else 
                                tar -czf $file1.tar.gz $file1
                                echo "file compresed "
                                
                                mv $file1.tar.gz ~/trash
                                rm -r $file1
                                
                       
                        
                fi
         done       
                
        
fi
#find ~/trash -mmin +2 -type f -exec rm -r {}  \;
find ~/trash -mtime +2 -type f -exec rm -r {}  \;
#find . -mtime -2 -type f -exec rm -r {} ~/trash \;
