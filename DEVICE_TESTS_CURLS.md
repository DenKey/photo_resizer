Enroll device

```
curl -X POST \
  http://localhost:3000/api/device_enrollment \
  -H 'accept: version=2' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{ "enroll": { "advertising_identifier": "dsadsds", "imei": "imasdasd", "meid": "dsdasd" } }'
```

Upload some photo, set correct data for DEVICE_TOKEN and VALID_BASE64_IMAGE before

```
curl -X POST \
  http://localhost:3000/api/images \
  -H 'accept: version=2' \
  -H 'authorization: DEVICE_TOKEN ' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{"file": {"width": "300", "height": "300", "filename": "some.jpg", "data": VALID_BASE64_IMAGE}}'
```

Show users images, set correct data for DEVICE_TOKEN before

```
curl -X GET \
  http://localhost:3000/api/images \
  -H 'accept: version=2' \
  -H 'authorization: DEVICE_TOKEN ' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
```

Show user image, set correct data for DEVICE_TOKEN  and IMAGE_ID before

```
curl -X GET \
  http://localhost:3000/api/images/IMAGE_ID \
  -H 'accept: version=2' \
  -H 'authorization: DEVICE_TOKEN' \
  -H 'cache-control: no-cache' \
```

Resize already loaded image, set correct data for DEVICE_TOKEN  and IMAGE_ID before

```
curl -X PUT \
  http://localhost:3000/api/images/IMAGE_ID \
  -H 'accept: version=2' \
  -H 'authorization: DEVICE_TOKEN ' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{"update" : {"width": "434", "height": "343"}}'
```
