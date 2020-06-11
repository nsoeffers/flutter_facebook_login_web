# flutter_facebook_login_web

A Web implementation of the flutter_facebook_login component.

## Getting Started

Flutter supports multiple platforms. It can generate an application for the Android platform. The iOS platform.
But also for the web. Unfortunately at the time of writing the flutter_facebook_login did not support the web platform yet.
So if you generated a web application and use the flutter_facebook_login the facebook login button wil not work in the web app.
This project wants to provide a workaround for this issue.

Because of some constraints of the flutter/dart platform. You do have to include the following javascript snippet into your index.html file.
This is the standard javascript code to initialize the official Facebook API.

```
     <!-- Initialize Facebook api -->
     <script>
       window.fbAsyncInit = function() {
         FB.init({
           appId      : '306867013634994',
           xfbml      : true,
           version    : 'v7.0'
         });
         FB.AppEvents.logPageView();
       };

       (function(d, s, id){
          var js, fjs = d.getElementsByTagName(s)[0];
          if (d.getElementById(id)) {return;}
          js = d.createElement(s); js.id = id;
          js.src = "https://connect.facebook.net/en_US/sdk.js";
          fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
     </script>
 ```