import $ from "jquery";

$(() => {
  const form = $("form.js-plan-item")

  if (form.length > 0) {
    const checkBox =
      form.find("input[name='plan_item[all_day]'][type='checkbox']");

    const allDay = checkBox.prop("checked");
    console.log(allDay);
  }
});
