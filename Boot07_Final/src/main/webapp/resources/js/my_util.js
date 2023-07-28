// webapp/js/my_util.js

function ajaxPromise(url, method, data) {
	if (method == undefined || method == null) {
		method = "GET";
	}
	if (data == undefined || data == null) {
		data = {};
	}

	let queryString;
	if (typeof data == "string") {
		queryString = data;
	} else {
		queryString = toQueryString(data);
	}

	let promise;
	//GET 방식 전송
	if (method == "GET" || method == "get") {
		promise = fetch(url + "?" + queryString);
	//POST 방식 전송
	} else if (method == "POST" || method == "post") {
		promise = fetch(url, {
			method: "POST",
			headers: { "Content-Type": "application/x-www-form-urlencoded; charset=utf-8" },
			body: queryString
		});
	}
	return promise;
}

//참조값을 ajax로 전송
function ajaxFormPromise(form) {
	const url = form.getAttribute("action");
	const method = form.getAttribute("method");

	let promise;
	
	if (form.getAttribute("enctype") == "multipart/form-data") {
		let data = new FormData(form);
		promise = fetch(url, {
			method: "post",
			body: data
		});
		return promise; 
	}

	const queryString = new URLSearchParams(new FormData(form)).toString();

	//GET 방식 전송
	if (method == "GET" || method == "get") {
		promise = fetch(url + "?" + queryString);
	//POST 방식 전송
	} else if (method == "POST" || method == "post") {
		promise = fetch(url, {
			method: "POST",
			headers: { "Content-Type": "application/x-www-form-urlencoded; charset=utf-8" },
			body: queryString
		});
	}
	return promise;
}

//url과 참조값 전송
function ajaxInputPromise(url, input) {
	const type = input.getAttribute("type");
	const name = input.getAttribute("name");

	let promise;
	if (type == "file") {

		let data = new FormData();
		data.append(name, input.files[0]);

		promise = fetch(url, {
			method: "post",
			body: data
		});
	} else {

		const data = name + "=" + encodeURIComponent(input.value);
		promise = fetch(url, {
			method: "POST",
			headers: { "Content-Type": "application/x-www-form-urlencoded; charset=utf-8" },
			body: data
		});
	}
	return promise;
}

//Object to QueryString
function toQueryString(obj) {
	let arr = [];
	for (let key in obj) {
		let tmp = key + "=" + encodeURIComponent(obj[key]);
		arr.push(tmp);
	}
	
	//query 문자열 리턴
	let queryString = arr.join("&");
	return queryString;
}