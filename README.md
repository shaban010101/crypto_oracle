# Instructions on installing
1. The project requires ruby version 2.6.0 to be installed on your machine
2. To install the gems run `bundle install`
3. Set the API_KEY for Nomics in the terminal `export API_KEY=api-key`
3. To run the parser type this into the command line  `ruby app.rb`

## API endpoints

#### Endpoint

`GET /api/currencies`

#### Params

|Name|Description|Value|Required|Default|
|-------|---|-----|--------|-------|
|tickers|Cryptocurrency tickers|Array|N|N/A|
|page|Page number requested|Integer|N|1|
|per_page|Number of results per page|Integer (1..100)|N|100|

#### Example request 
`curl 'http://localhost:4567/api/currencies?tickers=BTC,ETH,SOL&interval=1d&page=1&per_page=100`

#### Response

`HTTP/1.1 200 OK`

`[
   {"name":"Bitcoin","symbol":"BTC","price":"47940.66314462","circulating_supply":"18834206","max_supply":"21000000"},
   {"name":"Ethereum","symbol":"ETH","price":"3375.32868752","circulating_supply":"117786759","max_supply":null},
   {"name":"Solana","symbol":"SOL","price":"169.23639134","circulating_supply":"297839900","max_supply":"488630611"}
]
`

#### Error response
`HTTP/1.1 422 Unprocessable Entity` 

`{"errors":["Per page must be less than or equal to 100"]}`

#### Endpoint

`GET /api/currencies/fiat`

#### Params

|Name|Description|Value|Required|Default|
|----|-----|-----|--------|----|
|fiat_currency|Fiat currency to convert to|String|N|USD|
|crypto_currency|Cryptocurrency to convert from|String|N|BTC|

####Example request 
`curl 'http://localhost:4567/api/currencies/fiat?fiat_currency=USD&crypto_currency=ETH'`

#### Response
`HTTP/1.1 200 OK`

`{"fiat_price":"3352.28562122","currency":"USD"}`

#### Endpoint
`GET /api/currencies/calculate`

#### Params

|Name|Description|Value|Required|Default|
|----|-----|-----|--------|----|
|from|Cryptocurrency to compare from|String|Y|none|
|to|Cryptocurrency to compare to|String|Y|none|

#### Example request 
`curl 'http://localhost:4567/api/currencies/calculate?from=ETH&to=HOKK'`

#### Response 
`HTTP/1.1 200 OK`

`{"1 ETH":"25251216945632.285 HOKK"}`

#### Error response 
`HTTP/1.1 422 Unprocessable Entity` 
`{"errors":["From/To values do not exist, please try values which do exist"]}`

##Notes
The project is using ruby 2.6.0 as I was unable to update it to a higher version on my machine

I have utilised service objects to handle as much of the business logic as possible, presenters to format the response outputted to the API and form objects to validate the API request parameters provided.