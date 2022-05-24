#!/bin/bash


#echo hello This is to get list of suppressions e.g. blocks and then add it to global suppressions list.
#echo https://stackoverflow.com/questions/32791663/how-to-run-curl-command-with-parameter-in-a-loop-from-bash-script


#1. To run script:
# chmod 700 ExportImportSuppressions.sh
# ./ExportImportSuppressions.sh

#2. Enter the API Keys (apiKeySrc,apiKeyDest) or use config.env

source config.env

#3. To Change as required


#4 Next Steps: To Add for Group Unsubscribe
start =0;
suppressedEmailsToExport="";

#Loop For Blocks
limit1=50;
iterations=3;
for (( i = 0; i < $iterations; i++ )) 
do 
    echo "i: ${i}";
    start=$(( i*limit1 ));
    echo "start: ${start}";

    varExport1=$(curl --location --request GET 'https://api.sendgrid.com/v3/suppression/blocks?offset='$start'&limit='$limit1 \
    --header 'Authorization: Bearer '$apiKeySrc \
    --header 'Content-Type: application/json' \
    --data-raw '') 

    echo "$varExport1" >> Blocks.csv;


    email=$(echo $varExport1 | jq '[.[].email]');
    
   
    echo "${email}">>test.csv;
    lengthEmailArray=${#email[@]}

    echo " lengthEmailArray ${lengthEmailArray}"
    echo "email: ${email}"

    find='['
    replace=''
    modifiedEmailsList=${email[@]//${find}/${replace}}
    find=']'
    suppressedEmails1ToExport=${modifiedEmailsList[@]//${find}/${replace}}
    #echo "1. suppressedEmails1ToExport >>>>>${suppressedEmails1ToExport}"


    if [[ "$suppressedEmailsToExport" == "" ]]
    then
        suppressedEmailsToExport="${suppressedEmails1ToExport}"
    elif [[ "$suppressedEmails1ToExport" != "" ]]
    then
        suppressedEmailsToExport="${suppressedEmailsToExport},${suppressedEmails1ToExport}"
    fi
    #echo "2. suppressedEmailsToExport >>>>>${suppressedEmailsToExport}"

    #echo "i ${i}"
    #echo "iterations ${iterations}"
    if [[ $iterations-1 -gt $i ]]
    then 
        suppressedEmailsToExportModified="${suppressedEmailsToExport},"
        #echo "3. suppressedEmailsToExportModified >>>>>${suppressedEmailsToExportModified}"
    else 
        suppressedEmailsToExportModified="${suppressedEmailsToExport}"
    fi
    #echo "4. suppressedEmailsToExportModified: ${suppressedEmailsToExportModified}"
done

echo "${suppressedEmailsToExport}" >> BlocksEmails1.csv; 
#End: Loop For Blocks 


#Loop For Bounces
limit1=50;
iterations=3;
for (( i = 0; i < $iterations; i++ )) 
do 
    echo "i: ${i}";
    start=$(( i*limit1 ));
    echo "start: ${start}";

    varExport1=$(curl --location --request GET 'https://api.sendgrid.com/v3/suppression/bounces?offset='$start'&limit='$limit1 \
    --header 'Authorization: Bearer '$apiKeySrc \
    --header 'Content-Type: application/json' \
    --data-raw '') 

    echo "$varExport1" >> Bounces.csv;


    email=$(echo $varExport1 | jq '[.[].email]');
    
   
    echo "${email}">>test.csv;
    lengthEmailArray=${#email[@]}

    echo " lengthEmailArray ${lengthEmailArray}"
    echo "email: ${email}"

    find='['
    replace=''
    modifiedEmailsList=${email[@]//${find}/${replace}}
    find=']'
    suppressedEmails1ToExport=${modifiedEmailsList[@]//${find}/${replace}}
    #echo "1. suppressedEmails1ToExport >>>>>${suppressedEmails1ToExport}"


    if [[ "$suppressedEmailsToExport" == "" ]]
    then
        suppressedEmailsToExport="${suppressedEmails1ToExport}"
    elif [[ "$suppressedEmails1ToExport" != "" ]]
    then
        suppressedEmailsToExport="${suppressedEmailsToExport},${suppressedEmails1ToExport}"
    fi
    #echo "2. suppressedEmailsToExport >>>>>${suppressedEmailsToExport}"

    #echo "i ${i}"
    #echo "iterations ${iterations}"
    if [[ $iterations-1 -gt $i ]]
    then 
        suppressedEmailsToExportModified="${suppressedEmailsToExport},"
        #echo "3. suppressedEmailsToExportModified >>>>>${suppressedEmailsToExportModified}"
    else 
        suppressedEmailsToExportModified="${suppressedEmailsToExport}"
    fi
    #echo "4. suppressedEmailsToExportModified: ${suppressedEmailsToExportModified}"
done
echo "${suppressedEmailsToExport}" >> BouncesEmails1.csv; 
#End: Loop For Bounces


#Loop For Global Unsubscribes
limit1=50;
iterations=3;
for (( i = 0; i < $iterations; i++ )) 
do 
    echo "i: ${i}";
    start=$(( i*limit1 ));
    echo "start: ${start}";

    varExport1=$(curl --location --request GET 'https://api.sendgrid.com/v3/suppression/unsubscribes?offset='$start'&limit='$limit1 \
    --header 'Authorization: Bearer '$apiKeySrc \
    --header 'Content-Type: application/json' \
    --data-raw '') 

   


    email=$(echo $varExport1 | jq '[.[].email]');
    
   
    echo "${email}">>GlobalUnsubscribes.csv;
    lengthEmailArray=${#email[@]}

    echo " lengthEmailArray ${lengthEmailArray}"
    echo "email: ${email}"

    find='['
    replace=''
    modifiedEmailsList=${email[@]//${find}/${replace}}
    find=']'
    suppressedEmails1ToExport=${modifiedEmailsList[@]//${find}/${replace}}
    #echo "1. suppressedEmails1ToExport >>>>>${suppressedEmails1ToExport}"


    if [[ "$suppressedEmailsToExport" == "" ]]
    then
        suppressedEmailsToExport="${suppressedEmails1ToExport}"
    elif [[ "$suppressedEmails1ToExport" != "" ]]
    then
        suppressedEmailsToExport="${suppressedEmailsToExport},${suppressedEmails1ToExport}"
    fi
    #echo "2. suppressedEmailsToExport >>>>>${suppressedEmailsToExport}"

    #echo "i ${i}"
    #echo "iterations ${iterations}"
    if [[ $iterations-1 -gt $i ]]
    then 
        suppressedEmailsToExportModified="${suppressedEmailsToExport},"
        #echo "3. suppressedEmailsToExportModified >>>>>${suppressedEmailsToExportModified}"
    else 
        suppressedEmailsToExportModified="${suppressedEmailsToExport}"
    fi
    #echo "4. suppressedEmailsToExportModified: ${suppressedEmailsToExportModified}"
done
echo "${suppressedEmailsToExport}" >> GlobalUnsubscribesEmails1.csv; 
#End: Loop For GlobalUnsubscribes 


#Loop For Invalid
limit1=50;
iterations=3;
for (( i = 0; i < $iterations; i++ )) 
do 
    echo "i: ${i}";
    start=$(( i*limit1 ));
    echo "start: ${start}";

    varExport1=$(curl --location --request GET 'https://api.sendgrid.com/v3/suppression/invalid_emails?offset='$start'&limit='$limit1 \
    --header 'Authorization: Bearer '$apiKeySrc \
    --header 'Content-Type: application/json' \
    --data-raw '') 

   


    email=$(echo $varExport1 | jq '[.[].email]');
    
   
    echo "${email}">>Invalid.csv;
    lengthEmailArray=${#email[@]}

    echo " lengthEmailArray ${lengthEmailArray}"
    echo "email: ${email}"

    find='['
    replace=''
    modifiedEmailsList=${email[@]//${find}/${replace}}
    find=']'
    suppressedEmails1ToExport=${modifiedEmailsList[@]//${find}/${replace}}
    #echo "1. suppressedEmails1ToExport >>>>>${suppressedEmails1ToExport}"


    if [[ "$suppressedEmailsToExport" == "" ]]
    then
        suppressedEmailsToExport="${suppressedEmails1ToExport}"
    elif [[ "$suppressedEmails1ToExport" != "" ]]
    then
        suppressedEmailsToExport="${suppressedEmailsToExport},${suppressedEmails1ToExport}"
    fi
    #echo "2. suppressedEmailsToExport >>>>>${suppressedEmailsToExport}"

    #echo "i ${i}"
    #echo "iterations ${iterations}"
    if [[ $iterations-1 -gt $i ]]
    then 
        suppressedEmailsToExportModified="${suppressedEmailsToExport},"
        #echo "3. suppressedEmailsToExportModified >>>>>${suppressedEmailsToExportModified}"
    else 
        suppressedEmailsToExportModified="${suppressedEmailsToExport}"
    fi
    #echo "4. suppressedEmailsToExportModified: ${suppressedEmailsToExportModified}"
done
echo "${suppressedEmailsToExport}" >> InvalidEmails.csv; 
#End: Loop For For Invalid


#Loop For Spam Report
limit1=50;
iterations=3;
for (( i = 0; i < $iterations; i++ )) 
do 
    echo "i: ${i}";
    start=$(( i*limit1 ));
    echo "start: ${start}";

    varExport1=$(curl --location --request GET 'https://api.sendgrid.com/v3/suppression/spam_reports?offset='$start'&limit='$limit1 \
    --header 'Authorization: Bearer '$apiKeySrc \
    --header 'Content-Type: application/json' \
    --data-raw '') 

   


    email=$(echo $varExport1 | jq '[.[].email]');
    
   
    echo "${email}">>spam_reports.csv;
    lengthEmailArray=${#email[@]}

    echo " lengthEmailArray ${lengthEmailArray}"
    echo "email: ${email}"

    find='['
    replace=''
    modifiedEmailsList=${email[@]//${find}/${replace}}
    find=']'
    suppressedEmails1ToExport=${modifiedEmailsList[@]//${find}/${replace}}
    #echo "1. suppressedEmails1ToExport >>>>>${suppressedEmails1ToExport}"


    if [[ "$suppressedEmailsToExport" == "" ]]
    then
        suppressedEmailsToExport="${suppressedEmails1ToExport}"
    elif [[ "$suppressedEmails1ToExport" != "" ]]
    then
        suppressedEmailsToExport="${suppressedEmailsToExport},${suppressedEmails1ToExport}"
    fi
    #echo "2. suppressedEmailsToExport >>>>>${suppressedEmailsToExport}"

    #echo "i ${i}"
    #echo "iterations ${iterations}"
    if [[ $iterations-1 -gt $i ]]
    then 
        suppressedEmailsToExportModified="${suppressedEmailsToExport},"
        #echo "3. suppressedEmailsToExportModified >>>>>${suppressedEmailsToExportModified}"
    else 
        suppressedEmailsToExportModified="${suppressedEmailsToExport}"
    fi
    #echo "4. suppressedEmailsToExportModified: ${suppressedEmailsToExportModified}"
done
echo "${suppressedEmailsToExport}" >> SpamReportsEmails.csv; 
#End: Loop For For Spam Report


############### After Retrieving all the Suppressions ####################
suppressedEmailsToExportArrayString="[${suppressedEmailsToExportModified[@]}]"

#echo "suppressedEmailsToExportArrayString: ${suppressedEmailsToExportArrayString}"

dataObject='{
    "recipient_emails": '${suppressedEmailsToExportArrayString}'

}';

echo "dataObject" 
echo "${dataObject}" 

curl --location --request POST 'https://sendgrid.com/v3/asm/suppressions/global' \
--header 'Authorization: Bearer  '$apiKeyDest \
--header 'Content-Type: application/json' \
--data "$dataObject" \