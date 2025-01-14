#!/usr/bin/bash 

if [ ! -d "$1" ] || [[ ! "$2" =~ ^\. ]]
then
    echo "Not a valid directory either first argument not a valid directory or second argument not starting with '.'"
    exit 1 
fi 
files=$(find "$1" -type f -name "*$2")
fileCount=$(echo "$files" | grep -c "^")
echo "Directory: $1" | tee -a log.txt
echo "File Extension: $2" | tee -a log.txt
echo "Total Files Found: $fileCount" | tee -a log.txt 

# Find and display top 5 largest files
echo -e "Top 5 Largest Files:" | tee -a log.txt
# contents=$(find $1 -type f -name "*$2" -exec ls -l {} \; 2>/dev/null | sort -k5 -r)

order=1
while read -r perms links owner group size month day time file; do
    size=$(($size / 1000))
    echo "$order. $file - $size KB" | tee -a log.txt
    # Now you can use individual fields
    # echo "Processing $file:"
    # echo "- Size: $size"
    # echo "- Owner: $owner"
    # echo "- Modified: $month $day $time"
    order=$(($order+1))
done < <(find "$1" -type f -name "*$2" -exec ls -l {} \; 2>/dev/null | sort -k5 -r | head -5)


# for content in $contents
# do
# echo $content 
# done 

