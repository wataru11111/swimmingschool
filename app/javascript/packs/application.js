// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// 必要なライブラリをインポート
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application.scss";
import "../custom/date_form";
import "../custom/child_form";
import "../custom/child_edit_form";

import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";

// カレンダーの初期化
function initializeCalendar() {
  const calendarEl = document.getElementById("calendar");
  if (calendarEl) {
    const calendar = new Calendar(calendarEl, {
      plugins: [dayGridPlugin],
    });
    calendar.render();
  }
}

// turbolinks:load イベントに対応
document.addEventListener("turbolinks:load", initializeCalendar);

// フォーカス時のスクロール調整
document.querySelectorAll('input, select, textarea').forEach((element) => {
  element.addEventListener('focus', (event) => {
    setTimeout(() => {
      event.target.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }, 300); // ソフトキーボード表示後の調整
  });
});

// フォーカス時の余白調整（ソフトキーボード対応）
document.addEventListener("focusin", (event) => {
  // フォームが入力中の場合、キーボード表示に対応
  if (event.target.tagName === "INPUT" || event.target.tagName === "TEXTAREA") {
    document.body.style.paddingBottom = "300px"; // ソフトキーボード分の余白を追加
  }
});

document.addEventListener("focusout", () => {
  // フォーカスが外れたら余白をリセット
  document.body.style.paddingBottom = "0px";
});
