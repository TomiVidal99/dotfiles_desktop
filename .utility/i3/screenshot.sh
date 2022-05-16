#!/bin/bash

# Start the screenshot app, kill it before if it's running.

kill $(pidof flameshot)
flameshot gui & disown
