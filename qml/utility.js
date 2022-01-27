function millisecToPlaytime(millisec) {
    return Math.floor(millisec / 60000) + ":" + ("0" + Math.floor((millisec % 60000) / 1000)).slice(-2)
}

function secToPlaytimeHourFormat(sec) {
    return Math.floor(sec / 3600) + " hr " + ("0" + Math.floor((sec % 3600) / 60)).slice(-2) + " min"
}
