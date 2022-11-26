#!/bin/bash
#Setup a crontab to make sure Bookmarks are always saved
cp ~/.config/BraveSoftware/Brave-Browser/Default/Bookmarks files/
git add .
git commit -m "mise a jour des bookmarks via le crontab"
git push