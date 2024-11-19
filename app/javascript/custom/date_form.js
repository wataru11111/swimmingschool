function initializeDateFormScripts() {
    const currentPath = window.location.pathname;
  
    if (currentPath !== "/date") {
      return;
    }
  
    const contactDeySelect = document.getElementById("contact_dey");
    const contactTimeSelect = document.getElementById("transfer_time");
  
    if (!contactDeySelect || !contactTimeSelect) {
      console.error("必要な要素 (contact_dey または transfer_time) が見つかりませんでした。");
      return;
    }
  
    const timeOptions = {
      土曜日: [["16:00", "16:00"], ["17:00", "17:00"], ["18:00", "18:00"]],
      日曜日: [["12:00", "12:00"], ["13:00", "13:00"], ["14:00", "14:00"], ["17:00", "17:00"]],
    };
  
    function updateTimeOptions() {
      const selectedDay = contactDeySelect.value;
      contactTimeSelect.innerHTML = "";
  
      if (timeOptions[selectedDay]) {
        timeOptions[selectedDay].forEach(([value, label]) => {
          const option = document.createElement("option");
          option.value = value;
          option.textContent = label;
          contactTimeSelect.appendChild(option);
        });
      } else {
        const defaultOption = document.createElement("option");
        defaultOption.value = "";
        defaultOption.textContent = "時間選択";
        contactTimeSelect.appendChild(defaultOption);
      }
    }
  
    updateTimeOptions();
    contactDeySelect.addEventListener("change", updateTimeOptions);
  }
  
  // TurboとDOMContentLoadedの両方で実行
  document.addEventListener("DOMContentLoaded", initializeDateFormScripts);
  document.addEventListener("turbo:load", initializeDateFormScripts);
  