reboot_demo Cookbook
====================
This cookbook shows patterns for handling reboots on windows.
These patterns allow for a single continuous chef client run across multiple reboots.

There are a couple of common scenarios for reboots:
* No reboot pending condition needs to exist in order to install an item/feature.
* Reboot needs to happen after installation of a component.
* Reboot needs to happen at the end of the chef run.
* Combination of conditions.
* Join AD as part of the chef client run

Patterns:
* Pattern 1 - Wrapper recipe pattern.
> This pattern will run through the list of recipes and skip the entire recipe is there is a pending reboot.
> This is useful when you need multiple reboots during the chef client run.

* Pattern 2 - Resource level reboot handling.
> This pattern leverages the reboot_pending? method in Chef. Usefull for skipping resources which depend on no-reboot-pending condition.
> For example, some roles and some patches require that there is no pending reboot prior to installation.
> original prototype here: http://www.toddpigram.com/2013/10/testing-puppet-and-chef-cant-decide.html

* Pattern 3 - using custom library to determine state.
> Useful if your application has specific requirements for rebooting.
> Useful for older versions of chef-client before pending_reboot? was implemented.

* Pattern 4 - Reboot handler
> Using reboot handler from the Windows cookbook
> This will cause a reboot at the end of the chef client run

* Pattern 5 - Immediately rebooting in a middle of chef client run.
> Using 'raise' to elegantly end the chef run immediately and reboot.
> Will still run report handlers at the end.
> Force terminating the chef run will result handlers being skipped.
> in this scenario node will not be saved because raise exits the chef run. If state needs to be captured, use node.save

* Pattern 6 - using reboot resource
> introduced in chef-client 12.x.x

* Pattern 7 - using guard interpreter
> Using guard interpeter for custom reboot detection
> borrowed from https://gallery.technet.microsoft.com/scriptcenter/Get-PendingReboot-Query-bdb79542


Contributing
------------

1. Fork the repository on Github
1. Create a named feature branch (like `add_component_x`)
1. Write your change
1. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Alex Vinyar

TODO: 
Add better examples for joining to AD and continuing the chef client run as a domain user.
