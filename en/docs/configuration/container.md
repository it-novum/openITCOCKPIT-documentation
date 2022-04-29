# Container

Containers are a core component of openITCOCKPIT and _the_ central component for authorising objects. Users, hosts,
cards, contacts, service templates and all other objects in openITCOCKPIT must be assigned to a container.

Containers decide which objects a user can see and edit.

The `root` container is the default container. All other containers created in the system are sub-containers of the root
container.

The containers are displayed in a tree structure in the container overview. Using this tree view, it is possible to add
and edit further containers for client, location and node types.

![Container overview](/images/configuration/containers-overview-tree.png)

### Container types

The following types of containers are available in openITCOCKPIT

- root
- tenant
- location
- node - generic container
- contact group
- host group
- service group
- service template group

### Root container

Objects that are stored in the root container are globally visible to all users on the system. The root container is
therefore ideal for objects intended for use by different organisational units or customers. Examples of this are the
time period `24x7` or the `Ping` service template

!!! danger "Important"
danger If you assign “important” objects to the root container, these cannot be moved to another container later! We
recommend you use tenant containers instead.

Users who have write access to the root container are global system administrators. They have the ability to view and
edit all objects. Global system administrators are marked with a gold crown.

![Root container users](/images/configuration/root-container-user.png){align=center}

### Permissions via containers

Containers determine which objects a user can see and edit. Multiple containers can be assigned to a given user. If the
user is only intended to have read access to the container, you must ensure that only the `read` option is set. For
write access this would need to be `read/write` access.

![User containers](/images/configuration/user-containers.png){align=center}

Container permissions can also be grouped into `container roles`. This means that permissions do not have to be manually
created and amended for all users.

In this example we assume the following container structure:

```
root
└── Demo Tenant (Tenant)
    ├── Team Data Center (Node)
    │   ├── Berlin (Location)
    │   └── Fulda (Location)
    └── Team Developers (Node)
        └── Fulda (Location)
```

openITCOCKPIT always displays the containers as a path:

```
/root/Demo Tenant/Team Data Center/Berlin
/root/Demo Tenant/Team Data Center/Fulda
/root/Demo Tenant/Team Developers/Fulda
```

Container permissions are always resolved from right to left.

- A user assigned to the `/root` container automatically becomes a global system administrator and can see and edit all
  objects
- If a user is assigned to `/root/Demo Tenant`, the user can see all the tenant's objects including all the tenant's
  sub-containers
- If a user is assigned to `/root/Demo Tenant/Team Developers`, the user can see objects in the tenant and the "Team
  Developers" container as well as all subcontainers
- If a user is assigned to `/root/Demo Tenant/Team Developers/Fulda`, the user can see objects in the tenant and the "
  Fulda" container as well as all subcontainers

## Tenants

Tenants are specific containers in openITCOCKPIT used for structuring and the granular administration of privileges.
Tenants can only be created as direct subcontainers of the root container.

Objects assigned to a tenant can be used by all users of that tenant. This makes tenants suitable for storing contacts,
contact groups, service templates and time periods intended for use by the entire organisation.

Tenants form the basis for further container types such as locations or nodes.

| Field       | Required                  | Description                        |
|-------------|---------------------------|------------------------------------|
| Name        | :fontawesome-solid-xmark: | Name of tenant to be created       |
| Description |                           | Tenant description                 |
| First name  |                           | First name of the tenant           |
| Last name   |                           | Last Name of the tenant            |
| Street name |                           | Street where the tenant is located |
| Postcode    |                           | Postcode of the tenant             |
| City        |                           | City where the tenant is located   |

## Locations

Locations are specific containers in openITCOCKPIT used for structuring and the granular administration of privileges.

If the `OpenStreetMapModule` is installed, hosts and services are automatically summarised on a map based on their
locations.

| Field       | Required                  | Description                                                                |
|-------------|---------------------------|----------------------------------------------------------------------------|
| Containers  | :fontawesome-solid-xmark: | Parent container of the location to be created                             |
| Name        | :fontawesome-solid-xmark: | Name of the location to be create                                          |
| Description |                           | Description of the location                                                |
| Latitude    |                           | Latitude of the location. This number must be between -90 and 90 degrees   |
| Longitude   |                           | Longitude of the location. The number must be between -180 and 180 degrees |
| Time zone   |                           | Location time zone                                                         |

## Nodes

A node container is usually used to represent internal structures and departments. A node can be assigned the same
object types as a location. A node requires a tenant.

Nodes are created via the tree view under `Management -> Container Management -> Containers`. You can also
create [tenants](#tenants) and [locations](#locations) here.

| Field | Required                  | Description                   |
|-------|---------------------------|-------------------------------|
| Name  | :fontawesome-solid-xmark: | Name of the node to be create |

## Container management

A list of all containers can be called up via the Container Management menu item. Various display options are available.

A detailed overview of the selected container can be called up via `Show details`. This will display a list of all
objects in the selected container. For a better overview, the container can also be displayed as a graph.

![Root containers users](/images/configuration/container-graph.png){align=center}
