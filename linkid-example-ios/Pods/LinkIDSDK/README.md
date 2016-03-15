linkID iOS SDK
==============

Contains some utility classes for integrating linkID in iOS apps.

## Getting the linkID app to link back to your app

If you have successfully started a linkID authentication/payment session, you will have a linkID URL looking like this:

```
linkidmauthurl://MAUTH/3/Sb4Dyf/eA==
```

To let linkID link back to your app, you will need to define an URL handler to use.
Then you will need to append following callback query parameters to the linkID URL which the linkID client will use when an authentication/payment is cancelled, failed or successful.

* x-source		: The name that will be displayed in a button on the final screen 
* x-success		: The success URL linkID will use to return to your app
* x-error		: The error URL linkID will use to return to your app
* x-cancel		: The cancel URL linkID will use to return to your app

So adding these query parameters to the linkID URL will result in an URL as follows:

```
linkidmauthurl://MAUTH/3/Sb4Dyf/eA==?x-source=YourApp&x-success=yourapp%3A%2F%2Fsuccess&x-error=yourapp%3A%2F%2Ferror&x-cancel=yourapp%3A%2F%2Fcancel

```

To facilitate this there is an NSURL category in this pod:

**NSURL+LinkIDXCallback.h**