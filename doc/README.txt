----------------------------------------------

Author: Javier Rodríguez Inés
Email: javier.ri94@outlook.com

----------------------------------------------


Tests can be executed with rake


Questions:

1. How would you improve your solution?

	The implemented solution is very general and has many points that must be revised in order to improve the efficience and security of the system. This solution can improve security and control issues especialy over the transfers

2. How you adapt your solution if transfers are not instantaneous

	In this case I would implement a queue of transfers and a rollback system so the process of the transfers between two different banks would be asynchronous and without blocking any system, this way we can improve the performance of the system by queuing the transfers in order to process in a moment of low charge in the server. This solution also permits to wait for another bank confirm to close a transfer

