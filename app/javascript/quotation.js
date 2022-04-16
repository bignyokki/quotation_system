$(function() {
  console.log("イベント発火1");
  function createHTML(quotation) {
    let html = `<div class="quotation" id="note${quotation.id}">
                  <span class="quotation_title">${quotation.title}</span>
                </div>`
    return html;
  };
  $("#quotation_input").on("submit", function(e) {
    console.log("イベント発火2");
    e.preventDefault();  // デフォルトのイベント(HTMLデータ送信など)を無効にする
    let formData = new FormData(this);  // FormDataを作成
    let url = $(this).attr("action");   // デフォルトのイベント(HTMLデータ送信など)を無効にする
    $.ajax({
      url: url,  // リクエストを送信するURLを指定
      type: "POST",  // HTTPメソッドを指定（デフォルトはGET）
      data: formData,  //FormDataをそのまま渡せば良い（必要な"note[body]"と"authenticity_token"を含む）
      dataType: "json",  // レスポンスデータをjson形式と指定する
      processData: false,  //FormDataを使用した場合に必要となる
      contentType: false  //FormDataを使用した場合に必要となる
    })
    .done(function(data) {
      let html = createHTML(data);  // 受信したデータ(data)を元に追加するURLを生成(createHTML関数は冒頭で定義)
      $(".quotation").append(html);  // 生成したHTMLをappendメソッドでドキュメントに追加
      // $(".quotation_form").remove();
    })
    .fail(function() {
      alert("error!");  // 通信に失敗した場合はアラートを表示
    });
  });
});