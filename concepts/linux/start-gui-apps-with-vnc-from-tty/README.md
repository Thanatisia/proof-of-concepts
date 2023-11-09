# Starting VNC server with GUI applications as a background process/daemon from the tty

## Information
### Description
```
within the tty - start up a GUI application, lets say firefox, in the background as a daemon/process using DISPLAY=:1

then afterwhich, starting up either a VNC server, or a Websocket server (i.e. NoVNC) that will point to that :1 display 
so that when I access the web/browser-based vnc client, it will go straight into firefox
so yeah, like as a background process such that when I run it, I will remain in the tty instead of going into the GUI application

the idea is that with this, I can startup as many GUI applications as I need/want as individual "VNC servers" and access them through the web browser
```

## Setup
### Dependencies
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

