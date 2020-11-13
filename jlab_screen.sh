#!/bin/bash

source /home/debian/venv/bin/activate
jupyter lab --no-browser --port=5678 --ServerApp.token=''
