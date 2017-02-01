Puppet::Type.newtype(:msmq) do
  ensurable

  possible_permissions = [
    'ChangeQueuePermissions',
    'DeleteJournalMessage',
    'DeleteMessage',
    'DeleteQueue',
    'FullControl',
    'GenericRead',
    'GenericWrite',
    'GetQueuePermissions',
    'GetQueueProperties',
    'PeekMessage',
    'ReceiveJournalMessage',
    'ReceiveMessage',
    'SetQueueProperties',
    'TakeQueueOwnership',
    'WriteMessage',
  ]

  newparam(:name) do
    desc "The name of the queue."
    validate do |value|
      if value =~ /[\/,\\]/
        raise ArgumentError, 'Service name must not contain the following values: /,\\' % value
      end
    end
  end

  newparam(:private) do
    desc "Sets the queue's private attribute"
  end

  newparam(:journal) do
    desc "Sets the queue's journal attribute"
  end

  newparam(:transactional) do
    desc "Sets the queue's transactional attribute"
  end

  newparam(:permissions) do
    desc "Sets the queue's permissions"
    validate do |value|
      value.each do |user|
        unless possible_permissions.include? user['permission']
          raise ArgumentError , "#{user['permission']} is not a valid queue permission"
        end
      end
    end
  end
end
