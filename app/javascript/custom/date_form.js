document.addEventListener('DOMContentLoaded', function () {
  // 現在のURLパスを取得
  const currentPath = window.location.pathname;

  // "index.html.erb" のみで動作させる
  if (currentPath !== '/date') {
      return; // 他のページではスクリプトを実行しない
  }

  const contactDeySelect = document.getElementById('contact_dey');
  const contactTimeSelect = document.getElementById('contact_time');

  // 要素が見つからない場合、エラーを表示して処理を終了
  if (!contactDeySelect || !contactTimeSelect) {
      console.error("必要な要素 (contact_dey または contact_time) が見つかりませんでした。");
      return; // 処理を中断
  }

  // 曜日ごとの時間オプションを設定
  const timeOptions = {
      "土曜日": [["16:00", "16:00"], ["17:00", "17:00"], ["18:00", "18:00"]],
      "日曜日": [["12:00", "12:00"], ["13:00", "13:00"], ["14:00", "14:00"], ["17:00", "17:00"]],
  };

  // 時間オプションを更新する関数
  function updateTimeOptions() {
      const selectedDay = contactDeySelect.value; // 選択された曜日を取得
      contactTimeSelect.innerHTML = ""; // 既存のオプションをクリア

      if (timeOptions[selectedDay]) {
          // 選択された曜日のオプションを生成
          timeOptions[selectedDay].forEach(([value, label]) => {
              const option = document.createElement("option");
              option.value = value;
              option.textContent = label;
              contactTimeSelect.appendChild(option);
          });
      } else {
          // デフォルトの「時間選択」オプションを表示
          const defaultOption = document.createElement("option");
          defaultOption.value = "";
          defaultOption.textContent = "時間選択";
          contactTimeSelect.appendChild(defaultOption);
      }
  }

  // 初期化：ページ読み込み時にオプションを設定
  updateTimeOptions();

  // 曜日選択変更時にオプションを更新
  contactDeySelect.addEventListener("change", updateTimeOptions);
});
