Url : https://developers.google.com/oauthplayground/

Paste it in search field 
https://www.googleapis.com/auth/firebase.messaging
then tap on Authorization Api Button
then tap on Exchange authorization code for tokens Button to getting Refresh & Access token

then Paste this https://fcm.googleapis.com/v1/projects/YOUR_PROJECT_ID/messages:send link in Request Url Field
Change the Request method to POST Request.
Content-Type application/json

Enter Request Body : 
{
   "message":{
      "token":"FCM_TOKEN",
      "data":{},
      "notification":{
        "title":"FCM Message",
        "body":"This is an FCM notification message!"
      }
   }
}

then tap on Send the Request Button
