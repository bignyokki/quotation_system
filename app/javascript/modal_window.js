$(document).on('turbolinks:load', function() {

  // #modal-openをクリックしてモーダルウィンドウを表示
  $("#modal-open").on('click',function(){

      // #modal-overlayをフェードイン(display: none; → block;)させる
      $("#modal-overlay").fadeIn("slow");

  });

  // キャンセルボタンかオーバーレイ部をクリックでモーダルウィンドウ削除
  $("#modal-close,#modal-overlay").on('click',function(){

    // #modal-overlayをフェードアウト(display: block; → none;)する
    $("#modal-overlay").fadeOut("slow");

  });

  // 削除ボタンを押すとitemを削除
  $("#modal-delete").on('click',function(){

    // 表示されていない削除のためのlink_toをクリックする
    document.getElementById("item-delete").click();

  });

});