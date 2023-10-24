importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyBGKmepDDKHF0-fEdC2c1Ndi8Oqvpf3-gg",
  authDomain: "chopstore-347c2.firebaseapp.com",
  projectId: "chopstore-347c2",
  storageBucket: "chopstore-347c2.appspot.com",
  messagingSenderId: "489455038753",
  appId: "1:489455038753:web:06ffc748d0b9a4617a0e60",
  measurementId: "G-996BHHJ9KN"
  databaseURL: "https://hope-gaming-default-rtdb.firebaseio.com/",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});