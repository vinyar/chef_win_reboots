# This pattern will run through the list of recipes and skip the entire recipe is there is a pending reboot.
# wrapper recipe. This is useful when you need multiple reboots during the chef client run.

# install a role that requires a reboot
# install a patch that requires a reboot
# join to domain
# install a component that depends on a box being part of the ad


include_recipe 'example::_worker1' unless reboot_pending?

include_recipe 'example::_worker2' unless reboot_pending?

include_recipe 'example::_worker3' unless reboot_pending?


