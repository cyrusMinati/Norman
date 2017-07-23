/usr/bin/osascript << EOF
tell application "Google Chrome"
        activate
        set theUrl to "http://your-site-url.com"
        if (count every window) = 0 then
                make new window
        end if
        set found to false
        set theTabIndex to -1
        repeat with theWindow in every window
                set theTabIndex to 0
                repeat with theTab in every tab of theWindow
                        set theTabIndex to theTabIndex + 1
                        -- Instead of checking if the url is the same, I'm checking if the url "starts with"
                        -- Otherwise the script wouldn't find url's with parameters or hash tags
                        if theTab's URL starts with theUrl then
                                set found to true
                                exit
                        end if
                end repeat
                if found then
                        exit repeat
                end if
        end repeat
        if found then
                tell theTab to reload
                set theWindow's active tab index to theTabIndex
                set index of theWindow to 1
        else
                tell window 1 to make new tab with properties {URL:theUrl}
        end if
end tell
