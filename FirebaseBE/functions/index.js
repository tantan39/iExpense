const functions = require("firebase-functions");
const fs = require('fs');
const jwt = require('jsonwebtoken');
const axios = require('axios');
const cors = require('cors')({ origin: true });

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

// const privateKey = fs.readFileSync('AuthKey_8X9P3HCL38.p8');
// const token = jwt.sign({
//   subject: 'com.tantt.weatherservice'
// }, privateKey, {
//   jwtid: 'FL29S3YYFY.com.tantt.weatherservice', 
//   issuer: 'FL29S3YYFY', 
//   expiresIn: '1hr', 
//   keyid: '8X9P3HCL38', 
//   algorithm: 'ES256',
//   header: {
//       id: 'FL29S3YYFY.com.tantt.weatherservice'
//   }
// });
// const url =
// "https://weatherkit.apple.com/api/v1/availability/37.323/122.032?country=US";

// const configuration = {
//   headers: { Authorization: `Bearer ${token}` },
// };

// exports.weatherAPI = functions.https.onRequest((req, resp) => {
//   // cors(req, res, () => {
//   //   return axios.get(url)
//   //   .then (r => {
//   //       print(r);
//   //       res.send(r.data);
//   //   })
//   //   .catch(e => {
//   //     print(e);
//   //     res.sendStatus(e);
//   //   })
//   // });

//   // resp.send("WeatherREST API");
//   cors(req, res, () => {
//     if (req.method !== "GET") {
//       return res.status(401).json({
//         message: "Not allowed"
//       });
//     }

//     return axios.get('https://api.ipify.org?format=json')
//       .then(response => {
//         console.log(response.data);
//         return res.status(200).json({
//           message: response.data.ip
//         })
//       })
//       .catch(err => {
//         return res.status(500).json({
//           error: err
//         })
//       })

//   })
// });

exports.checkIP = functions.https.onRequest((req, res) => {
  cors(req, res, () => {
    return axios.get('https://api.ipify.org?format=json')
      .then(response => {
        console.log(response.data);
        return res.send(response.data);
      })
      .catch(err => {
        console.log(err);
        return res.sendStatus(err);
      })

  })
});