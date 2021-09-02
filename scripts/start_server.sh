c=$(ls -l /var/www/demo/ | grep "^d" | wc -l)
arr1=(/var/www/demo/*)
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
			pm2 update
			
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
			pm2 update
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
pm2 save --force
	for(( i=0; i<\$total; i++ ))
	do
		if [ -f "${arr1[$i]}/deploy.json" ]
		then
		type=`jq -r .deployment_type ${arr1[$i]}/deploy.json`
			if [ -f /etc/nginx/sites-available/\${arr1[\$i]}.conf ]
			then
				echo "File Exist"
			else
				sudo touch /etc/nginx/sites-available/\${arr1[\$i]}.conf 
				if [ $type == react ]
    				then
       				portno=`jq -r .port_number ${arr1[$i]}/deploy.json`
				servname=`jq -r .server_name ${arr1[$i]}/deploy.json`
				servalias=`jq -r .server_alias ${arr1[$i]}/deploy.json`
				cd ${arr1[$i]} 
        			sudo tee -a  /etc/nginx/sites-available/${arr1[\$i]}.conf >/dev/null << EOF
        			server {
				listen 80;
				listen [::]:80;

            			root /var/www/demo;

				server_name $servname;
				location / {
                    		proxy_pass http://127.0.0.1:$portno/;
				}
				}
        			server {
				listen 443;
				listen [::]:443;

           			root /var/www/demo;

				server_name $servname; 
				location / {
                        proxy_pass http://127.0.0.1:$portno/;
				}
			}               
EOF
        		cd
        elif [ $type == node ]
        then
           filename=`jq -r .file_name ${arr1[$i]}/deploy.json`
			nportno=`jq -r .port_number ${arr1[$i]}/deploy.json`
			servname=`jq -r .server_name ${arr1[$i]}/deploy.json`
			servalias=`jq -r .server_alias ${arr1[$i]}/deploy.json`
			cd ${arr1[$i]}
			sudo tee -a  /etc/nginx/sites-available/${arr1[\$i]}.conf >/dev/null << EOF
        		server {
			listen 80;
			listen [::]:80;

            		root /var/www/demo;

			server_name $servname;
			location / {
                    		proxy_pass http://127.0.0.1:$portno/;
				}
			}
        		server {
			listen 443;
			listen [::]:443;

           		root /var/www/demo;

			server_name $servname; 
			location / {
                        proxy_pass http://127.0.0.1:$portno/;
				}
			}               
EOF
        cd
        elif [ $type == html ]
        then
            servname=`jq -r .server_name ${arr1[$i]}/deploy.json`
		servalias=`jq -r .server_alias ${arr1[$i]}/deploy.json`
            sudo tee -a  /etc/nginx/sites-available/${arr1[\$i]}.conf >/dev/null << EOF
        		server {
			listen 80;
			listen [::]:80;

            		root /var/www/demo;

			server_name $servname;
			location / {
                    		proxy_pass http://127.0.0.1:$portno/;
				}
			}
        		server {
			listen 443;
			listen [::]:443;

           		root /var/www/demo;

			server_name $servname; 
			location / {
                        proxy_pass http://127.0.0.1:$portno/;
				}
			}               
EOF
		fi
fi
	done

##uncomment to check for changing the directory
systemctl restart nginx
