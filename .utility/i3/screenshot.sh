#!/bin/bash

# Start the screenshot app, kill it before if it's running.

pkill flameshot
flameshot gui & disown
