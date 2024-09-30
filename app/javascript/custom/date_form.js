document.addEventListener('DOMContentLoaded', function() {
    const contactDeySelect = document.getElementById('contact_dey');
    const contactTimeSelect = document.getElementById('contact_time');
  
    if (contactDeySelect) {
      contactDeySelect.addEventListener('change', function() {
        const day = contactDeySelect.value;
  
        // 時間オプションをクリア
        contactTimeSelect.innerHTML = '';
  
        let timeOptions = [];
  
        if (day === '日曜日') {
          timeOptions = [["12:00", "12:00"], ["13:00", "13:00"], ["14:00", "14:00"], ["17:00", "17:00"]];
        } else if (day === '土曜日') {
          timeOptions = [["16:00", "16:00"], ["17:00", "17:00"], ["18:00", "18:00"]];
        }
  
        // オプションを追加
        timeOptions.forEach(function(option) {
          const opt = document.createElement('option');
          opt.value = option[0];
          opt.textContent = option[1];
          contactTimeSelect.appendChild(opt);
        });
      });
    } else {
      console.error("contact_dey 要素が見つかりませんでした。");
    }
  });
  