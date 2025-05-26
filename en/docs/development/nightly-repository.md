# Nightly Repository

!!! warning
    The Nightly Repository contains **automatically created** and **untested** builds of openITCOCKPIT.
    It is strongly recommended that the Nightly Repository is only used for test and development systems.

For openITCOCKPIT are two update channels available: **stable** and **nightly**. By default, openITCOCKPIT is always using the stable channel.

To test new features before the next stable release is available, you can change to the openITCOCKPIT nightly repository. It get's updated at irregular intervals and always contains the current version of openITCOCKPIT build from source. The builds are done automatically and published **without prior testing**!


## Switch to the Nightly Repository

After the change, the community or enterprise license key may have to be activated again.

### Debian
```
echo "deb [signed-by=/etc/apt/keyrings/openitcockpit-keyring.asc] https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/nightly $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
apt-get update
```

### Ubuntu
```
echo "deb [signed-by=/etc/apt/keyrings/openitcockpit-keyring.asc] https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/nightly $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
apt-get update
```

#### Ubuntu / Debian (Legacy)

Only use this, if the key of the openITCOCKPIT repository is stored in the legacy `trusted.gpg` keyring.

```
echo "deb https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/nightly $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
apt-get update
```

#### Update openITCOCKPIT
The update to the latest nightly version is done via the package manager.
```
apt-get dist-upgrade
```

## Switch to the Stable Repository

After the change, the community or enterprise license key may have to be activated again.

### Debian
```
echo "deb https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/stable $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
apt-get update
```

### Ubuntu
```
echo "deb https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/stable $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
apt-get update
```
