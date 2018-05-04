# Carapi API Specification

## Contents

- [Local Setup](#localsetup)
- [Code Walk-through](#walkthrough)
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

### <a name="walkthrough">Code Walk-through</a>

Thank you for the opportunity to share my solution to the code challenge and for taking the time to look around!
As you go through the project, please feel free to leave comments, suggestions, or questions.  The point of this section
is the hopefully give you a basic understanding of the code structure.  While the API itself is fairly limited in 
functionality, what's under the hood was a fun exercise in abstraction and metaprogramming.


Let's start with the [controllers](https://github.com/PositiveControl/CarApi/tree/master/app/controllers/api/v1), there are four of them all
namespaced under `Api::V1`.  After looking at two of them, you might wonder: "Did this guy just copy and paste his controllers?".  Why yes I did!

#### How the API is kind of neat

All of the controllers follow the same pattern, using `pipe-ruby` (think of it as *nix pipe for Ruby, also anologous to `|>` in Elixir) they ingest a request, then using the parameters from the 
request, the controller action initializes a response hash that gets passed to each method in the pipe, building a response hash that is ultimately serialized
and returned to the client.  Using this pattern allowed me to extract CRUD methods for all controllers into [`CarApiCommon::Controllers`](https://github.com/PositiveControl/CarApi/blob/master/app/controllers/concerns/car_api_common.rb).
The methods in this module mirror the methods called in the controller pipe with one key difference, instead of `build_vehicle` we have
[`build_object`](https://github.com/PositiveControl/CarApi/blob/master/app/controllers/concerns/car_api_common.rb#L7) and its method signature is `(response, klass, klass_sym)`.  Like the controller methods, it accepts a response 
and returns a mutated version of the response hash.  But unlike the controller methods, it requires `klass` string and `klass_sym` symbol to correctly
route the request.  All method calls in the controller pipe action (sans `initialize_response`) are routed through [`method_missing`](https://github.com/PositiveControl/CarApi/blob/master/app/controllers/concerns/car_api_common.rb#L82).  However, as can be seen
in [ModelsController](https://github.com/PositiveControl/CarApi/blob/master/app/controllers/api/v1/models_controller.rb)#index, you can easily add methods to the pipe
at various points to affect the response (ex. [`filter_results`](https://github.com/PositiveControl/CarApi/blob/master/app/controllers/api/v1/models_controller.rb#L39))

Another one of the by-products of using this pattern was that testing was greatly simplified, once I wrote the tests for both success and failure contexts for the first controller, I was able to use the same 
tests (with minor alterations) for each successive controller, resulting in near 100% test coverage with little effort after writing the first set of tests.

Serialization is handled through Netflix's `fast-jsonapi` gem.  This was my first time using it and I found it ridiculously easy to implement.

#### How the API kind of sucks
Wonderful... I told how cool the API is, how about how it kinda sucks?  It is called Carapi API after all.  First off, it really doesn't do much, you can create and mutate 
objects from each endpoint and assign a model to a make, or get all the models for a given make, but there's not much else.
There's a glaring problem in the Update and Destroy controller actions, they both do two DB queries (select & update/destroy). These actions should be a single query.
Endpoint error handling is currently handled in [`CarApiCommon::Controllers`](https://github.com/PositiveControl/CarApi/blob/master/app/controllers/concerns/car_api_common.rb),
as that module gets more complex, error handling should be extracted into its own module.

Thanks again for taking the time to check this out.  I appreciate any and all feedback.

Cheers,

Mark Evans

### Controller Data Flow

```
Request >
    Initialize Response ({}) > Validate/Build/Save Object > Serialize Response >
        Response
```
 




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