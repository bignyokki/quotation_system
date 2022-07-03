$(function() {

  // #modal-openがクリックされたらモーダルウィンドウを表示
  $("#modal-open").on('click',function(){

      // #modal-overlayをフェードイン(display: none; → block;)させる
      $("#modal-overlay").fadeIn("fast");

  });

  // キャンセルボタンかオーバーレイ部をクリックでモーダルウィンドウ削除
  $("#modal-close,#modal-overlay").on('click',function(){

    // #modal-overlayをフェードアウト(display: block; → none;)する
    $("#modal-overlay").fadeOut("fast");

  });

  // 削除ボタンを押すとitemを削除
  $("#modal-delete").on('click',function(){

    // 非表示の削除用link_toをクリックする
    document.getElementById("item-delete").click();

  });

});