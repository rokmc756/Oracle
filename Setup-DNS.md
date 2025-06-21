### Setup DNS with FreeIPA
#### 1) Configure Varialbes for DNS Zone and Records
```
_dns:
  freeipa:
    ipaddr: 192.168.2.199
    sudo_user: jomoon
    password: changeme
  zone:
    - { name: jtest:1.pivotal.io, type: forward }
    - { name: 2.168.192.in-addr.arpa, type: reverse }
  resource:
    forward:
      - {  name: "rk8-oracle01",       zone: "jtest.pivotal.io",  type: "-a-rec",  value: "192.168.2.241"  }
      - {  name: "rk8-oracle02",       zone: "jtest.pivotal.io",  type: "-a-rec",  value: "192.168.2.242"  }
      - {  name: "rk8-oracle03",       zone: "jtest.pivotal.io",  type: "-a-rec",  value: "192.168.2.243"  }
      - {  name: "rk8-oracle01-vip",   zone: "jtest.pivotal.io",  type: "-a-rec",  value: "192.168.2.244"  }
      - {  name: "rk8-oracle02-vip",   zone: "jtest.pivotal.io",  type: "-a-rec",  value: "192.168.2.245"  }
      - {  name: "rk8-oracle03-vip",   zone: "jtest.pivotal.io",  type: "-a-rec",  value: "192.168.2.246"  }
      - {  name: "racdb01-scan",       zone: "jtest.pivotal.io",  type: "-a-rec",  value: "192.168.2.237"  }
      - {  name: "racdb01-scan",       zone: "jtest.pivotal.io",  type: "-a-rec",  value: "192.168.2.238"  }
      - {  name: "racdb01-scan",       zone: "jtest.pivotal.io",  type: "-a-rec",  value: "192.168.2.239"  }
    reverse:
      - { name: "237",  zone: 2.168.192.in-addr.arpa,  type: "--ptr-rec", value: "racdb01-scan.jtest.pivotal.io."  }
      - { name: "238",  zone: 2.168.192.in-addr.arpa,  type: "--ptr-rec", value: "racdb01-scan.jtest.pivotal.io."  }
      - { name: "239",  zone: 2.168.192.in-addr.arpa,  type: "--ptr-rec", value: "racdb01-scan.jtest.pivotal.io."  }
      - { name: "241",  zone: 2.168.192.in-addr.arpa,  type: "--ptr-rec", value: "rk8-oracle01.jtest.pivotal.io."  }
      - { name: "242",  zone: 2.168.192.in-addr.arpa,  type: "--ptr-rec", value: "rk8-oracle02.jtest.pivotal.io."  }
      - { name: "243",  zone: 2.168.192.in-addr.arpa,  type: "--ptr-rec", value: "rk8-oracle03.jtest.pivotal.io."  }
      - { name: "244",  zone: 2.168.192.in-addr.arpa,  type: "--ptr-rec", value: "rk8-oracle01-vip.jtest.pivotal.io."  }
      - { name: "245",  zone: 2.168.192.in-addr.arpa,  type: "--ptr-rec", value: "rk8-oracle02-vip.jtest.pivotal.io."  }
      - { name: "246",  zone: 2.168.192.in-addr.arpa,  type: "--ptr-rec", value: "rk8-oracle03-vip.jtest.pivotal.io."  }
```

#### 2) Add DNS Zones and Records
```
$ make dns r=config s=zone
$ make dns r=config s=record
or
$ make dns r=config s=all
```

#### 3) Remove DNS Zones and Records
```yaml
$ make dns r=deconfig c=record
$ make dns r=deconfig c=zone
or
$ make dns r=deconfig c=all
```

