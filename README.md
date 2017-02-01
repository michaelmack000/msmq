# jordan-msmq

Manages Microsoft message queues.


## Usage

```
msmq { 'nameofqueue':
  ensure        => present,
  private       => true,
  journal       => true,
  transactional => true,
  permissions   => [
  {
    user        => 'testdomain\testuser1', 
    permission  => 'FullControl'
  },
  {
    user        => 'testdomain\testuser2', 
    permission  => 'FullControl'
  },
  ],
}
```


## Permissions

Valid user permissions are as follows:

  * ChangeQueuePermissions
  * DeleteJournalMessage
  * DeleteMessage
  * DeleteQueue
  * FullControl
  * GenericRead
  * GenericWrite
  * GetQueuePermissions
  * GetQueueProperties
  * PeekMessage
  * ReceiveJournalMessage
  * ReceiveMessage
  * SetQueueProperties
  * TakeQueueOwnership
  * WriteMessage
