import $ from "jquery";

$(() => {
  const checkBox = $("#plan_item_all_day");

  if (checkBox.length > 0) {
    const allDay = checkBox.prop("checked");
    console.log(allDay);
  }
});
