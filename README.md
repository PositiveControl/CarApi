# Carapi API Specification

#### Base URL = api/v1

## /vehicles

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
                "utility_class": "Crossover"
            }
        },
        {
            "id": "7",
            "type": "vehicle",
            "attributes": {
                "utility_class": "Motorcycle"
            }
        },
        {
            "id": "8",
            "type": "vehicle",
            "attributes": {
                "utility_class": "Earth Mover"
            }
        }
    ]
}
```