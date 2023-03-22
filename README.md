
# DecorationDiy API

Hello and welcome to our API! Our API is designed to offer tutorials and guidance for Decoration DIY projects. We understand that starting a new project can be daunting, especially if you lack the necessary skills or experience. That's why we're here to help.

Whether you're a seasoned DIY expert or just starting out, our API has something for everyone. We believe that everyone has the potential to create something amazing, and we're here to help you do just that. So why not give our API a try and see how we can help you bring your DIY projects to life?



## Getting started
Our API is available at  https://decorationdiy-api.herokuapp.com/v1 , and responses are sent as JSON

## API Reference

### User object

| Attribute Name | Type  |  Description   |
| :-------- | :------- | :------------------------- |
| `firstName` | `String` | **Required** |
| `lastName` | `String` | **Required** |
| `socialMedia` | `String` | Optional |
| `picture` | `String` | Optional |
| `projects` | `[Diy]` | Array of user's projects |

#### Get all users

```http
  GET https://decorationDiyAPI.net/v1/user
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `None` | `None` | `None` |

##### Example of API call & response

<img><img width="1080" alt="Pasted Graphic 3" src="https://user-images.githubusercontent.com/103580674/226640467-f3840532-b3ce-49ce-820d-5f57e834ee5d.png">
</img>



#### Get all user's project

```http
  GET https://decorationDiyAPI.net/v1/user/userId/project
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `String` | **Required** |

##### Example of API call & response

<img><img width="1164" alt="Pasted Graphic 11" src="https://user-images.githubusercontent.com/103580674/226640852-adc73280-34dd-4cfe-bbf6-778c345addca.png">
</img>



#### Create user

```http
  POST https://decorationDiyAPI.net/v1/user
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `None` | `None` | `None` |

##### Example of API call & response

<img><img width="1082" alt="Pasted Graphic" src="https://user-images.githubusercontent.com/103580674/226641171-9fde9075-38bf-43b8-8feb-5b70355c37c6.png">
</img>



#### Update user

```http
  PUT https://decorationDiyAPI.net/v1/user/userId
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `String` | **Required** |

##### Example of API call & response

<img><img width="1088" alt="Pasted Graphic 5" src="https://user-images.githubusercontent.com/103580674/226641395-9084a774-65a4-4344-a40c-40e1dbdf7fc6.png">
</img>



#### Delete user

```http
  DELETE https://decorationDiyAPI.net/v1/user/userId
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `String` | **Required** |


#### Upload & update user's picture

```http
  POST https://decorationDiyAPI.net/v1/user/userId/image
  PUT  https://decorationDiyAPI.net/v1/user/userId/image
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `String` | **Required** |

### Diy project object

| Attribute Name | Type  |  Description   |
| :-------- | :------- | :------------------------- |
| `title` | `String` | **Required** |
| `description` | `String` | **Required** |
| `tools` | `String` | **Required** |
| `materials` | `String` | **Required** |
| `time` | `String` | **Required** |
| `instructions` | `String` | **Required** |
| `publisher` | `User` | the publisher of this project |
| `imageURL` | `String` | Optional |
| `videoURL` | `String` | Optional |


#### Get all project

```http
  GET https://decorationDiyAPI.net/v1/project
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `None` | `None` | `None` |

##### Example of API call & response

<img><img width="1186" alt="image" src="https://user-images.githubusercontent.com/103580674/226641771-9a7e342e-bf94-4167-b44b-563aa5c5ed64.png">
</img>



#### Create project

```http
  POST https://decorationDiyAPI.net/v1/project
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `None` | `None` | `None` |

##### Example of API call & response

<img><img width="1082" alt="Pasted Graphic 7" src="https://user-images.githubusercontent.com/103580674/226642237-77289d8e-b51b-4838-823f-53dfe099342d.png">
</img>



#### Update project

```http
  PUT https://decorationDiyAPI.net/v1/project/projectId
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `String` | **Required** |

##### Example of API call & response

<img><img width="1081" alt="Pasted Graphic 10" src="https://user-images.githubusercontent.com/103580674/226642447-7b535634-b692-4621-84b2-bc90a552d036.png">
</img>



#### Delete project

```http
  DELETE https://decorationDiyAPI.net/v1/project/projectId
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `String` | **Required** |


#### Upload & update project's image

```http
  POST https://decorationDiyAPI.net/v1/project/projectId/image
  PUT  https://decorationDiyAPI.net/v1/project/projectId/image
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `String` | **Required** |

#### Upload & update project's video

```http
  POST https://decorationDiyAPI.net/v1/project/projectId/video
  PUT  https://decorationDiyAPI.net/v1/project/projectId/video
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `String` | **Required** |

## Deprecation policy
We will announce if we intend to discontinue or make a backwards-incompatible change to the API. For all publicly documented fields and endpoints, we will announce any changes via Git hub  with at least 3 weeks of notice.  For endpoints, we will also return a Warning header during the deprecation period.

For any non-publicly documented fields or endpoints, we may make changes to these with no warning. Therefore, we suggest only using the fields and endpoints that are identified in the documentation below.
## Authors

- [@zahraMajed](https://github.com/zahraMajed)
- [@HindAlmaaz](https://github.com/HindAlmaaz)
- [@Razan24](https://github.com/Razan24)
