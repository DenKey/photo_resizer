Enroll user device

```
curl -X POST \
   http://localhost:3000/api/user_enrollment \
   -H 'accept: version=1' \
   -H 'cache-control: no-cache' \
   -H 'content-type: application/json' \
   -d '{"enroll": {"email": "test@gmail.com", "password": "password"}}'
```


Get user JWT token

```
curl -X POST \
  http://localhost:3000/api/user_token \
  -H 'accept: version=1' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{"auth": {"email": "test@gmail.com", "password": "password"}}'
```

Upload some photo, set correct data for VALID_JWT_TOKEN and VALID_BASE64_IMAGE before

```
curl -X POST \
  http://localhost:3000/api/images \
  -H 'accept: version=1' \
  -H 'authorization: Bearer VALID_JWT_TOKEN' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{"file": {"width": "300", "height": "300", "filename": "some.jpg", "data": VALID_BASE64_IMAGE}}'
```

Show users images, set correct data for VALID_JWT_TOKEN before

```
curl -X GET \
  http://localhost:3000/api/images \
  -H 'accept: version=1' \
  -H 'authorization: Bearer VALID_JWT_TOKEN' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
```

Show user image, set correct data for VALID_JWT_TOKEN and IMAGE_ID before

```
curl -X GET \
  http://localhost:3000/api/images/IMAGE_ID \
  -H 'accept: version=1' \
  -H 'authorization: Bearer VALID_JWT_TOKEN' \
  -H 'cache-control: no-cache' \
```

Resize already loaded image, set correct data for VALID_JWT_TOKEN and IMAGE_ID before

```
curl -X PUT \
  http://localhost:3000/api/images/IMAGE_ID \
  -H 'accept: version=1' \
  -H 'authorization: Bearer VALID_JWT_TOKEN' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{"update" : {"width": "434", "height": "343"}}'
```
