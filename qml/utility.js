.pragma library
.import "md5.js" as MD5

function millisecToPlaytime(millisec) {
    return Math.floor(millisec / 60000) + ":" + ("0" + Math.floor((millisec % 60000) / 1000)).slice(-2)
}

function secToPlaytimeHourFormat(sec) {
    return Math.floor(sec / 3600) + " hr " + ("0" + Math.floor((sec % 3600) / 60)).slice(-2) + " min"
}

function randomInt(min, max) {
    return Math.floor(Math.random() * (max - min)) + min;
}
  
function generateRandomSalt(length) {
    var min = Math.pow(2,32);
    var max = Math.pow(2,33)-1;
    console.log("length:", length,"min:", min, "max:", max);
    return MD5.rhex(randomInt(min,max)).substr(0,length);
}

function getToken(password, salt) {
    var token = MD5.calcMD5(password+salt);
    return token;
}
