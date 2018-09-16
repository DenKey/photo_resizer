We are creating a mobile app that allows a user to resize uploaded photos. You need to create a backend server that will provide API for this app.

The main app functions:

- The user can use the mobile app to upload an image and pass resize parameters. In response, they will receive resized image
- User can see a list of their earlier resized images with resizing results and resizing parameters
- User can resize old image one more time passing old image id and new resize parameters
- When new user starts using a mobile app, the app sends a request to the server for a unique key which is used to subscribe user requests.
- API has to return information about all errors in proper format for invalid user inputs.
- All images should be returned as link to image and width and height values.
- We will need to handle different app versions for different clients. That&#39;s why we need an API versioning mechanism.

**Requirements**

- You need to implement backend and create API format with API documentation
- You can use any language and any framework of your choice as well as third party libraries.
- You need to use noSql database
- Results should be presented in form of a GitHub repository

**We will rate**

- technology stack choice
- code quality
- git workflow
- test coverage

Before you start, please provide a list of technologies you will use and an estimate (how long it will take you to complete the task).
