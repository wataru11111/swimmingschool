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
import "../stylesheets/application";
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
