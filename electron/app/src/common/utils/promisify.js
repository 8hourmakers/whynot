function promisify(fn) {
    return (...args) => new Promise((resolve, reject) => {
        const callback = (err, ...results) => {
            if (err) reject(err);
            else if (results.length === 1) resolve(results[0]);
            else resolve(results);
        };

        fn(...args.concat(callback));
    });
}

module.exports = promisify;
