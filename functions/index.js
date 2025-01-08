const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.scheduleNotification = functions.pubsub
  .schedule("30 11 * * *") // Run daily at 11:30 AM
  .timeZone("Europe/London")
  .onRun(async (context) => {
    const message = {
      notification: {
        title: "Notification",
        body: "This is your daily reminder to see the joke of the day.",
      },
      topic: "all_users",
    };

    await admin.messaging().send(message);
    console.log("Notification sent at 11:30 AM!");
    return null;
  });
