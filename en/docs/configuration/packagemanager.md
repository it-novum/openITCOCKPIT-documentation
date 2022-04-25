# Package manager

The openITCOCKPIT package manager allows modules to be installed in openITCOCKPIT. These modules are either free of charge or available via subscription. The modules are colour-coded. Free modules are shown in blue, while enterprise-level modules are red.

## Prerequisites

A valid licence is required to use the package manager. To gain access to the free modules you need to have at least a community licence which you can find on the [openitcockpit.io website](https://openitcockpit.io/download_server/). This licence must be entered in openITCOCKPIT.
Access to the server's console must also be provided.

## Installing modules

Installing modules is simple. The overview page of the package manager lists the different modules that are available. To install a single, individual module, click on the "Install" button for that module. A window will then open and display the commands required for managing packages for the particular operating system hosting the openITCOCKPIT server.

![packagemanager single install](/images/packagemanager-installpackages.png)

Copy the text inside the black area and paste it into the server console. The operating system's package management will take care of the rest. When the installation has been completed, the text `Installation done. Please reload your openITCOCKPIT web interface` will appear in the console.

To install multiple modules at the same time, put a tick in the checkbox next to each item instead of clicking "Install". The window (as shown in the screenshot) will open again. You can close this and then tick the next module. The commands will expand automatically. When you have ticked all the desired modules, copy the commands again and paste them into the server's console. When the installation has been completed, the text `Installation done. Please reload your openITCOCKPIT web interface will appear in the console.`

![packagemanager multiinstall](/images/packagemanager-installpackagesmulti.png)
