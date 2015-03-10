# useful for older versions of chef-client before pending_reboot? was implemented.
# use for pattern 3

class Chef
  class Resource
    # include Chef::Mixin::ShellOut

    def reboot_pending_old?
      # Any files listed here means reboot needed
      (Registry.key_exists?('HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\PendingFileRenameOperations') &&
        Registry.get_value('HKLM\SYSTEM\CurrentControlSet\Control\Session Manager', 'PendingFileRenameOperations').any?) ||
      # 1 for any value means reboot pending
      # "9306cdfc-c4a1-4a22-9996-848cb67eddc3"=1
      (Registry.key_exists?('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired') &&
        Registry.get_values('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired').select { |v| v[2] == 1 }.any?) ||
      # 1 or 2 for 'Flags' value means reboot pending
      (Registry.key_exists?('HKLM\SOFTWARE\Microsoft\Updates\UpdateExeVolatile') &&
        [1, 2].include?(Registry::get_value('HKLM\SOFTWARE\Microsoft\Updates\UpdateExeVolatile', 'Flags'))) ||
      # added by Alex
      Registry.key_exists?('HKLM\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending')
    end
  end
end