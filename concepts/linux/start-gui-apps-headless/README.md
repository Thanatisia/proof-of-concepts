# Starting GUI applications as a background process/daemon from the tty

## Information
### Description
```
within the tty - start up a GUI application, lets say firefox, in the background as a daemon/process using DISPLAY=:1

This will startup the GUI in a Xorg Display Server non-graphical (virtual) framebuffer where the rendering will be performed in the background
```

## Setup
### Dependencies
+ Xvfb : X Display Server Virtual Framebuffer
+ x11vnc : A VNC server of your choice; i.e. x11vnc, tigervnc
+ websockify : A Websocket server of your choice; i.e. websockify. The Websocket server will "intercept" the VNC server interface's GUI render and display in the VNC client
+ novnc : A Browser/Web-based VNC client that will be used alongside a Websocket server; The Websocket server will "intercept" the VNC server interface's GUI render and display in this client

### Pre-Requisites
- Set Environment Variable
    ```console
    export DISPLAY=:[display-monitor]
    ```

## Documentations
### Contents
- [Proof-of-Concept Template Source Code](templates/start_xvfb.sh)
- Scripts and Custom Implementations based on this concept
    + [Simple and Functional X Virtual Framebuffer runner script](implementations/start_xvfb.sh)

### Usage
- Basic Xorg Display Server headless startup
    - Startup Virtual Framebuffer
        ```console
        Xvfb :[display-number] &
        ```
    - Export DISPLAY environment variable to the display number
        ```console
        export DISPLAY=:[display-number]
        ```
    - Post-Setup
        - Ideas
            + Running in a VNC server for display
            + Running GUI applications headlessly for testing

## Wiki
### Terminologies
+ Framebuffer: A framebuffer is a virtual memory container that will hold display data used to well, display - such as Graphical Environments and/or render them

### Notes and Findings
- This primarily requires the '$DISPLAY' environment variable to point to the target Virtual display you want to render the graphical environment within
    + Without the '$DISPLAY' environment variable, the display server is unable to render the application and throws an error
    - This is also how xinit and startx is implemented
        + These 2 functions also uses '$DISPLAY' to run graphical applications from within the host
        - This also allow the user to startup Graphical Applications directly from the TTY
            - Pre-Requisites
                - Set Environment Variable for that session/terminal
                    ```console
                    export DISPLAY=:[display-monitor-number]
                    ```
            - Startup Graphical environments from the tty
                - Using startx
                    ```console
                    startx [xinitrc] [application-name] :[display-monitor]
                    ```
                - Using xinit
                    ```console
                    xinit [xinitrc|application-name] -- /usr/bin/X :[display-monitor]
                    ```
        - With this, you do not need a window manager or a desktop environment to run a GUI application
            + You can just run the GUI application from the tty

## Resources

## References

## Remarks

