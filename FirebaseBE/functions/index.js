const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.api = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});

exports.scheduledFunction = functions.pubsub
.schedule('* * * * *')
.onRun(context => {
    console.log('I am running every minutes ....');
    return null;
});