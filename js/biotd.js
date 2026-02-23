'use strict'

const http = require('node:http');
const https = require('node:https');
const bingh = "https://www.bing.com";
const hpImg = "/HPImageArchive.aspx";
const jsQue = "?format=js&idx=1&n=1&mkt=en-US";
const port = 3000;
const hostname = 'localhost';

const renderDate = (yyyymmdd, cLink) => {
	return (
`<p><a href="${cLink}">${yyyymmdd}</a></p>`
	);
};

const renderThmb = (imgSrc) => {
	return (
`<a href="${imgSrc}">
  <img src="${imgSrc}" width="20%">
</a>`
	);
};

const renderCred = (credText) => {
	return (
`<p style="font-size: 0.8rem;">${credText}</p>`
	);
};

// prepare many things for past days of this month, from sqlite db

https.get(bingh + hpImg + jsQue, (res) => {
	let jstr = '';
	res.on('data', (data) => {
		jstr += data;
	});
	res.on('end', () => {
		// write something to add the 'jstr' to sqlite db
		http.createServer(function(request, response) {
			// Ultimately mvc print a calendar for current month and insert
			// the relevant data from jstr into today's date on the calendar grid
			// and have functionality to do other months drawing from sqlite.
			const imgs0 = JSON.parse(jstr).images[0];
			const today = imgs0.startdate;
			const u2day = bingh + imgs0.url;
			const c2day = imgs0.copyright.slice(0, -1).replace(/\(./, '<br>&#xA9;');
			const q2day = imgs0.copyrightlink;
			response
				.writeHead(200, {
					'Content-Type': 'text/html',
				})
				.end([
					renderDate(today, q2day),
					renderThmb(u2day),
					renderCred(c2day),
				].join('\n'), 'utf-8');
		}).listen(port, hostname, () => {
			console.log(`Server running at http://${hostname}:${port}/`);
		});
	});
});