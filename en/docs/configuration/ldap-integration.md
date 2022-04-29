# LDAP integration

For user authentication purpose openITCOCKPIT can be connected with an LDAP server.  It is recommended to use
_Microsoft Active Directory_. However, it is also possible to go with an _OpenLDAP Server_ but some functions may then
only be available to a limited extent or not at all.

## LDAP authentication

To enable authentication against LDAP, first
navigate to `System Configuration -> System -> `[`System Settings`](/configuration/systemsettings/)
to configure the LDAP server that should be used.

It is recommended to use _Microsoft Active Directory_.

### Microsoft Active Directory

| Key              | Beschreibung                                                                                                   | Beispiel                                                               |
|------------------|----------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|
| AUTH_METHOD      | Which authentication method should be used by openITCOCKPIT .                                                  | PHP LDAP                                                               |
| LDAP.TYPE        | If the LDAP Server is a Microsoft Active Directory or an Open LDAP Server                                      | Active Directory LDAP                                                  |
| LDAP.ADDRESS     | Hostname or IP address of the LDAP server                                                                      | ad.example.com                                                         |
| LDAP.PORT        | Port number (389 or 636)                                                                                       | 389                                                                    |
| LDAP.QUERY       | LDAP filter query which will be used to filter users                                                           | (&(objectClass=user)(samaccounttype=805306368)(objectCategory=person)(cn=*)) |
| LDAP.BASEDN      | This is the Base-DN that will be searched by openITCOCKPIT                                                     | DC=ad,DC=example,DC=com                                                |
| LDAP.USERNAME    | Username (sAMAccountName) used by openITCOCKPIT                                                                | ldap_search                                                            |
| LDAP.PASSWORD    | Password of the given username                                                                                 |                                                                        |
| LDAP.SUFFIX      | The suffix to use                                                                                              | @ad.example.com                                                        |
| LDAP.USE_TLS     | Plain = Plaintext, StartTLS = tries to establish an encrypted connection, TLS = forces an encrypted connection | StartTLS                                                               |
| LDAP.GROUP_QUERY | LDAP query to filter LDAP groups                                                                               | ObjectClass=Group                                                      |



### Open LDAP

| Key              | Beschreibung                                                                                                         | Beispiel                                      |
|------------------|----------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| AUTH_METHOD      | Which authentication method should be used by openITCOCKPIT .                                                        | `PHP LDAP`                                    |
| LDAP.TYPE        | If the LDAP Server is a Microsoft Active Directory or an Open LDAP Server                                            | `OpenLDAP`                                    |
| LDAP.ADDRESS     | Hostname or IP address of the LDAP server                                                                            | `open-ldap.oitc.itn`                          |
| LDAP.PORT        | Port number (389 or 636)                                                                                             | `389`                                         |
| LDAP.QUERY       | LDAP filter query which will be used to filter users                                                                 | `(&(objectClass=inetOrgPerson)(uid=*))`       |
| LDAP.BASEDN      | This is the Base-DN that will be searched by openITCOCKPIT                                                           | `dc=example,dc=com`                           |
| LDAP.USERNAME    | Username (as DN=Distinguished Name), used by openITCOCKPIT                                                           | `uid=ldap_search,ou=people,dc=example,dc=com` |
| LDAP.PASSWORD    | Password of the given username                                                                                       |                                               |
| LDAP.SUFFIX      | The suffix to use                                                                                                    | `<leer>`                                      |
| LDAP.USE_TLS     | Plain = Plaintext, StartTLS = tries to establish an encrypted connection, TLS = forces an encrypted connection       | `Plain`                                       |
| LDAP.GROUP_QUERY | LDAP query to filter LDAP groups                                                                                     | `ObjectClass=posixGroup`                      |


## Importing of users

Before an LDAP-user is able to login to the openITCOCKPIT interface, it is required to import the user first.
This is done under `User management -> Manage Users -> `[`Import from LDAP`](/configuration/usermanagement/#create-new-user-active-directory-ldap)

![Import LDAP User](/images/import-ldap-user.png)

This can also be used to test, if openITCOCKPIT can establish an connection with the LDAP server.

**It is highly recommended to create at least one local administrator user, to have access to openITCOCKPIT even if the LDAP server is unavailable.**

!!! important
    openITCOCKPIT requires that the following fields are not empty:

    Microsoft AD: `'samaccountname', 'mail', 'sn', 'givenname'`
    
    Open LDAP: `'uid', 'mail', 'sn', 'givenname'`
    
    Users that do not fullfill thes reqirement could not get imported into openITCOCKPIT.
    As soon as openITCOCKPIT drops users wie will geht a warning like this `2022-01-07 15:42:06 warning: Dropped 51/100 AD/LDAP users due to missing required fields. [samaccountname, mail, sn, givenname]` in the log file `/opt/openitc/frontend/logs/error.log`.

## Importieren von Gruppen
!!! info
    Requires openITCOCKPIT ≥ 4.4.0


openITCOCKPIT synchronizes LDAP groups every 24 hours into the local database.

It is possible to force the synchronization by executing the command `oitc cronjobs -f` manually.
```
Scan for new LDAP groups. This will take a while...
Imported 50 groups, removed 3 groups from database.
   Ok
```

## Automatic permissions via LDAP groups

openITCOCKPIT supports the automatic assignment of [User Container Roles](/configuration/usermanagement/#user-container-roles) and [User Roles](https://docs.openitcockpit.io/en/configuration/usermanagement/#manage-user-roles)
via LDAP groups. 
über LDAP-Gruppen. Obviously this is only available for users imported from LDAP.

For this purpose, openITCOCKPIT queries the current groups of all stored LDAP users every 24 hours and compares them with currently assigned the User Container Roles and User Roles.

This task can also be executed manually by running: `oitc cronjobs -f`.
```
Assign User Container Roles that have LDAP associations to users
Query LDAP groups from LDAP for user dziegler
Query LDAP groups from LDAP for user ibering
   Ok
```

### Assign LDAP groups to User Container Roles
Every User Container Role has the option get assigned to one (or many) LDAP groups. openITCOCKPIT uses this information to automatically assign
all users, which are member of the LDAP group(s) the particular User Container Role.

![Linking User Container Roles with LDAP groups](/images/ldap-user-container-roles.png)

A user can be assigned to multiple User Container Roles. This ensures maximum flexibility. User Container Roles manage, wich objects (hosts, service templates, reports, etc.)
the user is allowed to see and manipulate.

### Assign LDAP groups to User Roles
Every User Role can be assigned to one (or many) LDAP groups. openITCOCKPIT use this information to assign LDAP users automatically to one User Role on sign-in.
Due to the fact that a user can only be assigned one role, if there are multiple hits, the user roles are sorted alphabetically and the first user role is taken.
This way, a manual prioritization through the naming is possible.

![Linking User Roles with LDAP groups](/images/ldap-user-roles.png)

It is required that every user of openITCOCKPIT is assigned to an User Role. To achieve this, a `Fallback User Role` needs to be defined on the creation of new LDAP users.
This role will be assigned to the user, if no other User Role could be assigned to LDAP group matching to the user.

It is recommended to create a `LDAP Fallback User Role` with no user permissions. In case that no user role could be assigned to the user,
the user would only have access to the Dashboard of openITCOCKPIT itself.


In contrast to _User Container Roles_, User Roles decide what actions a user is allowed to perform.

### Importing a LDAP user with automatic group assignment (example)
In this example, a new user is imported via LDAP. The system automatically assigned the User Container Roles and the User Role to the user.
![Import a new LDAP-User and automatically assign user container roles and a user role](/images/import-ldap-user-auto-assign-groups.png)





