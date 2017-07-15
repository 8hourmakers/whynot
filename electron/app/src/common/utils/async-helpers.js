async function asyncForEach(items, asyncIterator) {
    const asyncTasks = [];

    items.forEach((item, idx) => {
        asyncTasks.push(asyncIterator(item, idx));
    });

    return Promise.all(asyncTasks);
}

module.exports = {
    asyncForEach,
};
