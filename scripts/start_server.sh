c=$(ls -l /var/www/html/ | grep "^d" | wc -l)
arr1=(/var/www/html/*)
echo ${arr1[@]}
total=${#arr1[@]}
for(( i=0; i<$total; i++ ))
do
	if [ -f "${arr1[$i]}/deploy.json" ]
	then
		type=`jq -r .deployment_type ${arr1[$i]}/deploy.json`
		if [ $type == react ]
		then
			portno=`jq -r .port_number ${arr1[$i]}/deploy.json`
			servname=`jq -r .server_name ${arr1[$i]}/deploy.json`
			servalias=`jq -r .server_alias ${arr1[$i]}/deploy.json`
			cd ${arr1[$i]}
			npm i
			npm run-script build
			pm2 serve build $portno --spa
			cd
		elif [ $type == node ]
		then
			filename=`jq -r .file_name ${arr1[$i]}/deploy.json`
			nportno=`jq -r .port_number ${arr1[$i]}/deploy.json`
			servname=`jq -r .server_name ${arr1[$i]}/deploy.json`
			servalias=`jq -r .server_alias ${arr1[$i]}/deploy.json`
			cd ${arr1[$i]}
			npm i
			pm2 start $filename
			cd
		elif [ $type == html ]
		then
			servname=`jq -r .server_name ${arr1[$i]}/deploy.json`
			servalias=`jq -r .server_alias ${arr1[$i]}/deploy.json`
		else
			echo "Not an app"
		fi
	fi
done

##uncomment to check for changing the directory
systemctl restart apache2
