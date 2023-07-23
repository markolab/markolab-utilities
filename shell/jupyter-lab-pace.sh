#!/bin/bash

if [ -z "$JUPYTER_PORT" ]; then 
	# binds an unused port
	port=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
else
	port=$JUPYTER_PORT
fi

hname=$(hostname)

echo -e "\nStarting Jupyter Notebook on port ${port} on the $(hostname) server."
echo -e "\nSSH tunnel command: ssh -NL ${port}:localhost:${port} ${USER}@${hname}"

cd ${HOME}
jupyter lab --no-browser --port=${port} --ip=0.0.0.0 --NotebookApp.custom_display_url="http://$hname:$port"
