# Apollo server

To run the application locally follow the next steps, inside this repository:
1. `npm i` to install the required node packages.
2. `npm start` to start the Apollo server. The application will be available on the URL: http://localhost:4000/

## Dependencies

- `node` @18.12.1
- `npm` @v8.19.2

## Example query

Navigate to the instance of your Apollo server on a browser and copy the following text into the `Operation` section to retreive the example entities on the hardcoded database:
```
query GetBooks {
  books {
    title
    author
  }
}
```
