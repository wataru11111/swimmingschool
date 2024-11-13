document.addEventListener("DOMContentLoaded", function () {
    const daySelect = document.getElementById("contact_dey");
    const timeSelect = document.getElementById("contact_time");

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
        console.log("選択された契約曜日:", selectedDay);
        timeSelect.innerHTML = ""; // 現在のオプションをクリア

        if (timeOptions[selectedDay]) {
            timeOptions[selectedDay].forEach(function (time) {
                const option = document.createElement("option");
                option.value = time;
                option.textContent = time;
                timeSelect.appendChild(option);
            });

            // 契約時間の初期値を設定
            const currentTime = timeSelect.getAttribute("data-current-time");
            if (currentTime) {
                timeSelect.value = currentTime;
            }
        } else {
            const defaultOption = document.createElement("option");
            defaultOption.value = "";
            defaultOption.textContent = "時間選択";
            timeSelect.appendChild(defaultOption);
        }
    }

    // 初期化処理
    updateContactTimeOptions();

    // 契約曜日変更時に契約時間を更新
    daySelect.addEventListener("change", updateContactTimeOptions);
});
