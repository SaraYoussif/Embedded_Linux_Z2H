#!/bin/bash

#############################################################################################################
#echo -n "argv: "
#echo -n '$#'
#echo "$#"
#echo -n '$1: '
#echo "$1"
#echo -n '$2: '
#echo "$2"
#echo -n '$@: '
#echo $"$@"
#get args in one line array argv
#argv=("$@")
#echo -n'input parameters :'
#echo ${argv[0]} ${argv[1]} ${argv[2]} ${argv[3]}

##################################################################get all el arguments bt3ty ################################
## this script depend on  taking input data in dictionary and save it int file and retive it in file
argv=("$@")
declare -A dict

i=2
helpFunction()
{
	echo -e ""
	echo -e "this script for saving phone number "
	echo -e "insert"
	echo -e "\t -i <Name> <Phone Number>"
	echo -e "search for phonenumber"
	echo -e "\t -s <Name> "
	echo -e "delete all"
	echo -e "\t -e"
	echo -e "delete name from phonebook"
	echo -e "\t -d <Name>"
	

}
# check if number  without charartes
checkPhoneNumFunc()
{
        phone=${argv[2]}
	if ! [[ $phone =~ ^[0-9]+$ ]]; then
                echo not num
                return 0
        else
                echo its  num
                return 1
        fi        

}


readfile()
{
        local name
        while read line
        do
                if [ "${line:0:5}" = 'name:' ]
                then
                        name="${line:5}"
                        dict["$name"]=''
                 elif [ "${line:0:5}" = 'tele:' ]
                then
                        dict["$name"]="${dict[$name]} ${line:5}"
                fi
     done <".phonebookDB.txt"                   
                

}



savefile()
{
        echo > ~/.phonebookDB.txt
        for Key in "${!dict[@]}"
        do
               echo "name:$Key">> ~/.phonebookDB.txt
               for value in ${dict[$Key]}
               do 
                      echo "tele:$value">> ~/.phonebookDB.txt
               done
	
               
        done
	
}
if [ $# = 0 ]
then 
        helpFunction

elif [ ${argv[0]} = '-i' ]
then 
	echo -n 'name: '
	echo "${argv[1]}"
	
	echo -n 'phone : '
	
	echo "${argv[2]}"
	checkPhoneNumFunc
	if [ $? = 0 ]
	then
	       # echo  'batee5'
	        exit 1
	else
	    readfile   
	    name="${argv[1]}"
	    phone="${argv[2]}"
	    
	    dict["$name"]="${dict["$name"]} $phone"
	    echo "${name} = ${dict[$name]} "
	    savefile
	    #dict["$name"]="$name $phone"
	    #dict=( ["name"]="${argv[1]}" "${argv[2]}" )
	    #dict="${dict[@]}}"
	    #echo "${dict[@]}">>.phonebookDB.txt 
	  #  echo "">.phonebookDB.txt 
	fi
elif [ ${argv[0]} = '-v'  ]
then 
	helpFunction
elif [ ${argv[0]} = '-s' ]
then
        readfile
        name="${argv[1]}"
        #echo $k
	for value in ${dict[$name]}
	do
	echo "tele:$value"
	done
	
elif [ ${argv[0]} = '-e' ]
then
        echo >~/.phonebookDB.txt
elif [  ${argv[0]} = '-d' ]
then
        name="${argv[1]}"
        readfile
        #echo "$name ${dict[$name]}"
        unset "dict[$name]"
        savefile                	
else 
	echo 'lol'	    
fi
