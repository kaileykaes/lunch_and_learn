# README

## Introduction

This API accomplishes several learning goals involving API exposure. They are as follows: 
- To build understanding of and demonstrate ability to expose a variety of API endpoints for use by front end developers
- To use basic authentication
- To create endpoints that call for authentication tokens
- To expose endpoints for CRUD functionality
- To plan and complete an API to suit the needs of other developers
- To synthesize several external APIs to create yet another API
- To use TDD and a mocking tool to achieve all of the above

## Set-up

1. Fork this repository and clone it to your local machine in the directory it belongs. 
2. `cd` into the directory and run `bundle install` from the command line. 
3. To set up the database run:
```
rails db:{drop,create,migrate,seed}
```
4. Before you proceed, you'll need API keys for the various external APIs this API consumes. 
  - [Unsplash](https://unsplash.com/documentation)
  - [YouTube](https://developers.google.com/youtube/registering_an_application) 
     - Lunch and Learn uses the [search list endpoint](https://developers.google.com/youtube/v3/docs/search/list#usage) 
  - [Edamam](https://developer.edamam.com/edamam-docs-recipe-API)
    - Make sure you get an API key for the "Recipe Search" application. There are several. 
  - Rest Countries
    - You'll find documentation [here]((https://restcountries.com/)), but you won't need an API key. 

5. Lunch and learn uses the [figaro](https://github.com/laserlemon/figaro) gem to secure api keys. To set up figaro run this:
  ```
  bundle exec figaro install
  ```
  If this throws an error, don't fret. It's likely that this was unsuccessful in adding the yml file it created to your `.gitignore` file. Just verify that in your `config` directory you now have an `application.yml` file. If so, verify that your `.gitignore` file includes `/config/application.yml`, and add it if necessary. You're good to go. 

  In your application.yml file, you'll need to add your api keys as follows: 
  
  ``` 
    app_id: <Edamam app id>
    app_key: <Edamam app key>
    youtube_key: <YouTube API key>
    unsplash_access_key: <Unsplash access key> 
    unsplash_secret_key: <Unsplash secret key>
  ```
6. The first time you run the test suite with `bundle exec rspec`, [VCR](https://github.com/vcr/vcr) will record the API calls for replay later. There are two API endpoint usages that rely on randomized data. The tests for those are stubbed using [WebMock](https://github.com/bblimke/webmock)

## Endpoints
In order to hit the endpoints Lunch and Learn exposes, you'll need to spin up a server for it somewhere. It's not currently hosted anywhere. As such, only the URIs for the endpoints are listed.
The endpoints for this API are as follows: 

### Recipes Endpoints: 

```
/api/v1/recipes?country={country}
```
This endpoint returns JSON for a collection of recipes from the country searched: 
  ```
    {
      "data": [
          {
              "id": "null",
              "type": "recipe",
              "attributes": {
                  "url": "http://honestcooking.com/easter-in-croatia-and-traditional-easter-cake/",
                  "title": "Easter in Croatia and traditional Easter cake",
                  "country": "Croatia",
                  "image": <image url>
              }
          },
          {
              "id": "null",
              "type": "recipe",
              "attributes": {
                  "url": "https://www.epicurious.com/recipes/food/views/stuffed-red-bell-peppers-106226",
                  "title": "Stuffed Red Bell Peppers",
                  "country": "Croatia",
                  "image": <image url>
              }
          },
          {
              "id": "null",
              "type": "recipe",
              "attributes": {
                  "url": "http://www.jamieoliver.com/recipes/rice-recipes/croatian-style-cuttlefish-risotto/",
                  "title": "Croatian-style cuttlefish risotto",
                  "country": "Croatia",
                  "image": <image url>
              }
          }
        ...      
      ]
    }
    ```

```
/api/v1/recipes
```
If no country is passed in, a collection of recipes from a an arbitrary country will be returned in the same format as above. 

### Learning Resources Endpoints: 
```

```

