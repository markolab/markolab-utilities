#!/bin/bash

if [ -z "$JUPYTER_PORT" ]; then 
	port=$(shuf -i 5000-8000 -n 1)
else
	port=$JUPYTER_PORT
fi

hname=$(hostname)

echo -e "\nStarting Jupyter Notebook on port ${port} on the $(hostname) server."
echo -e "\nSSH tunnel command: ssh -NL ${port}:localhost:${port} ${USER}@${hname}"

external_ip=( `curl http://checkip.amazonaws.com` )

cd ${HOME}
jupyter lab --no-browser --port=${port} --ip=0.0.0.0 --NotebookApp.custom_display_url="http://$external_ip:$port"
