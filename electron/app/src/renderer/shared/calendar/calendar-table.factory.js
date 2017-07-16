const { Injectable } = require('@angular/core');
const moment = require('moment');
const { divide, floor, padStart, pullAll, range } = require('lodash');
const dateHelpers = require('../../../common/utils/date-helpers');


class CalendarTable {
    constructor(year, month) {
        this.year = year;
        this.month = month;

        this.items = [];
    }

    getFirstDate() {
        const firstDate = moment()
            .year(this.year)
            .month(this.month - 1)
            .date(1);

        dateHelpers.unifyDate(firstDate);

        return firstDate;
    }

    getTitle() {
        return `${this.year}.${padStart(this.month, 2, '0')}`;
    }

    render() {
        pullAll(this.items, this.items);

        const firstDate = this.getFirstDate();
        const dayOfFirstDate = firstDate.day();
        const maxDays = firstDate.endOf('month').date();

        const firstRowCellsCount = 7 - dayOfFirstDate;
        const middleRowsCount = floor(divide(maxDays - firstRowCellsCount, 7));
        const lastRowCellsCount = maxDays - (firstRowCellsCount + (middleRowsCount * 7));

        const headDate = this.getFirstDate();

        this.renderFirstRow(headDate, firstRowCellsCount);

        for (let i = 0; i < middleRowsCount; i += 1) {
            this.renderMiddleRow(headDate);
        }

        this.renderLastRow(headDate, lastRowCellsCount);

        return this;
    }

    renderFirstRow(headDate, cellsCount) {
        const row = {
            type: 'first',
            cells: [],
        };

        this.insertBlankCells(row, 7 - cellsCount);

        for (let i = 0; i < cellsCount; i += 1) {
            const cell = this.makeCell(headDate);

            row.cells.push(cell);
            headDate.add(1, 'days');
        }

        this.items.push(row);
    }

    renderMiddleRow(headDate) {
        const row = {
            type: 'middle',
            cells: [],
        };

        for (let i = 0; i < 7; i += 1) {
            const cell = this.makeCell(headDate);

            row.cells.push(cell);
            headDate.add(1, 'days');
        }

        this.items.push(row);
    }

    renderLastRow(headDate, cellsCount) {
        const row = {
            type: 'last',
            cells: [],
        };

        for (let i = 0; i < cellsCount; i += 1) {
            const cell = this.makeCell(headDate);

            row.cells.push(cell);
            headDate.add(1, 'days');
        }

        this.insertBlankCells(row, 7 - cellsCount);

        this.items.push(row);
    }

    insertBlankCells(row, count) {
        range(count).forEach(() => {
            row.cells.push({
                date: null,
                isBlank: true
            });
        });
    }

    compareWithToday(mDate) {
        const today = moment();

        dateHelpers.unifyDate(today);
        dateHelpers.unifyDate(mDate);

        if (mDate.isBefore(today)) {
            return 'before';
        } else if (mDate.isAfter(today)) {
            return 'after';
        }

        return 'same';
    }

    makeCell(mDate) {
        const compareWithToday = this.compareWithToday(mDate);

        return {
            date: moment(mDate),
            compareWithToday,
            isBlank: false,
            dateStr: mDate.date()
        };
    }
}

CalendarTable.annotations = [
    new Injectable()
];

module.exports = CalendarTable;
