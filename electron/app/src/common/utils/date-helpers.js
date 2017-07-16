function unifyDate(mDate) {
    mDate.hour(12).minute(0).second(0).millisecond(0);
}

module.exports = {
    unifyDate
};
