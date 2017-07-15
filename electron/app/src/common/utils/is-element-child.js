const { toLower } = require('lodash');

const toSelector = (elem) => {
    let selector = '';

    const tagName = toLower(elem.tagName);
    const attributes = elem.attributes;

    selector += tagName;

    for (let idx = 0; idx < attributes.length; idx += 1) {
        const attr = attributes.item(idx);
        const attrName = attr.name;

        if (attr.value === '') {
            selector += `[${attrName}]`;
        } else {
            selector += `[${attrName}="${attr.value}"]`;
        }
    }

    return selector;
};

function isElementContains(sourceElem, targetElem) {
    const isTargetSameWithSource = sourceElem === targetElem;
    const isSourceContainsTarget = sourceElem.querySelector(toSelector(targetElem)) !== null;

    return isTargetSameWithSource || isSourceContainsTarget;
}

module.exports = isElementContains;
