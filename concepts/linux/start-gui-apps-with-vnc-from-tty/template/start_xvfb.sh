: "
Test: Starting GUI applications as a background process/daemon from the tty

[Description]
within the tty - start up a GUI application, lets say firefox, in the background as a daemon/process using DISPLAY=:1

then afterwhich, starting up either a VNC server, or a Websocket server (i.e. NoVNC) that will point to that :1 display 
so that when I access the web/browser-based vnc client, it will go straight into firefox
so yeah, like as a background process such that when I run it, I will remain in the tty instead of going into the GUI application

the idea is that with this, I can startup as many GUI applications as I need/want as individual "VNC servers" and access them through the web browser

[Notes and Findings]
- Framebuffer: A framebuffer is a virtual memory container that will hold display data used to well, display - such as Graphical Environments and/or render them
"

# Initialize Variables
APPLICATIONS=("openbox")
DEPENDENCIES=(${APPLICATIONS[@]} x11vnc websockify Xvfb)

## Set Environment Variable
export DISPLAY=:6

## Check if dependencies are up
for pkg in "${DEPENDENCIES[@]}"; do
    echo -e "$pkg"
    ### Get process ID
    process_ID="$(pgrep $pkg)"

    ### Kill application process
    if [[ ! -z "$process_ID" ]]; then
        echo -e "Killing: $pkg => $process_ID"
        kill -9 $process_ID
    fi
done

# Begin start

## Startup X virtual framebuffer
Xvfb :6 -screen 0 1024x768x16 &

## Start VNC server
x11vnc -display :6 -rfbport 5906 -nopw -xkb -forever -bg

## Start Websocket server
websockify -D --web=$HOME/Desktop/repos/git/novnc 6081 127.0.0.1:5906

## Startup GUI applications in the background of the current X Virtual Framebuffer
for i in "${!APPLICATIONS[@]}"; do
    # Get current app
    curr_app="${APPLICATIONS[$i]}"

    # Execute current application in the background of the current X Virtual Framebuffer
    ${curr_app} &
done


