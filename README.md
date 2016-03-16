linkID iOS Example
==================

This example app shows how to integration linkID into an iOS app.

The example works out of the box making use of a [linkID example REST](https://github.com/link-nv/linkid-example-rest) service.

If you wish to try this app out against your own REST service, update the initialization of the LinkIDWSController class [here](https://github.com/link-nv/linkid-example-ios/blob/master/linkid-example-ios/linkid-example-ios/LIAppDelegate.m)

```
    [LinkIDWSController initialize:@"https://<your-host>/restv1/linkid"];
```

## Sequence diagram

![Sequence diagram](https://raw.githubusercontent.com/link-nv/linkid-sdk/master/images/linkid-sync.png)
