linkID iOS Example
==================

Example iOS app showing how linkID can be integrated in your iOS app.

To tryout this app, you'll need to run the [linkID REST example webapp](https://github.com/link-nv/linkid-example-rest). Simply build this webapp with maven and drop it in your servlet container of your choice.

Once you have this webapp up and running, change the REST path in **LIStore.m** to point to your webapp

```
#define REST_URL    @"http://192.168.0.199:9090/restv1"
```
