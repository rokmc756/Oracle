
### Key Oracle RAC Grid Administration Commands
1. crsctl (Clusterware Control)

#### Status Checks
```bash
$ su - grid
$ crsctl check crs                            # Checks the status of the entire Oracle Clusterware stack (upper and lower)
$ crsctl check cluster                        # Checks the status of the upper stack (Oracle Clusterware)
$ crsctl check cluster -all                   # Checks the status of the cluster on all nodes
$ crsctl check cluster -n rk8-oracle02        # Checks the status of the cluster on a specific node
$ crsctl status resource -t                   # Displays the status of cluster resources in a table format
$ crsctl status server -f                     # Displays the status of cluster nodes and services
$ olsnodes -n                                 # Lists cluster nodes with their node numbers
```

#### Start/Stop Operations
```bash
$ sudo crsctl start crs                       # Starts the Oracle Clusterware stack on the local node
$ sudo crsctl stop crs                        # Stops the Oracle Clusterware stack on the local node
$ sudo crsctl start cluster -all              # Starts the Oracle Clusterware stack on all nodes
$ sudo crsctl stop cluster -all               # Stops the Oracle Clusterware stack on all nodes
$ sudo crsctl start cluster -n rk8-oracle02   # Starts the Oracle Clusterware stack on a specific node
$ sudo crsctl stop cluster -n rk8-oracle02    # Stops the Oracle Clusterware stack on a specific node
$ sudo crsctl disable has                     # Disables automatic startup of Oracle Clusterware on the local node
$ sudo crsctl enable has                      # Enables automatic startup of Oracle Clusterware on the local node
```

#### Other Operations
```bash
$ crsctl query css vote                       # Queries the voting disk information
$ crsctl replace css vote                     # Replaces a voting disk
$ ocrconfig -export <filename>                # Exports the Oracle Cluster Registry (OCR) configuration to a file
$ ocrconfig -import <filename>                # Imports the OCR configuration from a file
```

2. srvctl (Server Control):

#### Database Management
```bash
$ srvctl start database -d <database_name>                           # Starts the specified RAC database
$ srvctl stop database -d <database_name>                            # Stops the specified RAC database
$ srvctl start instance -d <database_name> -i <instance_name>        # Starts a specific instance of the database
$ srvctl stop instance -d <database_name> -i <instance_name>         # Stops a specific instance of the database
$ srvctl status database -d <database_name>                          # Checks the status of the specified database
$ srvctl status instance -d <database_name> -i <instance_name>       # Checks the status of the specified instance
```

#### Service Management:
```bash
$ srvctl add service -d <database_name> -s <service_name> -r <preferred_instance> -a <available_instances>       # Adds a new service to the database
$ srvctl start service -d <database_name> -s <service_name>                                                      # Starts a specific service
$ srvctl stop service -d <database_name> -s <service_name>                                                       # Stops a specific service
$ srvctl status service -d <database_name> -s <service_name>                                                     # Checks the status of a specific service
```


