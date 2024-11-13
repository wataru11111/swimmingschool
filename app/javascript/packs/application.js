// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"



import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";
import "../custom/date_form";// ここでカスタムスクリプトをインポートする
import "../custom/child_form"; // 上記JSファイルのパスに合わせて変更
import "../custom/child_edit_form";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import {Calendar} from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';

document.addEventListener('turbolinks:load', function () {
    const calendarEl = document.getElementById('calendar');
    if (calendarEl) {  // 要素が存在する場合のみ初期化
        const calendar = new Calendar(calendarEl, {
            plugins: [dayGridPlugin]
        });
        calendar.render();
    }
});
