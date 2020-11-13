#!/bin/bash

screen -q
jupyter lab --no-browser --port=5678 --ServerApp.token=''
screen -D
