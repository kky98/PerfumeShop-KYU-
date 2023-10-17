function inputCheck() //입력값 검사
{
    var str = document.regFrm.email.value;
    var atPos = str.indexOf('@');
    var atLastPos = str.lastIndexOf('@');
    var dotPos = str.indexOf('.');
    var spacePos = str.indexOf('');
    var commaPos = str.indexOf(',');
    var eMailSize = str.length;
    if (atPos > 1 && atPos == atLastPos && dotPos > 3 && spacePos == -1
            && commaPos == -1 && atPos + 1 < dotPos && dotPos + 1 < eMailSize)
        ;
    else {
        alert('E-mail 주소 형식이 잘못되었습니다. /n/r 다시 입력해주세요!');
        document.regFrm.email.focus();
        return;
        // 이메일 형식을 검사하는 부분입니다.
    }
 
 
    document.regFrm.submit();
}
 
function win_close() {
    self.close();
}