function initializeChildEditFormScripts() {
    const currentPath = window.location.pathname;

    // '/child/:id/edit' のパスだけでスクリプトを実行する
    const childEditPathRegex = /^\/child\/\d+\/edit$/;
    if (!childEditPathRegex.test(currentPath)) {
        console.log("child_edit_form.js: 対象外のページです。スクリプトを実行しません。");
        return;
    }

    const daySelect = document.getElementById("contact_dey");
    const timeSelect = document.getElementById("contact_time");

    if (!daySelect || !timeSelect) {
        console.error("contact_dey または contact_time が見つかりませんでした。");
        return;
    }

    const timeOptions = {
        水曜日: ["14:30", "15:15", "19:30"],
        木曜日: ["14:30", "15:00"],
        土曜日: ["16:00", "17:00", "18:00"],
        日曜日: ["12:00", "13:00", "14:00", "17:00"],
    };

    function updateContactTimeOptions() {
        const selectedDay = daySelect.value;
        timeSelect.innerHTML = ""; // 現在のオプションをクリア

        if (timeOptions[selectedDay]) {
            timeOptions[selectedDay].forEach(function (time) {
                const option = document.createElement("option");
                option.value = time;
                option.textContent = time;
                timeSelect.appendChild(option);
            });

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

    updateContactTimeOptions();
    daySelect.addEventListener("change", updateContactTimeOptions);
}

// TurboとDOMContentLoadedの両方で実行
document.addEventListener("DOMContentLoaded", initializeChildEditFormScripts);
document.addEventListener("turbo:load", initializeChildEditFormScripts);
