function deleteHistory() {
    const tbodyHistoryId = document.getElementById("historyId");
    let historyId = tbodyHistoryId.innerText;
    historyId = parseInt(historyId);

    console.log(historyId);
    alert(historyId);

    historyList.method = "post";
    historyList.action = "history.jsp";
    historyList.submit();    // 자바스크립트에서 서블릿으로 전송
}

function fillNewText() {
    const resultNum = document.getElementById("newText");
    let newText = resultNum.innerText;

    newText = parseInt(newText) + 1;

    resultNum.innerText = newText;
}