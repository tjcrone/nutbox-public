#!/bin/bash

screen -q
source activate venv/bin/activate
jupyter lab --no-browser --port=5678 --ServerApp.token=''
#screen -D
