

### Check the status of Grid Infrastructure
```bash
su - grid

crsctl status res -t
--------------------------------------------------------------------------------
Name           Target  State        Server                   State details
--------------------------------------------------------------------------------
Local Resources
--------------------------------------------------------------------------------
ora.LISTENER.lsnr
               ONLINE  ONLINE       rk8-oracle02             STABLE
               ONLINE  ONLINE       rk8-oracle03             STABLE
ora.chad
               ONLINE  ONLINE       rk8-oracle02             STABLE
               ONLINE  ONLINE       rk8-oracle03             STABLE
ora.net1.network
               ONLINE  ONLINE       rk8-oracle02             STABLE
               ONLINE  ONLINE       rk8-oracle03             STABLE
ora.ons
               ONLINE  ONLINE       rk8-oracle02             STABLE
               ONLINE  ONLINE       rk8-oracle03             STABLE
--------------------------------------------------------------------------------
Cluster Resources
--------------------------------------------------------------------------------
ora.ASMNET1LSNR_ASM.lsnr(ora.asmgroup)
      1        ONLINE  ONLINE       rk8-oracle02             STABLE
      2        ONLINE  ONLINE       rk8-oracle03             STABLE
ora.DATA.dg(ora.asmgroup)
      1        ONLINE  ONLINE       rk8-oracle02             STABLE
      2        ONLINE  ONLINE       rk8-oracle03             STABLE
ora.LISTENER_SCAN1.lsnr
      1        ONLINE  ONLINE       rk8-oracle03             STABLE
ora.LISTENER_SCAN2.lsnr
      1        ONLINE  ONLINE       rk8-oracle03             STABLE
ora.LISTENER_SCAN3.lsnr
      1        ONLINE  ONLINE       rk8-oracle02             STABLE
ora.asm(ora.asmgroup)
      1        ONLINE  ONLINE       rk8-oracle02             Started,STABLE
      2        ONLINE  ONLINE       rk8-oracle03             Started,STABLE
ora.asmnet1.asmnetwork(ora.asmgroup)
      1        ONLINE  ONLINE       rk8-oracle02             STABLE
      2        ONLINE  ONLINE       rk8-oracle03             STABLE
ora.cdp1.cdp
      1        ONLINE  ONLINE       rk8-oracle03             STABLE
ora.cdp2.cdp
      1        ONLINE  ONLINE       rk8-oracle03             STABLE
ora.cdp3.cdp
      1        ONLINE  ONLINE       rk8-oracle02             STABLE
ora.cvu
      1        ONLINE  ONLINE       rk8-oracle03             STABLE
ora.qosmserver
      1        ONLINE  ONLINE       rk8-oracle03             STABLE
ora.rk8-oracle02.vip
      1        ONLINE  ONLINE       rk8-oracle02             STABLE
ora.rk8-oracle03.vip
      1        ONLINE  ONLINE       rk8-oracle03             STABLE
ora.scan1.vip
      1        ONLINE  ONLINE       rk8-oracle03             STABLE
ora.scan2.vip
      1        ONLINE  ONLINE       rk8-oracle03             STABLE
ora.scan3.vip
      1        ONLINE  ONLINE       rk8-oracle02             STABLE
--------------------------------------------------------------------------------
```

### Check Disk Info Added
```bash
$ ocrcheck
Status of Oracle Cluster Registry is as follows :
         Version                  :          4
         Total space (kbytes)     :     901284
         Used space (kbytes)      :      84832
         Available space (kbytes) :     816452
         ID                       :  316362664
         Device/File Name         :      +DATA
                                    Device/File integrity check succeeded

                                    Device/File not configured

                                    Device/File not configured

                                    Device/File not configured

                                    Device/File not configured

         Cluster registry integrity check succeeded

         Logical corruption check bypassed due to non-privileged user
```


crsctl stop res -all

