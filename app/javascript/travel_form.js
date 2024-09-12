document.addEventListener('DOMContentLoaded', function () {
  var formSegment = document.getElementById('form-segment');
  var fieldIndex = document.querySelectorAll('[id^="travel_form-code-"]').length; // 現在のフィールドの数をカウント

  // 新しいフィールドを追加する関数
  function addNewFields() {
    var newFieldsHTML = `
      <div class='form-text-wrap'>
        <label class="form-text">開始時間</label><span class="indispensable">必須</span>
      </div>
      <div class="field">
        <input type="time" name="travel_form[start_times][${fieldIndex}]" id="start-time-${Date.now()}" placeholder="10:00">
      </div>

      <div class='form-text-wrap'>
        <label class="form-text">終了時間</label><span class="indispensable">必須</span>
      </div>
      <div class="field">
        <input type="time" name="travel_form[end_times][${fieldIndex}]" id="end-time-${Date.now()}" placeholder="11:00">
      </div>

      <div class='form-text-wrap'>
        <label class="form-text">場所</label><span class="indispensable">必須</span>
      </div>
      <div class="field">
        <input type="text" name="travel_form[locations][${fieldIndex}]" id="location-${Date.now()}" placeholder="厳島神社">
      </div>

      <div class='form-text-wrap'>
        <label class="form-text">やること</label>
      </div>
      <div class="field">
        <input type="text" name="travel_form[descriptions][${fieldIndex}]" id="description-${Date.now()}" placeholder="お参りをする">
      </div>
    `;
    var newFieldsContainer = document.createElement('div');
    newFieldsContainer.innerHTML = newFieldsHTML;
    formSegment.appendChild(newFieldsContainer);
    fieldIndex++;
  }

  // 新しいフィールド追加ボタンのイベントリスナー
  var addFieldButton = document.getElementById('add-field-button');
  if (addFieldButton) {
    addFieldButton.addEventListener('click', addNewFields);
  }

  // 日にちを追加ボタンの作成と追加
  var addDateButton = document.createElement('button');
  addDateButton.type = 'button';
  addDateButton.textContent = '日にちを追加';
  formSegment.parentNode.insertBefore(addDateButton, formSegment.nextSibling);

  addDateButton.addEventListener('click', function () {
    var newDateFieldHTML = `
      <div class='form-text-wrap'>
        <label class="form-text">追加日</label><span class="indispensable">必須</span>
      </div>
      <div class="field">
        <input type="date" name="travel_form[additional_dates][${fieldIndex}]" id="additional-date-${Date.now()}" placeholder="追加日">
      </div>
    `;
    var newDateFieldContainer = document.createElement('div');
    newDateFieldContainer.innerHTML = newDateFieldHTML;
    formSegment.appendChild(newDateFieldContainer);
    fieldIndex++;
  });

  // 複製ボタンが存在する場合
  var duplicateButton = document.getElementById('duplicate-button');
  if (duplicateButton && formSegment) {
    duplicateButton.addEventListener('click', function () {
      var clonedSegment = formSegment.cloneNode(true);
      var autofocusedElements = clonedSegment.querySelectorAll('[autofocus]');
      autofocusedElements.forEach(element => element.removeAttribute('autofocus'));

      var elements = clonedSegment.querySelectorAll('[id]');
      elements.forEach(function (element) {
        var newId = element.id + '-' + Date.now();
        element.id = newId;
        if (element.name) {
          element.name = element.name.replace(/\[\d*\]/, '[' + fieldIndex + ']');
        }
      });
      fieldIndex++;
      formSegment.parentNode.insertBefore(clonedSegment, duplicateButton.parentNode);
    });
  }
});