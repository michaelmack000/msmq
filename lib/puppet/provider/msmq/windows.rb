Puppet::Type.type(:msmq).provide(:windows) do
  desc "Manage a Microsoft Message Queue"
  confine :operatingsystem => :windows
  defaultfor :operatingsystem => :windows

  class String
    def to_bool
      return true if self =~ (/^(true|t|yes|y|1)$/i)
      return false if self.empty? || self =~ (/^(false|f|no|n|0)$/i)
      raise ArgumentError.new "invalid value: #{self}"
    end
  end

  def prefix
    return "[Reflection.Assembly]::LoadWithPartialName('System.Messaging');$msmq = [System.Messaging.MessageQueue];"
  end

  def name
    if @resource['private']
      return ".\\private$\\#{@resource['name']}"
    else
      return ".\\#{@resource['name']}"
    end
  end

  def create
    command = prefix

    # Should the queue be transactional?
    if @resource['transactional']
      command += "$q = $msmq::Create('#{name}', 1);"
    else
      command += "$q = $msmq::Create('#{name}');"
    end

    # Should the queue journal?
    command += '$q.UseJournalQueue = $TRUE;' if @resource['journal']

    # Who should have permissions to the queue?
    if @resource['permissions']
      @resource['permissions'].each do |user|
        command += "$q.SetPermissions('#{user['user']}',[System.Messaging.MessageQueueAccessRights]::#{user['permission']},[System.Messaging.AccessControlEntryType]::Allow);"
      end
    end

    # Run the command
    `powershell.exe "#{command}"`
  end

  def destroy
    `powershell.exe "#{prefix} $msmq::Delete('#{name}')"`
  end

  def exists?
    return `powershell.exe "#{prefix}$msmq::Exists('#{name}')"`.to_bool
  end
end
