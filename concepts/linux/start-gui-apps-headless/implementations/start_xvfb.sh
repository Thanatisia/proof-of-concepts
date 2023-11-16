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
declare -A xvfb_Settings=(
    ## X Virtual Framebuffer settings
    ["display"]=":6"
    ["screen"]="0" 
    ["resolution"]="1920x1080x16"
)
APPLICATIONS=("openbox" "alacritty")
dependencies=(${APPLICATIONS[@]} x11vnc websockify Xvfb)

setup()
{
    # Pre-Requisites

    ## Create directories
    mkdir -p "${PWD}/logs"

    ## Check if application is up
    for app in "${dependencies[@]}"; do
        # Get Process ID of current app
        process_ID=$(pgrep $app)
        if [[ ! -z "$process_ID" ]]; then
            # Not Empty
            ## Force kill the process
            echo -e "Killing: $app"
            kill -9 $process_ID
        fi
    done

    ## Set DISPLAY Environment Variable
    echo -e "Setting environment variable DISPLAY..."
    if [[ ${DISPLAY} != "${xvfb_Settings["display"]}" ]]; then
        # export DISPLAY=${xvfb_Settings["display"]}
        export DISPLAY=:6
    fi
}

main()
{
    # Begin start

    ## Startup X virtual framebuffer
    echo -e "Starting up X virtual framebuffer..."
    # Xvfb :6 -screen 0 1024x768x16 &
    Xvfb ${xvfb_Settings["display"]} -screen ${xvfb_Settings["screen"]} ${xvfb_Settings["resolution"]} &

    echo -e ""

    ## Startup GUI applications in the background of the current X Virtual Framebuffer
    for i in "${!APPLICATIONS[@]}"; do
        # Get current app
        curr_app="${APPLICATIONS[$i]}"

        echo -e "Starting: ${curr_app}"

        # Execute current application in the background of the current X Virtual Framebuffer
        ${curr_app} &
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup
    echo -e ""
    main "$@"
fi
