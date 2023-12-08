
function checkForm(){
	let form = document.member;
	let uid = form.uid.value;
	let passwd = form.passwd.value;
	let passwd2 = form.passwd2.value;
	let name = form.name.value;
	
	let regexPw1 = /[0-9]+/;
	let regexPw2 = /[a-zA-Z]+/;
	let regexPw3 = /[~!@#$%^&*()_+|]+/;
	
	let regex = /^[a-zA-Z가-힣]/;
	
	if(uid.length < 5 || uid.length > 12){
		alert("아이디는 5 ~ 12자까지 입력해주세요.");
		form.uid.focus();
		return false;
	}else if(passwd.length < 8 || !regexPw1.test(passwd) ||
				!regexPw2.test(passwd) || !regexPw3.test(passwd)){
		alert("영문자, 숫자, 특수문자 포함 7자 이상 입력해주세요.");
		form.passwd.select();
		return false;
	}else if(passwd != passwd2){
		alert("비밀번호를 동일하게 입력해주세요.");
		form.passwd2.select();
		return false;
	}else if(!regex.test(name)){
		alert("이름은 숫자로 시작할 수 없습니다.");
		form.name.select();
		return false;
	}else
		form.submit();
}