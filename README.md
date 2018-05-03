# Carapi API Specification

## Contents

- [Local Setup](#localsetup)
- [Response/Request Format](#formats)
- [Endpoints Overview](#endpoints)
- [Endpoints in Detail](#detail) 



### <a name="localsetup">Local Setup</a>
Requirements: 
* Ruby 2.5.0 (I believe it does work on 2.4)
* Rails 5.0.1
* PostgreSQL


1. Clone repository
2. `bundle install`
3. `rake db:setup`
4. `rake db:migrate`
5. `rake db:seed`
6. `be rspec spec`
7. `rails server`


### Request Format

```json
{ 
    "data": {
        "<attribute>":"<value>"
    }
}
```

### Response Format

```json
{
    "data": {
        "id": "<id>",
        "type": "<class>",
        "attributes": {
            "<attribute>": "<value>"
        }
    }
}
```


## <a name="endpoints">Endpoints Overview</a>
#### Base URL = api/v1
All endpoints support GET, PUT/PATCH, POST and DELETE HTTP actions.

### [/vehicles](#vehicles)
Top-level object that defines the `utility_class` (e.g. Sedan, Coupé, Truck, etc.)
  - GET /vehicles
  - GET /vehicles/:id
  - POST /vehicles
  - PUT /vehicles/:id
  - DELETE /vehicles/:id

### [/makes](#makes)
Makes are brands of vehicles (i.e. `"brand":"Toyota"` )
  - GET /makes
  - GET /makes/:id
  - POST /makes
  - PUT /makes/:id
  - DELETE /makes/:id

### [/makes/:id/models](#models)
Models are Make-specific and belong to a Make
  - GET /makes/:id/models
  - GET /makes/:id/models/:id
  - POST /makes/:id/models
  - PUT /makes/:id/models/:id
  - DELETE /makes/:id/models/:id
  
### [/options](#options)
Options are general, and unique on Option#name. For instance, there can only be one `"Power Window"` Option that can be referenced by many Models.
  - GET /options
  - GET /options/:id
  - POST /options
  - PUT /options/:id
  - DELETE /options/:id



# <a name="detail">Endpoints in Detail</a>

## <a name="vehicles">/vehicles</a>

#### POST - Create
Attributes: utility_class (string; required)

Request body:
```
{ 
    "data": {
        "utility_class":"Dump Truck"
    }
}
```
Response body (201 Created):
```
```

## /vehicles/:id

#### GET - Show
Attributes: none

Request body:
```

```

Response body (200 OK):
```
{
    "data": {
        "id": "1",
        "type": "vehicle",
        "attributes": {
            "utility_class": "Dump Truck"
        }
    }
}
```

## /vehicles/:id

#### PUT - Update
Attributes: utility_class (string; required)

Request body:
```
{ 
    "data": {
        "utility_class":"Earth Mover"
    }
}
```

Response body (200 OK):
```
{
    "data": {
        "id": "1",
        "type": "vehicle",
        "attributes": {
            "utility_class": "Earth Mover"
        }
    }
}
```

## /vehicles/:id

#### DELETE - Delete
Attributes: none

Request body:
```
```

Response body (201 Created):
```
```

## /vehicles

#### GET - Index
Attributes: none

Request body:
```
```

Response body (200 OK):
```
{
    "data": [
        {
            "id": "2",
            "type": "vehicle",
            "attributes": {
                "utility_class": "Sedan"
            }
        },
        {
            "id": "3",
            "type": "vehicle",
            "attributes": {
                "utility_class": "Coupé"
            }
        },
        {
            "id": "4",
            "type": "vehicle",
            "attributes": {
                "utility_class": "Truck"
            }
        },
        {
            "id": "5",
            "type": "vehicle",
            "attributes": {
                "utility_class": "SUV"
            }
        },
        {
            "id": "6",
            "type": "vehicle",
            "attributes": {
                "utility_class": "Earth Mover"
            }
        }
    ]
}
```



## <a name="makes">/makes</a>

#### POST - Create
Attributes: brand (string; required)

Request body:
```
{ 
    "data": {
        "brand":"Pagani"
    }
}
```
Response body (201 Created):
```
```

## /makes/:id

#### GET - Show
Attributes: none

Request body:
```

```

Response body (200 OK):
```
{
    "data": {
        "id": "1",
        "type": "make",
        "attributes": {
            "brand": "Pagani"
        }
    }
}
```

## /makes/:id

#### PUT - Update
Attributes: brand (string; required)

Request body:
```
{ 
    "data": {
        "brand":"Pagani"
    }
}
```

Response body (200 OK):
```
{
    "data": {
        "id": "1",
        "type": "make",
        "attributes": {
            "brand": "Pagani"
        }
    }
}
```

## /makes/:id

#### DELETE - Delete
Attributes: none

Request body:
```
```

Response body (201 Created):
```
```

## /makes

#### GET - Index
Attributes: none

Request body:
```
```

Response body (200 OK):
```
{
    "data": [
        {
            "id": "2",
            "type": "make",
            "attributes": {
                "brand": "Pagani"
            }
        },
        {
            "id": "3",
            "type": "make",
            "attributes": {
                "brand": "Koenigsegg"
            }
        },
        {
            "id": "4",
            "type": "make",
            "attributes": {
                "brand": "Geo"
            }
        },
        {
            "id": "5",
            "type": "make",
            "attributes": {
                "brand": "Saturn"
            }
        }
    ]
}
```

## <a name="models">/makes/:id/models</a>

#### POST - Create
Attributes: model_title, make_id (string, integer; both required)

Request body:
```
{ 
    "data": {
        "model_title":"Zonda",
        "make_id": "1"
    }
}
```
Response body (201 Created):
```
```

## /makes/:id/models/:id

#### GET - Show
Attributes: none

Request body:
```

```

Response body (200 OK):
```
{
    "data": {
        "id": "1",
        "type": "model",
        "attributes": {
            "model_title": "Zonda",
            "make_id": "1"
        }
    }
}
```

## /makes/:id/models/:id

#### PUT - Update
Attributes: model_title (string; required)

Request body:
```
{ 
    "data": {
        "model_title":"Zonda Cinque Roadster"
    }
}
```

Response body (200 OK):
```
{
    "data": {
        "id": "1",
        "type": "model",
        "attributes": {
            "model_title": "Zonda Cinque Roadster",
            "make_id": "1"
            
        }
    }
}
```

## /makes/:id/models/:id

#### DELETE - Delete
Attributes: none

Request body:
```
```

Response body (201 Created):
```
```

## /makes/:id/models

#### GET - Index
Attributes: none

Request body:
```
```

Response body (200 OK):
```
{
    "data": [
        {
            "id": "2",
            "type": "model",
            "attributes": {
                "model_title": "Zonda",
                "make_id": "1"
            }
        },
        {
            "id": "3",
            "type": "model",
            "attributes": {
                "model_title": "Huayra",
                "make_id": "1"
            }
        },
        {
            "id": "4",
            "type": "model",
            "attributes": {
                "model_title": "Metro",
                "make_id": "2"
            }
        },
        {
            "id": "5",
            "type": "model",
            "attributes": {
                "model_title": "Focus",
                "make_id": "3"
            }
        }
    ]
}
```

## <a name="options">/options</a>

#### POST - Create
Attributes: description; name (string; required, unique)

Request body:
```
{ 
    "data": {
        "name":"W16 Engine",
        "description":"So many power!"
    }
}
```
Response body (201 Created):
```
```

## /options/:id

#### GET - Show
Attributes: none

Request body:
```

```

Response body (200 OK):
```
{
    "data": {
        "id": "1",
        "type": "option",
        "attributes": {
            "name": "W16 Engine",
            "description":"So many power!"
        }
    }
}
```

## /options/:id

#### PUT - Update
Attributes: description; name (string; required, unique)

Request body:
```
{ 
    "data": {
        "description":"Eats too much gas."
    }
}
```

Response body (200 OK):
```
{
    "data": {
        "id": "1",
        "type": "option",
        "attributes": {
            "name": "W16 Engine",
            "description":"Eats too much gas."
        }
    }
}
```

## /options/:id

#### DELETE - Delete
Attributes: none

Request body:
```
```

Response body (201 Created):
```
```

## /options

#### GET - Index
Attributes: none

Request body:
```
```

Response body (200 OK):
```
{
    "data": [
        {
            "id": "2",
            "type": "option",
            "attributes": {
                "name": "W16 Engine",
                "description":"Eats too much gas."
            }
        },
        {
            "id": "3",
            "type": "option",
            "attributes": {
                "name": "Tinted Windows",
                "description":"Blocks the sun."
            }
        },
        {
            "id": "4",
            "type": "option",
            "attributes": {
                "name": "Sport Exhaust",
                "description":"Better than a Cherry Bomb."
            }
        },
        {
            "id": "5",
            "type": "option",
            "attributes": {
                "name": "20-inch wheels",
                "description":"They see me rollin'..."
            }
        }
    ]
}
```