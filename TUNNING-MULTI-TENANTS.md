# Why does the CUSTOM “Create Container Database” take so long?
There is more than one reason for the long duration of the CREATE DATABASE statement for a Multitenant container database.
Apart from the UNDO resize operations which slows down the run maybe a tiny bit, one of the main reasons is a conceptual decision:
The dictionary gets created in the CDB$ROOT at first. And then it will be created in the PDB$SEED.
You won’t see any parallelism.

Hence, a Multitenant container database creation in CUSTOM mode where all the scripts get executed takes a least twice as long as a regular non-CDB creation.

In addition, in the alert.log, you will find a lot of warnings leading to trace files being written:

```yaml
2018-11-12T11:19:23.034488+01:00
KGL object name :grant read on ku$_zm_view_pfh_view to public
2018-11-12T11:20:24.515554+01:00
Memory Notification: Library Cache Object loaded into SGA
Heap size 52749K exceeds notification threshold (51200K)
Details in trace file /u01/app/oracle/diag/rdbms/hugo/HUGO/trace/HUGO_ora_9833.trc
```

You may of course ignore this as you potentially don’t create a container database every day. Hence, the impact may be very low. But just in case you wonder …

What do these warnings mean? MOS Note: 330239.1 explains:

```
As large objects in the shared pool can potentially cause problems this warning threshold was implemented.
Items/SQLs which allocate more space than this warning threshold, outputs a warning to the alert log.
This warning is only to inform that a given heap object exceeds the defined threshold size and 
a trace file is generated so that a DBA can check potentially expensive – from shared memory point of view – objects.
These are purely warning messages and have no impact on the database functionality, although they are designed to
indicate possible tuning opportunities in customers’ applications.
```

Hence no issue. But still traces get written constantly. The default of _kgl_large_heap_warning_threshold is 52428800 (52MB).
Since Oracle 12.1, _kgl_large_heap_assert_threshold got introduced and set to the same value as _kgl_large_heap_warning_threshold by default.

And finally, there are forced recompilations in the PDB$SEED as we see them during upgrade as well. which don’t happen in non-CDB databases. See:

- Why does the upgrade of PDB$SEED always take longer?
```
2018-11-12T11:52:49.154626+01:00
PDB$SEED(2):KGL object name :ALTER VIEW "KU$_M_ZONEMAP_PFH_VIEW" COMPILE
2018-11-12T11:53:07.903288+01:00
PDB$SEED(2):Memory Notification: Library Cache Object loaded into SGA
Heap size 52562K exceeds notification threshold (51200K)
Details in trace file /u01/app/oracle/diag/rdbms/hugo/HUGO/trace/HUGO_ora_9833.trc
2018-11-12T11:53:07.903365+01:00
PDB$SEED(2):KGL object name :ALTER VIEW "KU$_M_ZONEMAP_PIOT_VIEW" COMPILE
```

The CUSTOM creation of the Multitenant Container database did take almost exactly 60 minutes in my environment (VBox, laptop SSD).
Just for the records: A non-CDB creation on the same system with the same characteristics takes me 28 minutes.


