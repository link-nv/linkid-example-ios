linkID iOS Example
==================

Example iOS app showing how linkID can be integrated in your iOS app.

To tryout this app, you'll need to run the [linkID REST example webapp](https://github.com/link-nv/linkid-example-rest). Simply build this webapp with maven and drop it in your servlet container of your choice.

Once you have this webapp up and running, change the REST path in **LIStore.m** to point to your webapp

```
#define REST_URL    @"http://192.168.0.199:9090/restv1"
```

**NOTE** that the example REST webapp and so by consequence the iOS example app are configured to talk to the [demo linkID environment](https://demo.linkid.be)
The linkID for mobile iOS production app in the appstore **cannot** be used with this environment. You will need a demo linkID iOS app for this.

Contact someone from the linkID development team to get access to this client which is distributed via [Testflight](http://testflightapp.com)

## Sequence diagram

![Sequence diagram](https://raw.githubusercontent.com/link-nv/linkid-example-ios/master/ios-linkid-flow.png)