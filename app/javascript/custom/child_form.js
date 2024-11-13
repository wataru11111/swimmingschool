document.addEventListener("DOMContentLoaded", function () {
    // 現在のURLパスを取得
    const currentPath = window.location.pathname;

    // 'child/new' ページ以外ではスクリプトを実行しない
    if (!currentPath.includes('/child/new')) {
        console.log("child_form.js: 対象外のページです。スクリプトを実行しません。");
        return;
    }

    const daySelect = document.getElementById("child_contact_dey");
    const timeSelect = document.getElementById("child_contact_time");

    console.log("daySelect:", daySelect);
    console.log("timeSelect:", timeSelect);

    if (!daySelect || !timeSelect) {
        console.error("contact_dey または contact_time が見つかりませんでした。");
        return; // 処理を中断
    }

    const timeOptions = {
        水曜日: ["14:30", "15:15", "19:30"],
        木曜日: ["14:30", "15:00"],
        土曜日: ["16:00", "17:00", "18:00"],
        日曜日: ["12:00", "13:00", "14:00", "17:00"],
    };

    function updateContactTimeOptions() {
        const selectedDay = daySelect.value;
        timeSelect.innerHTML = "";

        if (timeOptions[selectedDay]) {
            timeOptions[selectedDay].forEach(function (time) {
                const option = document.createElement("option");
                option.value = time;
                option.textContent = time;
                timeSelect.appendChild(option);
            });
        } else {
            const defaultOption = document.createElement("option");
            defaultOption.value = "";
            defaultOption.textContent = "時間選択";
            timeSelect.appendChild(defaultOption);
        }
    }

    // 初期化
    updateContactTimeOptions();
    // イベントリスナー追加
    daySelect.addEventListener("change", updateContactTimeOptions);
});